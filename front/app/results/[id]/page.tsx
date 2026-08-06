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
} from "recharts";
import { requireAuth } from "@/app/lib/requireAuth";
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

	const dependencyLevel =
		result.dependency_score >= 70
			? "danger"
			: result.dependency_score >= 40
				? "warning"
				: "safe";

	const categoryStyles: Record<string, string> = {
		ai: "bg-blue-50 border-blue-200",
		algorithm: "bg-green-50 border-green-200",
		db: "bg-purple-50 border-purple-200",
		web: "bg-orange-50 border-orange-200",
	};

	return (
		<div className="text-center py-15">
			<h2 className="text-3xl font-bold mb-2">診断結果</h2>
			<div className="flex justify-center items-center gap-6 px-8">
				<RadarChart
					cx={300}
					cy={250}
					outerRadius={150}
					width={600}
					height={600}
					data={data}
				>
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
				<div key={result.id} className="w-1/2">
					<p>AI依存度は{result.dependency_score}%です。</p>
					{dependencyLevel === "danger" && <p>🔴 要注意</p>}
					{dependencyLevel === "warning" && <p>🟡 注意</p>}
					{dependencyLevel === "safe" && <p>🟢 良好</p>}
					{Object.entries(result.advices).map(
						([slug, { name, summary, advices }]) => (
							<div
								key={slug}
								className={`whitespace-pre-line text-left mt-6 p-4 rounded border ${categoryStyles[slug] ?? ""}`}
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
