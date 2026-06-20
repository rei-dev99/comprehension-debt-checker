"use server";

import fs from "fs";
import { importPKCS8, SignJWT } from "jose";

export async function createBackendJwt(payload: {
	email: string;
	provider: string;
	uid: string;
}) {

	console.log(
		"JWT_PRIVATE_KEY exists:",
		!!process.env.JWT_PRIVATE_KEY
	);

	let privateKeyPem: string;

	// ローカル・本番環境によってファイル・環境変数の読み込みを分ける
	if (process.env.JWT_PRIVATE_KEY) {
		privateKeyPem = process.env.JWT_PRIVATE_KEY!.replace(/\\n/g, "\n");
	} else {
		privateKeyPem = fs.readFileSync("keys/private.pem", "utf-8");
	}

	const privateKey = await importPKCS8(privateKeyPem, "RS256");

	return await new SignJWT(payload)
		.setProtectedHeader({ alg: "RS256", typ: "JWT" })
		.setIssuedAt()
		.setIssuer("understanding-debt-checker-next")
		.setAudience("understanding-debt-checker-rails")
		.setExpirationTime("1h")
		.sign(privateKey);
}
