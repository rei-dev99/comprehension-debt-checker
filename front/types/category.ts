export interface Category {
	id: number;
	name: string;
	questions: {
		id: number;
		content: string;
		choices: {
			id: number;
			content: string;
			score: number;
		}[];
	}[];
}
