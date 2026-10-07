"use client";

import { useRouter } from "next/navigation";
import { useEffect, useRef, useState } from "react";
import { Category } from "@/types/category";
import submitAnswers from "../lib/answers";
import fetchCategories from "../lib/categories";
import { requireAuth } from "../lib/requireAuth";
import { shuffle } from "../lib/shuffle";

export default function Question() {
	const [categories, setCategories] = useState<Category[]>([]);
	const [answers, setAnswers] = useState<{ [key: number]: number }>({});
	const [currentCategoryIndex, setcurrentCategoryIndex] = useState<number>(0);

	const router = useRouter();

	function nextCategory() {
		setcurrentCategoryIndex((index) => index + 1);

		setTimeout(() => {
			window.scrollTo({
				top: 0,
				behavior: "smooth",
			});
		}, 0);
	}

	useEffect(() => {
		const fetchData = async () => {
			const data: Category[] = await fetchCategories();

			// 選択肢がscore順に並ぶと回答パターンが固定化されるため、取得時に1度だけシャッフルする
			const shuffled = data.map((category) => ({
				...category,
				questions: category.questions.map((question) => ({
					...question,
					choices: shuffle(question.choices),
				})),
			}));

			setCategories(shuffled);
		};

		fetchData();
	}, []);

	useEffect(() => {
		const session = async () => await requireAuth();
		session();
	}, []);

	const questionRefs = useRef<Record<number, HTMLDivElement | null>>({});

	const handleChange = (
		questionId: number,
		choiceId: number,
		questionIndex: number,
	) => {
		setAnswers({
			...answers,
			[questionId]: choiceId,
		});

		const nextQuestion = questionRefs.current[questionIndex + 1];

		nextQuestion?.scrollIntoView({
			behavior: "smooth",
			block: "start",
		});
	};

	const handleSubmit = async (e: React.FormEvent) => {
		e.preventDefault();

		try {
			const result = await submitAnswers(answers);
			router.push(`/results/${result.id}`);
		} catch (error) {
			console.error(error);
		}
	};

	const currentCategory = categories[currentCategoryIndex];

	const questionIds = currentCategory?.questions.map((question) => {
		return question.id;
	});

	const answeredIds = Object.keys(answers).map(Number);

	const disable = questionIds?.every((id) => {
		return answeredIds.includes(id);
	});

	return (
		<div className="min-h-screen bg-slate-50 px-4 py-10">
			<form
				onSubmit={handleSubmit}
				className="mx-auto w-full max-w-4xl rounded-3xl bg-white p-6 shadow-lg ring-1 ring-slate-200"
			>
				{currentCategory ? (
					<div className="flex flex-col gap-8" key={currentCategory.id}>
						<div className="text-center">
							<p className="mb-2 text-sm font-semibold tracking-wide text-sky-600">
								{currentCategoryIndex + 1} / {categories.length}
							</p>
							<progress value={currentCategoryIndex} max={4} />
							<h2 className="text-3xl font-bold tracking-tight text-slate-900">
								{currentCategory.name}
							</h2>
							<p className="mt-3 text-sm text-slate-500">
								当てはまるものを1つ選んでください。
							</p>
						</div>

						<div className="flex flex-col gap-6 border border-slate-200 bg-slate-50 rounded-2xl shadow-sm">
							{currentCategory.questions.map((question, questionIndex) => (
								<div
									key={question.id}
									className="p-5"
									ref={(el) => {
										questionRefs.current[questionIndex] = el;
									}}
								>
									<div className="mb-4 flex items-start gap-3">
										<span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-sky-600 text-sm font-bold text-white">
											{questionIndex + 1}
										</span>
										<h3 className="text-lg font-bold leading-7 text-slate-900">
											{question.content}
										</h3>
									</div>

									{question.choices.map((choice) => (
										<div key={choice.id} className="w-full">
											<input
												id={`choice-${choice.id}`}
												type="radio"
												className="hidden peer"
												name={`question-${question.id}`}
												value={choice.id}
												onChange={() =>
													handleChange(question.id, choice.id, questionIndex)
												}
											/>
											<label
												htmlFor={`choice-${choice.id}`}
												key={choice.id}
												className="block w-full cursor-pointer rounded-xl border-2 border-slate-300 bg-white p-4 my-4 text-left text-lg font-medium text-slate-800 shadow-sm transition-all duration-200
											hover:border-sky-400 hover:bg-sky-50 hover:shadow-md
											peer-checked:border-sky-500 peer-checked:bg-sky-50 peer-checked:text-sky-900 peer-checked:shadow-lg peer-checked:ring-2 peer-checked:ring-sky-500/20
											md:p-6 md:text-xl md:leading-relaxed"
											>
												{choice.content}
											</label>
										</div>
									))}
								</div>
							))}
						</div>
					</div>
				) : (
					<div className="py-20 text-center text-slate-500">読み込み中...</div>
				)}

				<div className="mt-10 flex justify-center">
					{currentCategoryIndex === categories.length - 1 ? (
						<button
							className="rounded-2xl bg-sky-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-sky-600 disabled:cursor-not-allowed disabled:opacity-40"
							type="submit"
							disabled={!disable}
						>
							送信
						</button>
					) : (
						<button
							className="rounded-2xl bg-sky-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-sky-600 disabled:cursor-not-allowed disabled:opacity-40"
							type="button"
							onClick={nextCategory}
							disabled={!disable}
						>
							次へ
						</button>
					)}
				</div>
			</form>
		</div>
	);
}
