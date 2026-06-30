"use server";

import { getBackendJwt } from "./getBackendJwt";

export default async function fetchResults(page: number) {
	const jwt = await getBackendJwt();

	const res = await fetch(
		`${process.env.NEXT_PUBLIC_API_BASE_URL}/results?page=${page}`,
		{
			headers: {
				Authorization: `Bearer ${jwt}`,
			},
			cache: "no-store",
		},
	);
	return res.json();
}
