import handleGuestLogin from "@/actions/handleGuestLogin";

export function GuestForm() {
	return (
		<form action={handleGuestLogin}>
			<button
				type="submit"
				className="rounded-2xl bg-orange-500 px-8 py-3 text-sm font-semibold text-white shadow-sm transition hover:bg-orange-600 mt-6"
			>
				ゲストで試す
			</button>
		</form>
	);
}

export default GuestForm;
