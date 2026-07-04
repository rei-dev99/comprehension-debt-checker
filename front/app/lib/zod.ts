import { z } from "zod";

export const numberPattern = /(?=.*\d)/;

export const credentialSchema = z.object({
	email: z
		.string()
		.min(1, "メールアドレスを入力してください")
		.email("正しいメールアドレスを入力してください"),
	password: z
		.string()
		.min(1, "パスワードを入力してください")
		.min(8, "8文字以上で入力してください")
		.regex(numberPattern, "数字を含めてください"),
});

export type CredentialType = z.infer<typeof credentialSchema>;
