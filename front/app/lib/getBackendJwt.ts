"use server";

import { auth } from "@/auth";
import { createBackendJwt } from "./createBackendJwt";

export async function getBackendJwt() {
	const session = await auth();

	if (!session?.user?.email || !session.user.provider || !session.user.uid) {
		throw new Error("Invalid session");
	}

	return await createBackendJwt({
		email: session.user.email,
		provider: session.user.provider,
		uid: session.user.uid,
	});
}
