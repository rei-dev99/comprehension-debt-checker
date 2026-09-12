"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { useEffect, useState } from "react";
import {
	PolarAngleAxis,
	PolarGrid,
	PolarRadiusAxis,
	Radar,
	RadarChart,
	ResponsiveContainer,
} from "recharts";
import { getDependencyLevel } from "@/app/lib/dependencyLevel";
import { requireAuth } from "@/app/lib/requireAuth";
import ConvertDate from "@/components/atoms/ConvertDate";
import { Result } from "@/types/result";
import fetchResult from "../../lib/result";

export default function ResultDetail() {
	const { id } = useParams();
	const [isLoading, setIsLoading] = useState(true);
	const [result, setResult] = useState<Result | null>(null);

	useEffect(() => {
		const session = async () => await requireAuth();
		session();
	}, []);

	useEffect(() => {
		const fetchData = async () => {
			setIsLoading(true);
			try {
				const data = await fetchResult(id as string);
				setResult(data);
			} catch (e) {
				console.error(e);
				setResult(null);
			} finally {
				setIsLoading(false);
			}
		};

		fetchData();
	}, [id]);

	if (isLoading) return <p>loading...</p>;
	if (result === null) return <p>データが存在しません。</p>;

	const data = [
		{
			category: "AI活用習慣",
			score: result.ai_score,
		},
		{
			category: "アルゴリズム基礎",
			score: result.algorithm_score,
		},
		{
			category: "データベース",
			score: result.db_score,
		},
		{
			category: "Web基礎",
			score: result.web_score,
		},
	];

	const level = getDependencyLevel(result.dependency_score);

	const categoryStyles: Record<string, string> = {
		ai: "bg-blue-50 border-blue-200",
		algorithm: "bg-green-50 border-green-200",
		db: "bg-purple-50 border-purple-200",
		web: "bg-orange-50 border-orange-200",
	};

	return (
		<div className="mx-auto max-w-5xl px-4 py-15 text-center sm:px-8">
			<h2 className="text-3xl font-bold mb-2">診断結果</h2>
			<p className="text-sm text-gray-400 mb-8">
				<ConvertDate dateISO={result.created_at} />
			</p>

			<div className="grid grid-cols-1 items-center gap-6 md:grid-cols-2">
				<div className="h-80 w-full">
					<ResponsiveContainer width="100%" height="100%">
						<RadarChart outerRadius="70%" data={data}>
							<PolarGrid />
							<PolarAngleAxis dataKey="category" />
							<PolarRadiusAxis />
							<Radar
								name="result"
								dataKey="score"
								stroke="#8884d8"
								fill="#8884d8"
								fillOpacity={0.6}
							/>
						</RadarChart>
					</ResponsiveContainer>
				</div>

				<div className={`rounded-2xl border p-8 ${level.cardClassName}`}>
					<p className={`text-5xl font-bold ${level.textClassName}`}>
						{result.dependency_score}%
					</p>
					<p className="mt-2 text-sm text-zinc-500">AI依存度</p>
					<p className={`mt-2 text-lg font-semibold ${level.textClassName}`}>
						{level.emoji} {level.label}
					</p>
				</div>
			</div>

			<div className="mt-10 grid grid-cols-1 gap-4 md:grid-cols-2">
				{Object.entries(result.advices).map(
					([slug, { name, summary, advices }]) => (
						<div
							key={slug}
							className={`whitespace-pre-line rounded border p-4 text-left ${categoryStyles[slug] ?? ""}`}
						>
							<h2>【{name}】</h2>
							<p>{summary}</p>
							<h3 className="mt-4">【あなたへのアドバイス】</h3>
							<ul>
								{advices.map((a, i) => (
									<li key={i}>・{a}</li>
								))}
							</ul>
						</div>
					),
				)}
			</div>

			<div className="mt-10">
				<p>
					あなたの現在の学習状況をもとに診断しています。
					<br />
					診断結果は現時点での傾向ですので、学習を続けた後にもう一度診断すると、成長を確認できます。
				</p>
			</div>

			<div className="mt-6 flex justify-center flex-col md:flex-row gap-4">
				<Link
					href="/question"
					className="rounded-2xl bg-sky-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-sky-600"
				>
					もう一度診断する
				</Link>
				<Link
					href="/results"
					className="rounded-2xl bg-orange-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-orange-600"
				>
					診断一覧へ
				</Link>
			</div>
		</div>
	);
}
