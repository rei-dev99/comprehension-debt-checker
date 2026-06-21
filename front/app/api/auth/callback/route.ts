import { NextResponse } from "next/server";
import { createBackendJwt } from "@/app/lib/createBackendJwt";
import { auth } from "@/auth";

export async function GET(request: Request) {
	const session = await auth();
	const email = session?.user?.email;

	const redirectUrl = new URL("/mypage", process.env.AUTH_URL!);

	if (!email) return NextResponse.redirect(redirectUrl);

	const backendJwt = await createBackendJwt({
		email: session.user!.email!,
		provider: session.user?.provider as string,
		uid: session.user?.uid as string,
	});

	const response = await fetch(
		`${process.env.NEXT_PUBLIC_API_BASE_URL}/login`,
		{
			method: "POST",
			headers: { Authorization: `Bearer ${backendJwt}` },
			cache: "no-store",
		},
	);

	if (!response.ok) {
		return NextResponse.redirect(redirectUrl);
	}

	const userData = await response.json();
	const res = NextResponse.redirect(redirectUrl);

	res.cookies.set(
		"current_user",
		encodeURIComponent(JSON.stringify(userData.user)),
		{
			httpOnly: true,
			secure: process.env.NODE_ENV === "production",
			maxAge: 60 * 60 * 24 * 3,
			path: "/",
		},
	);

	return res;
}
