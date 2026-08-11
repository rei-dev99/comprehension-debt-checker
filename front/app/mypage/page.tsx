import Link from "next/link";
import Logout from "@/components/atoms/Logout";
import type { Result } from "@/types/result";
import { requireAuth } from "../lib/requireAuth";
import fetchResults from "../lib/results";

const categoryFields: {
	key: "ai_score" | "algorithm_score" | "db_score" | "web_score";
	label: string;
}[] = [
	{ key: "ai_score", label: "AI活用習慣" },
	{ key: "algorithm_score", label: "アルゴリズム基礎" },
	{ key: "db_score", label: "データベース理解" },
	{ key: "web_score", label: "Web技術理解" },
];

function getDependencyTrend(latest: Result, previous: Result) {
	const diff = latest.dependency_score - previous.dependency_score;

	if (diff === 0) {
		return {
			label: "前回から変化なし",
			className: "bg-zinc-100 text-zinc-600",
		};
	}

	if (diff < 0) {
		return {
			label: `🟢 前回より${Math.abs(diff)}pt改善`,
			className: "bg-emerald-100 text-emerald-700",
		};
	}

	return {
		label: `🔴 前回より${diff}pt悪化`,
		className: "bg-red-100 text-red-700",
	};
}

export default async function Mypage() {
	const session = await requireAuth();
	const { results } = await fetchResults(1);
	const latest: Result | undefined = results[0];
	const previous: Result | undefined = results[1];
	const trend =
		latest && previous ? getDependencyTrend(latest, previous) : null;

	return (
		<div className="flex flex-col flex-1 items-center justify-center bg-zinc-50">
			<main className="flex flex-1 w-full max-w-3xl flex-col py-32 px-16 bg-white">
				<h2 className="text-3xl font-bold mb-6 border-b-2 pb-4">マイページ</h2>
				<p className="mt-2 text-slate-600">
					こんにちは、{session.user?.email}さん
				</p>

				{latest ? (
					<div className="mt-8 rounded-2xl border border-zinc-200 bg-zinc-50 p-6">
						<div className="mb-4 flex items-center justify-between">
							<h3 className="text-lg font-bold text-slate-800">
								最新の診断結果
							</h3>
							<span className="text-xs text-zinc-400">
								{new Date(latest.created_at).toLocaleDateString()}
							</span>
						</div>

						<div className="mb-4 flex flex-wrap items-center gap-3">
							<span className="text-3xl font-bold text-sky-600">
								{latest.dependency_score}%
							</span>
							<span className="text-sm text-zinc-500">AI依存度</span>
							{trend && (
								<span
									className={`rounded-full px-3 py-1 text-xs font-semibold ${trend.className}`}
								>
									{trend.label}
								</span>
							)}
						</div>

						<div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
							{categoryFields.map((field) => (
								<div
									key={field.key}
									className="rounded-xl bg-white p-3 text-center ring-1 ring-zinc-200"
								>
									<p className="text-xs text-zinc-500">{field.label}</p>
									<p className="text-xl font-bold text-slate-800">
										{latest[field.key]}
									</p>
								</div>
							))}
						</div>

						<Link
							href={`/results/${latest.id}`}
							className="mt-4 inline-block text-sm font-medium text-sky-600 hover:underline"
						>
							詳細を見る →
						</Link>
					</div>
				) : (
					<div className="mt-8 rounded-2xl border border-dashed border-zinc-300 bg-zinc-50 p-8 text-center">
						<p className="text-zinc-600">
							まだ診断結果がありません。まずは1回診断してみましょう。
						</p>
					</div>
				)}

				<div className="mt-6 flex flex-col md:flex-row gap-4">
					<Link
						href="/question"
						className="rounded-2xl bg-sky-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-sky-600"
					>
						診断を始める
					</Link>
					<Link
						href="/results"
						className="rounded-2xl bg-orange-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-orange-600"
					>
						診断結果を見る
					</Link>
				</div>
				<div className="mt-10">
					<Logout />
				</div>
			</main>
		</div>
	);
}
