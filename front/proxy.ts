import { NextResponse } from "next/server";
import { auth } from "@/auth";

const guestRoutes = ["/login", "/signup"];
const protectedRoutes = ["/question", "/results", "/mypage"];

export default auth((req) => {
	const session = req.auth;
	const pathname = req.nextUrl.pathname;

	const isGuest = guestRoutes.includes(pathname);
	const isProtected = protectedRoutes.some((route) =>
		pathname.startsWith(route),
	);

	// 未認証で protected
	if (!session && isProtected) {
		return NextResponse.redirect(new URL("/login", req.url));
	}

	// 認証済みで login/signup
	if (session && isGuest) {
		return NextResponse.redirect(new URL("/mypage", req.url));
	}

	return NextResponse.next();
});

export const config = {
	matcher: ["/((?!api|_next/static|_next/image|favicon.ico).*)"],
};
