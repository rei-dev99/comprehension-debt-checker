import Link from "next/link";
import { auth } from "@/auth";

export default async function Header() {
	const session = await auth();

	return (
		<header className="bg-sky-600 shadow-md">
			<div className="mx-auto flex max-w-7xl flex-col items-center justify-between gap-3 px-4 py-4 sm:flex-row">
				<Link href="/" className="text-center sm:text-left">
					<h1 className="text-2xl font-bold text-white">理解負債チェッカー</h1>
					<p className="text-sm text-sky-100 text-center">
						〜わかるコード診断〜
					</p>
				</Link>
				<nav className="flex items-center space-x-2">
					{session ? (
						<Link
							href="/mypage"
							className="rounded px-4 py-2 text-sm font-medium text-white transition-all hover:bg-sky-700"
						>
							マイページ
						</Link>
					) : (
						<Link
							href="/"
							className="rounded px-4 py-2 text-sm font-medium text-white transition-all hover:bg-sky-700"
						>
							トップ
						</Link>
					)}
					<Link
						href="/question"
						className="rounded px-4 py-2 text-sm font-medium text-white transition-all hover:bg-sky-700"
					>
						質問
					</Link>
					<Link
						href="/results"
						className="rounded px-4 py-2 text-sm font-medium text-white transition-all hover:bg-sky-700"
					>
						診断結果
					</Link>
				</nav>
			</div>
		</header>
	);
}
