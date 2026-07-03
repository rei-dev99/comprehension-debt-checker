import Link from "next/link";
import { auth } from "@/auth";
import GuestForm from "@/components/forms/GuestForm";

export default async function Home() {
	const session = await auth();

	return (
		<div className="flex flex-col flex-1 items-center justify-center bg-zinc-50">
			<section className="flex flex-col items-center text-white bg-black w-full py-10">
				<h2 className="text-3xl font-bold mb-6">理解負債チェッカーとは？</h2>
				<p className="text-center mb-6 leading-7">
					理解負債チェッカーとは、AI時代のプログラミング学習診断・改善アプリです。
					<br />
					AIに頼りすぎて、「理解したつもり」になっていないかを診断します。
					<br />
					<br />
					各カテゴリの質問に答えることで、技術的理解度やAI依存度を確認することができます。
					<br />
					そこから適切なアドバイスをもとに学習方法の改善を行います。
				</p>
				{session ? (
					<Link
						href={"/mypage"}
						className="rounded-2xl bg-sky-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-sky-600"
					>
						マイページへ行く
					</Link>
				) : (
					<>
						<Link
							href={"/login"}
							className="rounded-2xl bg-sky-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-sky-600"
						>
							診断してみる
						</Link>
						<GuestForm />
					</>
				)}
			</section>

			<section className="flex flex-1 w-full max-w-7xl flex-col py-16 px-8 bg-white">
				<h2 className="text-3xl font-bold mb-6 text-center">3つの特徴</h2>
				<div className="flex flex-col md:flex-row justify-between gap-4">
					<div className="flex flex-1 flex-col">
						<div className="flex mb-2 md:justify-center">
							<span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-sky-600 text-sm font-bold text-white mr-2">
								1
							</span>
							<h3 className="text-center text-2xl font-bold">
								技術的質問に回答
							</h3>
						</div>
						<p>
							4カテゴリ・全20問の質問で、現在の理解度や学習傾向を診断します。
						</p>
					</div>

					<div className="flex flex-1 flex-col">
						<div className="flex mb-2 md:justify-center">
							<span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-sky-600 text-sm font-bold text-white mr-2">
								2
							</span>
							<h3 className="text-center text-2xl font-bold">
								AI依存度スコアと理解度の可視化
							</h3>
						</div>
						<p>
							質問に答えると基礎ベースとなる技術、そしてAI依存度に関するスコアが表示されます。
						</p>
					</div>

					<div className="flex flex-1 flex-col">
						<div className="flex mb-2 md:justify-center">
							<span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-sky-600 text-sm font-bold text-white mr-2">
								3
							</span>
							<h3 className="text-center text-2xl font-bold">学習方針の提示</h3>
						</div>
						<p>適切なアドバイスをもとに学習方法の改善を行います。</p>
					</div>
				</div>
			</section>
		</div>
	);
}
