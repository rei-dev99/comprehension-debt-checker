"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import ReactPaginate from "react-paginate";
import type { Result, ResultsResponse } from "@/types/result";
import { requireAuth } from "../lib/requireAuth";
import fetchResults from "../lib/results";

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

									<span className="text-sm bg-blue-100 text-blue-600 px-3 py-1 rounded-full">
										ID: {result.id}
									</span>
								</div>

								<h3 className="text-xl font-semibold mb-2">
									AI依存度：{result.dependency_score}%{" "}
									{getDependencyLabel(result.dependency_score)}
								</h3>

								<p className="text-gray-600">
									{result.advice.substring(0, 150) + "..."}
								</p>
								<p className="mt-4 text-blue-500 text-sm font-medium">
									詳細を見る →
								</p>
							</div>
						</Link>
					))}

					<ReactPaginate
						forcePage={currentPage - 1}
						breakLabel="..."
						nextLabel=">"
						onPageChange={handlePageChange}
						pageCount={results.pagination.pages}
						previousLabel="<"
						renderOnZeroPageCount={null}
						// ===== css =====
						containerClassName="mt-8 flex items-center justify-center gap-2"
						pageLinkClassName="flex h-8 w-8 shrink-0 cursor-pointer items-center justify-center rounded-full bg-sky-600 text-sm font-bold text-white transition-opacity duration-200 hover:opacity-70"
						activeLinkClassName="bg-yellow-500 ring-2 ring-yellow-300"
						previousLinkClassName="flex h-8 w-8 cursor-pointer items-center justify-center rounded-full border border-sky-600 text-sky-600 transition-opacity duration-200 hover:opacity-70"
						nextLinkClassName="flex h-8 w-8 cursor-pointer items-center justify-center rounded-full border border-sky-600 text-sky-600 transition-opacity duration-200 hover:opacity-70"
						disabledClassName="hidden"
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
