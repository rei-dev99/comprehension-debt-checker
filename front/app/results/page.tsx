"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import type { ResultsResponse } from "@/types/result";
import { getDependencyLevel } from "../lib/dependencyLevel";
import { requireAuth } from "../lib/requireAuth";
import fetchResults from "../lib/results";
import Paginate from "@/components/atoms/Paginate";
import ConvertDate from "@/components/atoms/ConvertDate";

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
					{results.results.map((result) => {
						const level = getDependencyLevel(result.dependency_score);

						return (
							<Link
								key={result.id}
								href={`/results/${result.id}`}
								className="group block"
							>
								<div className="bg-white p-6 rounded-2xl shadow hover:shadow-lg transition duration-200 border border-gray-100">
									<div className="flex justify-between items-center mb-4">
										<p className="text-sm text-gray-400">
											<ConvertDate dateISO={result.created_at} />
										</p>
									</div>

									<div className="mb-2 flex flex-wrap items-center gap-3">
										<span
											className={`text-3xl font-bold ${level.textClassName}`}
										>
											{result.dependency_score}%
										</span>
										<span className="text-sm text-zinc-500">AI依存度</span>
										<span
											className={`rounded-full px-3 py-1 text-xs font-semibold ${level.badgeClassName}`}
										>
											{level.emoji} {level.label}
										</span>
									</div>

									<p className="text-gray-600">
										{"【" + result.advices.ai?.name + "】"}
										{result.advices.ai?.summary?.substring(0, 150) + "..."}
									</p>
									<p className="mt-4 text-blue-500 text-sm font-medium">
										詳細を見る{" "}
										<span className="inline-block transition-transform duration-300 ease-out group-hover:translate-x-1.5 motion-reduce:transition-none">
											→
										</span>
									</p>
								</div>
							</Link>
						);
					})}

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
