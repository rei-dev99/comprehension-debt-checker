import Link from "next/link";
import { auth } from "@/auth";
import GuestForm from "@/components/forms/GuestForm";

const painPoints = [
	"エラーが出たら、そのままAIに貼り付けて解決している",
	"仮に動いても、「なぜ動いたか」を説明できない",
	"チュートリアルが終わっても、自力で1からコードを書けない",
];

const features = [
	{
		number: 1,
		title: "技術的質問に回答",
		description:
			"4カテゴリ・全20問の質問で、現在の理解度や学習傾向を診断します。",
		cardClassName: "bg-sky-50 ring-sky-100",
		iconClassName: "bg-sky-100 text-sky-600",
		icon: (
			<svg
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				strokeWidth="1.5"
				strokeLinecap="round"
				strokeLinejoin="round"
				className="h-8 w-8"
			>
				<rect x="6" y="4" width="12" height="16" rx="2" />
				<path d="M9 4V3a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1" />
				<path d="M9 12.5l1.8 1.8L15 10" />
			</svg>
		),
	},
	{
		number: 2,
		title: "AI依存度スコアと理解度の可視化",
		description:
			"質問に答えると基礎ベースとなる技術、そしてAI依存度に関するスコアが表示されます。",
		cardClassName: "bg-violet-50 ring-violet-100",
		iconClassName: "bg-violet-100 text-violet-600",
		icon: (
			<svg
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				strokeWidth="1.5"
				strokeLinecap="round"
				strokeLinejoin="round"
				className="h-8 w-8"
			>
				<path d="M4 20V11" />
				<path d="M10 20V4" />
				<path d="M16 20v-7" />
				<path d="M3 20h18" />
			</svg>
		),
	},
	{
		number: 3,
		title: "学習方針の提示",
		description: "適切なアドバイスをもとに学習方法の改善を行います。",
		cardClassName: "bg-amber-50 ring-amber-100",
		iconClassName: "bg-amber-100 text-amber-600",
		icon: (
			<svg
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				strokeWidth="1.5"
				strokeLinecap="round"
				strokeLinejoin="round"
				className="h-8 w-8"
			>
				<path d="M9 18h6" />
				<path d="M10 21h4" />
				<path d="M12 3a6 6 0 0 0-4 10.45c.6.6 1 1.44 1 2.55h6c0-1.1.4-1.95 1-2.55A6 6 0 0 0 12 3Z" />
			</svg>
		),
	},
];

export default async function Home() {
	const session = await auth();

	return (
		<div className="flex flex-1 flex-col items-center bg-zinc-50">
			<section className="flex w-full flex-col items-center bg-linear-to-b from-slate-900 to-sky-950 px-4 py-20 text-white">
				<span className="mb-4 rounded-full bg-sky-500/20 px-4 py-1 text-sm font-semibold text-sky-300">
					AI時代のプログラミング学習診断
				</span>
				<h2 className="max-w-2xl text-center text-3xl font-bold leading-snug md:text-4xl">
					その「わかったつもり」
					<br />
					AIに任せきりになっていませんか？
				</h2>
				<p className="mt-6 max-w-xl text-center leading-7 text-slate-300">
					理解負債チェッカーは、20問の質問であなたの技術理解度とAI依存度を可視化する診断アプリです。
				</p>
				<div className="mt-8 flex flex-col items-center gap-2">
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
				</div>
			</section>

			<section className="flex w-full max-w-5xl flex-col items-center px-8 py-16">
				<h2 className="mb-6 text-center text-3xl font-bold">
					理解負債チェッカーとは？
				</h2>
				<p className="max-w-2xl text-center leading-7 text-zinc-700">
					AIに頼りすぎて、「理解したつもり」になっていないかを診断するアプリです。
					<br />
					各カテゴリの質問に答えることで技術的理解度やAI依存度を確認し、適切なアドバイスをもとに学習方法の改善を行います。
				</p>

				<div className="mt-10 w-full rounded-2xl bg-white p-8 shadow-sm ring-1 ring-zinc-200">
					<p className="mb-4 text-center font-semibold text-zinc-800">
						こんな心当たり、ありませんか？
					</p>
					<ul className="flex flex-col gap-3">
						{painPoints.map((point) => (
							<li key={point} className="flex items-start gap-3">
								<span className="mt-1 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-sky-100 text-xs font-bold text-sky-600">
									✓
								</span>
								<span className="text-zinc-700">{point}</span>
							</li>
						))}
					</ul>
				</div>
			</section>

			<section className="flex w-full flex-col items-center bg-white px-8 py-16">
				<div className="flex w-full max-w-7xl flex-col">
					<h2 className="mb-10 text-center text-3xl font-bold">3つの特徴</h2>
					<div className="flex flex-col gap-8 md:flex-row md:justify-between">
						{features.map((feature) => (
							<div
								key={feature.number}
								className={`flex flex-1 flex-col items-center rounded-2xl p-8 text-center ring-1 ${feature.cardClassName}`}
							>
								<div
									className={`relative mb-4 flex h-16 w-16 items-center justify-center rounded-2xl ${feature.iconClassName}`}
								>
									{feature.icon}
									<span className="absolute -right-2 -top-2 flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-sky-600 text-xs font-bold text-white ring-2 ring-white">
										{feature.number}
									</span>
								</div>
								<h3 className="mb-2 text-2xl font-bold">{feature.title}</h3>
								<p className="text-zinc-600">{feature.description}</p>
							</div>
						))}
					</div>
				</div>
			</section>

			<section className="flex w-full flex-col items-center bg-sky-600 px-4 py-16 text-white">
				<h2 className="mb-4 text-center text-2xl font-bold md:text-3xl">
					さあ、理解負債チェッカーで診断してみよう
				</h2>
				<p className="mb-8 max-w-xl text-center text-sky-100">
					所要時間は約5分。今の理解度を知ることが、次の学習の一歩になります。
				</p>
				<div className="flex flex-col items-center gap-2">
					{session ? (
						<Link
							href={"/mypage"}
							className="rounded-2xl bg-white px-8 py-3 text-sm font-semibold text-sky-600 shadow-sm transition hover:bg-sky-50"
						>
							マイページへ行く
						</Link>
					) : (
						<>
							<Link
								href={"/login"}
								className="rounded-2xl bg-white px-8 py-3 text-sm font-semibold text-sky-600 shadow-sm transition hover:bg-sky-50"
							>
								診断してみる
							</Link>
							<GuestForm />
						</>
					)}
				</div>
			</section>
		</div>
	);
}
