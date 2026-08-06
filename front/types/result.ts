export interface CategoryAdvice {
	name: string;
	summary: string;
	advices: string[];
}

export interface Result {
	id: number;
	ai_score: number;
	algorithm_score: number;
	db_score: number;
	web_score: number;
	dependency_score: number;
	advices: Record<string, CategoryAdvice>;
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
