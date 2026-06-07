"use server";

import { getBackendJwt } from "./getBackendJwt";

export default async function fetchCategories() {
	const jwt = await getBackendJwt();

	const res = await fetch(`${process.env.NEXT_PUBLIC_API_BASE_URL}/categories`, {
		headers: {
			Authorization: `Bearer ${jwt}`,
		},
		method: "GET",
		cache: "no-store",
	});

	const categories = await res.json();

	return categories;
}
