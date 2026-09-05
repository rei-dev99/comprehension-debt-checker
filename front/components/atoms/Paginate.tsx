import ReactPaginate from "react-paginate";
import type { Pagination } from "@/types/result";

interface PaginateProps {
	currentPage: number;
	pagination: Pagination;
	onPageChange: (item: { selected: number }) => void;
}

export default function Paginate({
	currentPage,
	pagination,
	onPageChange,
}: PaginateProps) {
	return (
		<ReactPaginate
			forcePage={currentPage - 1}
			breakLabel="..."
			nextLabel=">"
			onPageChange={onPageChange}
			pageCount={pagination.pages}
			previousLabel="<"
			renderOnZeroPageCount={null}
			containerClassName="mt-8 flex items-center justify-center gap-2"
			pageLinkClassName="flex h-8 w-8 shrink-0 cursor-pointer items-center justify-center rounded-full bg-sky-600 text-sm font-bold text-white transition-opacity duration-200 hover:opacity-70"
			activeLinkClassName="bg-yellow-500 ring-2 ring-yellow-300"
			previousLinkClassName="flex h-8 w-8 cursor-pointer items-center justify-center rounded-full border border-sky-600 text-sky-600 transition-opacity duration-200 hover:opacity-70"
			nextLinkClassName="flex h-8 w-8 cursor-pointer items-center justify-center rounded-full border border-sky-600 text-sky-600 transition-opacity duration-200 hover:opacity-70"
			disabledClassName="hidden"
		/>
	);
}
