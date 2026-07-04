import Link from "next/link";
import Login from "@/components/atoms/Login";
import { SignupForm } from "@/components/forms/SignupForm";
import { requireSession } from "../lib/requireSession";

export default async function SignupPage() {
	await requireSession();

	return (
		<div className="py-12 flex justify-center h-screen">
			<div className="w-full max-w-lg bg-white shadow-md rounded px-8 py-8">
				<SignupForm />
				<div className="flex justify-center mt-6">
					<Login />
				</div>
				<div className="flex justify-center mt-10">
					<Link
						href="/login"
						className="rounded px-4 py-2 text-blue-500 transition-all hover:opacity-70"
					>
						すでに登録済みの方はこちらから
					</Link>
				</div>
			</div>
		</div>
	);
}
