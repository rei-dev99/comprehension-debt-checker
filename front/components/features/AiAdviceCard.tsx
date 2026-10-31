import { AiAdvice } from "@/types/result";

interface AiAdviceCardProps {
	aiAdvice: AiAdvice;
}

export default function AiAdviceCard({ aiAdvice }: AiAdviceCardProps) {
	return (
		<section className="mt-10 rounded-2xl border border-sky-200 bg-sky-50 p-6 text-left sm:p-8">
			<h2 className="text-xl font-bold text-slate-900">アドバイス</h2>

			<p className="mt-4 whitespace-pre-line leading-7 text-slate-700">
				{aiAdvice.overall}
			</p>

			<div className="mt-6 rounded-xl bg-white p-5 ring-1 ring-sky-100">
				<h3 className="font-semibold text-slate-900">AIとの向き合い方</h3>
				<p className="mt-2 whitespace-pre-line leading-7 text-slate-700">
					{aiAdvice.ai_usage}
				</p>
			</div>

			<h3 className="mt-6 font-semibold text-slate-900">
				次の1週間で取り組むこと
			</h3>
			<ol className="mt-3 grid gap-3 md:grid-cols-3">
				{aiAdvice.actions.map((action, index) => (
					<li
						key={`${action.category}-${action.title}`}
						className="rounded-xl bg-white p-5 ring-1 ring-sky-100"
					>
						<div className="flex items-center gap-2">
							<span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-sky-600 text-xs font-bold text-white">
								{index + 1}
							</span>
							<span className="text-xs font-medium text-sky-700">
								{action.category}
							</span>
						</div>
						<p className="mt-3 font-semibold text-slate-900">{action.title}</p>
						<p className="mt-2 text-sm leading-6 text-slate-600">
							{action.detail}
						</p>
					</li>
				))}
			</ol>

			<p className="mt-6 text-xs text-slate-400">
				※AIが生成した内容のため、誤りを含む場合があります。
			</p>
		</section>
	);
}
