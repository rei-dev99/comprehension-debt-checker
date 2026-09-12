export type DependencyLevel = "safe" | "warning" | "danger";

interface DependencyLevelStyle {
	level: DependencyLevel;
	label: string;
	emoji: string;
	textClassName: string;
	badgeClassName: string;
	cardClassName: string;
}

const styles: Record<DependencyLevel, DependencyLevelStyle> = {
	safe: {
		level: "safe",
		label: "良好",
		emoji: "🟢",
		textClassName: "text-emerald-600",
		badgeClassName: "bg-emerald-100 text-emerald-700",
		cardClassName: "bg-emerald-50 border-emerald-200",
	},
	warning: {
		level: "warning",
		label: "注意",
		emoji: "🟡",
		textClassName: "text-amber-600",
		badgeClassName: "bg-amber-100 text-amber-700",
		cardClassName: "bg-amber-50 border-amber-200",
	},
	danger: {
		level: "danger",
		label: "要注意",
		emoji: "🔴",
		textClassName: "text-red-600",
		badgeClassName: "bg-red-100 text-red-700",
		cardClassName: "bg-red-50 border-red-200",
	},
};

export function getDependencyLevel(score: number): DependencyLevelStyle {
	if (score >= 70) return styles.danger;
	if (score >= 40) return styles.warning;
	return styles.safe;
}
