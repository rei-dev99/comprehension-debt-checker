"use server";

import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { createBackendJwt } from "@/app/lib/createBackendJwt";
import { signIn } from "@/auth";

export async function handleGuestLogin() {
	const guestResponse = await fetch(
		`${process.env.NEXT_PUBLIC_API_BASE_URL}/guest_login`,
		{
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
		},
	);

	if (!guestResponse.ok) {
		return;
	}

	const guestData = await guestResponse.json();

	const email = guestData.user.email;
	const provider = guestData.user.provider;
	const uid = guestData.user.uid;

	await signIn("credentials", {
		redirect: false,
		loginType: "guest",
	});

	const backendJwt = await createBackendJwt({
		email,
		provider,
		uid,
	});

	const response = await fetch(
		`${process.env.NEXT_PUBLIC_API_BASE_URL}/login`,
		{
			method: "POST",
			headers: {
				Authorization: `Bearer ${backendJwt}`,
			},
			cache: "no-store",
		},
	);

	if (!response.ok) {
		return;
	}

	const data = await response.json();

	const cookieStore = await cookies();

	cookieStore.set(
		"current_user",
		encodeURIComponent(JSON.stringify(data.user)),
		{
			httpOnly: true,
			secure: process.env.NODE_ENV === "production",
			path: "/",
		},
	);

	redirect("/mypage");
}

export default handleGuestLogin;
