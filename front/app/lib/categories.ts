"use server";

import { getBackendJwt } from "./getBackendJwt";

export default async function fetchCategories() {
	const jwt = await getBackendJwt();
	console.log(process.env.NEXT_PUBLIC_API_BASE_URL);
	console.log(jwt.slice(0, 30));

	const res = await fetch(
		`${process.env.NEXT_PUBLIC_API_BASE_URL}/categories`,
		{
			headers: {
				Authorization: `Bearer ${jwt}`,
			},
			method: "GET",
			cache: "no-store",
		},
	);

	console.log("status =", res.status);

	const categories = await res.json();

	return categories;
}
