"use server";

import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { createBackendJwt } from "@/app/lib/createBackendJwt";
import { signIn } from "@/auth";

export default async function handleSignup(credentials: {
	email: string;
	password: string;
}) {
	const { email, password } = credentials;
	const signupResponse = await fetch(
		`${process.env.NEXT_PUBLIC_API_BASE_URL}/signup_email`,
		{
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ email, password }),
		},
	);

	if (!signupResponse.ok) {
		const error = await signupResponse.json();
		return {
			success: false,
			error,
		};
	}

	await signIn("credentials", {
		redirect: false,
		loginType: "email",
		email,
		password,
	});

	const backendJwt = await createBackendJwt({
		email: String(email),
		provider: "email",
		uid: String(email),
	});

	const loginResponse = await fetch(
		`${process.env.NEXT_PUBLIC_API_BASE_URL}/login`,
		{
			method: "POST",
			headers: {
				Authorization: `Bearer ${backendJwt}`,
			},
			cache: "no-store",
		},
	);

	if (!loginResponse.ok) {
		return;
	}

	const data = await loginResponse.json();

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
