export interface CategoryAdvice {
	name: string;
	summary: string;
	advices: string[];
}

export interface AiAdviceAction {
	category: string;
	title: string;
	detail: string;
}

/** OpenAIで生成したアドバイス。生成に失敗した診断ではnull */
export interface AiAdvice {
	overall: string;
	ai_usage: string;
	actions: AiAdviceAction[];
}

export interface Result {
	id: number;
	ai_score: number;
	algorithm_score: number;
	db_score: number;
	web_score: number;
	dependency_score: number;
	advices: Record<string, CategoryAdvice>;
	ai_advice: AiAdvice | null;
	created_at: string;
}

export interface Pagination {
	current: number;
	previous: number | null;
	next: number | null;
	limit_value: number;
	pages: number;
	count: number;
}

export interface ResultsResponse {
	results: Result[];
	pagination: Pagination;
}
