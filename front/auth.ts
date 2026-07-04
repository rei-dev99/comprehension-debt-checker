import NextAuth from "next-auth";
import Credentials from "next-auth/providers/credentials";
import Google from "next-auth/providers/google";
import { credentialSchema } from "./app/lib/zod";

export const { handlers, signIn, signOut, auth } = NextAuth({
	trustHost: true,
	secret: process.env.AUTH_SECRET,
	providers: [
		Google,
		Credentials({
			credentials: {
				email: {},
				loginType: {},
				password: {},
			},
			authorize: async (credentials) => {
				if (credentials.loginType === "guest") {
					const res = await fetch(
						`${process.env.NEXT_PUBLIC_API_BASE_URL}/guest_login`,
						{
							method: "POST",
							headers: { "Content-Type": "application/json" },
						},
					);
					if (!res.ok) return null;
					const data = await res.json();
					return {
						id: data.user.id,
						provider: data.user.provider,
						uid: data.user.uid,
						email: data.user.email as string,
					};
				} else {
					try {
						const { email, password } =
							await credentialSchema.parseAsync(credentials);
						const res = await fetch(
							`${process.env.NEXT_PUBLIC_API_BASE_URL}/login_email`,
							{
								method: "POST",
								headers: { "Content-Type": "application/json" },
								body: JSON.stringify({ email, password }),
							},
						);
						if (!res.ok) return null;
						const data = await res.json();
						return {
							id: data.user.id,
							provider: data.user.provider,
							uid: data.user.uid,
							email: credentials.email as string,
						};
					} catch (e) {
						console.error(e);
						return null;
					}
				}
			},
		}),
	],
	session: {
		strategy: "jwt",
		maxAge: 60 * 60 * 24 * 3,
		updateAge: 60 * 60 * 24 * 365,
	},
	callbacks: {
		async jwt({ token, user, account, profile }) {
			if (user) {
				token.email = user.email;
			}

			if (account?.provider === "google") {
				token.provider = account.provider;
				token.uid = profile?.sub;
			}

			if (account?.provider === "credentials" && user) {
				token.provider = user.provider;
				token.uid = user.uid;
			}
			return token;
		},
		async session({ session, token }) {
			if (session.user) {
				session.user.email = token.email as string;
				session.user.provider = token.provider as string;
				session.user.uid = token.uid as string;
			}
			return session;
		},
	},
});
