"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import type { ResultsResponse } from "@/types/result";
import { requireAuth } from "../lib/requireAuth";
import fetchResults from "../lib/results";
import Paginate from "@/components/atoms/Paginate";

export default function Result() {
	const [results, setResults] = useState<ResultsResponse | null>(null);
	const [currentPage, setCurrentPage] = useState(1);

	useEffect(() => {
		const initialize = async () => {
			await requireAuth();

			const data = await fetchResults(currentPage);
			setResults(data);
		};

		initialize();
	}, [currentPage]);

	const getDependencyLabel = (score: number) => {
		if (score >= 70) return "🔴 要注意";
		if (score >= 40) return "🟡 注意";
		return "🟢 良好";
	};

	const scrollTop = () => {
		setTimeout(() => {
			window.scrollTo({
				top: 0,
				behavior: "smooth",
			});
		}, 0);
	};

	const handlePageChange = (item: { selected: number }) => {
		setCurrentPage(item.selected + 1);
		scrollTop();
	};

	return (
		<div className="min-h-screen bg-gray-50 py-16">
			<h2 className="text-4xl font-bold text-center mb-10">診断結果一覧</h2>
			{results && results.results.length > 0 ? (
				<div className="max-w-4xl mx-auto grid gap-6 px-4">
					{results.results.map((result) => (
						<Link
							key={result.id}
							href={`/results/${result.id}`}
							className="block"
						>
							<div className="bg-white p-6 rounded-2xl shadow hover:shadow-lg transition duration-200 border border-gray-100">
								<div className="flex justify-between items-center mb-4">
									<p className="text-sm text-gray-400">
										{new Date(result.created_at).toLocaleDateString()}
									</p>
								</div>

								<h3 className="text-xl font-semibold mb-2">
									AI依存度：{result.dependency_score}%{" "}
									{getDependencyLabel(result.dependency_score)}
								</h3>

								<p className="text-gray-600">
									{"【" + result.advices.ai?.name + "】"}
									{result.advices.ai?.summary?.substring(0, 150) + "..."}
								</p>
								<p className="mt-4 text-blue-500 text-sm font-medium">
									詳細を見る →
								</p>
							</div>
						</Link>
					))}

					<Paginate
						currentPage={currentPage}
						pagination={results.pagination}
						onPageChange={handlePageChange}
					/>
				</div>
			) : (
				<div className="py-20 text-center text-slate-500">
					診断結果はありません。診断してみましょう。
				</div>
			)}
		</div>
	);
}
