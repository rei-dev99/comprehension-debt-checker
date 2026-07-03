'use client';

import { useState } from "react";
import { credentialSchema } from "@/app/lib/zod";

import z from "zod";
import { handleLogin } from "@/actions/handleLogin";

export function LoginForm() {
    // エラーメッセージの状態管理
    const [emailError, setEmailError] = useState('');
    const [passwordError, setPasswordError] = useState('');

    const handleSubmit = (formData: FormData) =>  {
        // エラー内容リセット
        setEmailError('')
        setPasswordError('')

        const email = String(formData.get("email") ?? "");
        const password = String(formData.get("password") ?? "");

        // zodによるバリデーション
        const validation = credentialSchema.safeParse({ email, password });

        if (!validation.success) {
            const errors = z.flattenError(validation.error).fieldErrors;
            setEmailError(errors.email?.[0] ?? '')
            setPasswordError(errors.password?.[0] ?? '')
            return
        }

        handleLogin({email, password})
    }

    return (
        <form className="border-b border-dashed pb-6" action={handleSubmit}>
            {emailError && <p className="text-red-500">{emailError}</p>}
            <div className="mb-4">
                <label className="block text-gray-700 text-sm font-bold mb-2">
                    メールアドレス
                </label>
                <input
                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    id="email"
                    type="email"
                    placeholder="メールアドレス"
                    name="email"
                />
            </div>
            {passwordError && <p className="text-red-500">{passwordError}</p>}
            <div className="mb-6">
                <label className="block text-gray-700 text-sm font-bold mb-2">
                    パスワード
                </label>
                <input
                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
                    id="password"
                    type="password"
                    placeholder="パスワード"
                    name="password"
                />
            </div>
            <div className="flex justify-center">
                <button
                    className="cursor-pointer bg-blue-500 hover:bg-blue-700 transition text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                    type="submit"
                >
                    ログインする
                </button>
            </div>
        </form>
    )
}
