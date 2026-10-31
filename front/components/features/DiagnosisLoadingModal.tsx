/** 診断結果の作成（アドバイス生成を含む）を待つ間、画面全体を覆って進行中であることを伝える */
export default function DiagnosisLoadingModal() {
	return (
		<div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/40 px-4 backdrop-blur-sm">
			<div
				role="dialog"
				aria-modal="true"
				aria-labelledby="diagnosis-loading-title"
				aria-describedby="diagnosis-loading-description"
				className="w-full max-w-sm rounded-2xl bg-white p-8 text-center shadow-xl"
			>
				<div
					aria-hidden="true"
					className="mx-auto h-12 w-12 animate-spin rounded-full border-4 border-sky-100 border-t-sky-500 motion-reduce:animate-none"
				/>
				<h2
					id="diagnosis-loading-title"
					className="mt-6 text-lg font-bold text-slate-900"
				>
					診断結果を作成しています
				</h2>
				<p
					id="diagnosis-loading-description"
					role="status"
					className="mt-2 text-sm leading-6 text-slate-500"
				>
					回答をもとにアドバイスをまとめています。
					<br />
					10秒ほどかかる場合があります。このままお待ちください。
				</p>
			</div>
		</div>
	);
}
