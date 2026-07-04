"use server";

import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { AuthError } from "next-auth";
import { createBackendJwt } from "@/app/lib/createBackendJwt";
import { signIn } from "@/auth";

export async function handleLogin(credentials: {
	email: string;
	password: string;
}) {
	const { email, password } = credentials;

	const provider = "email";
	const uid = email;

	try {
		await signIn("credentials", {
			redirect: false,
			loginType: "email",
			email,
			password,
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
	} catch (e) {
		if (e instanceof AuthError) {
			return {
				success: false,
				error: {
					field: "password",
					message: "メールアドレスまたはパスワードが違います",
				},
			};
		}

		throw e;
	}
}
