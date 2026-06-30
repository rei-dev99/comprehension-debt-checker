"use client";
import Image from "next/image";
import { handleGoogleLogin } from "@/actions/handleGoogleLogin";

export default function Login() {
	return (
		<form action={handleGoogleLogin}>
			<button
				type="submit"
				className="
					flex items-center gap-3
					border border-gray-300
					rounded-md
					px-4 py-2
					bg-white
					hover:bg-gray-50
					transition
					cursor-pointer
				"
			>
				<Image src="/google.svg" alt="Googleアイコン" width={20} height={20} />
				<span className="text-sm font-medium text-gray-700">Googleで続行</span>
			</button>
		</form>
	);
}
