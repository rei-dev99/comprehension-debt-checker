import Link from "next/link";
import Login from "@/components/atoms/Login";
import { requireSession } from "../lib/requireSession";
import { LoginForm } from "@/components/forms/LoginForm";
import GuestForm from "@/components/forms/GuestForm";

export default async function LoginPage() {
	await requireSession();

	return (
		<div className="py-12 flex justify-center h-screen">
			<div className="w-full max-w-lg bg-white shadow-md rounded px-8 py-8">
				<LoginForm />
				<div className="flex justify-center">
					<GuestForm />
				</div>
				<div className="flex justify-center mt-6">
					<Login />
				</div>
				<div className="flex justify-center mt-10">
					<Link
						href="/signup"
						className="rounded px-4 py-2 text-blue-500 transition-all hover:opacity-70"
					>
						新規登録はこちらから
					</Link>
				</div>
			</div>
		</div>
	);
}
