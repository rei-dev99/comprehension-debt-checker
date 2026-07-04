"use client";

import { useState } from "react";
import z from "zod";
import handleSignup from "@/actions/handleSignup";
import { credentialSchema } from "@/app/lib/zod";

export function SignupForm() {
	const [errors, setErrors] = useState({
		email: "",
		password: "",
	});

	const handleSubmit = async (formData: FormData) => {
		setErrors({ email: "", password: "" });

		const email = String(formData.get("email") ?? "");
		const password = String(formData.get("password") ?? "");

		const validation = credentialSchema.safeParse({ email, password });

		if (!validation.success) {
			const errors = z.flattenError(validation.error).fieldErrors;

			setErrors({
				email: errors.email?.[0] ?? "",
				password: errors.password?.[0] ?? "",
			});

			return;
		}

		const result = await handleSignup({ email, password });

		if (!result?.success) {
			setErrors((prev) => ({
				...prev,
				[result?.error.field]: result?.error.message,
			}));
		}
	};

	return (
		<form className="border-b border-dashed pb-6" action={handleSubmit}>
			<div className="mb-4">
				<label className="block text-gray-700 text-sm font-bold mb-2">
					メールアドレス
				</label>

				<input
					className={`shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                        ${
													errors.email
														? "border-red-500 focus:ring-2 focus:ring-red-300"
														: "border-gray-300"
												}`}
					id="email"
					type="email"
					placeholder="メールアドレス"
					name="email"
				/>

				{errors.email && (
					<p className="mt-1 flex items-center gap-1 text-sm text-red-600">
						<span>⚠</span>
						<span>{errors.email}</span>
					</p>
				)}
			</div>
			<div className="mb-6">
				<label className="block text-gray-700 text-sm font-bold mb-2">
					パスワード
				</label>
				<input
					className={`shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline
                        ${
													errors.password
														? "border-red-500 focus:ring-2 focus:ring-red-300"
														: "border-gray-300"
												}`}
					id="password"
					type="password"
					placeholder="パスワード"
					name="password"
				/>

				{errors.password && (
					<p className="mt-1 flex items-center gap-1 text-sm text-red-600">
						<span>⚠</span>
						<span>{errors.password}</span>
					</p>
				)}
			</div>
			<div className="flex justify-center">
				<button
					className="cursor-pointer bg-blue-500 hover:bg-blue-700 transition text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
					type="submit"
				>
					登録する
				</button>
			</div>
		</form>
	);
}
