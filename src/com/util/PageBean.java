package com.util;

import java.util.ArrayList;
import java.util.List;

public class PageBean {
	private int totalRows;
	@SuppressWarnings("unused")
	private int totalPages;
	private int currentPage;
	private int pageSize;
	@SuppressWarnings("rawtypes")
	private List data = new ArrayList();

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public int getTotalPages() {
		return totalRows % pageSize == 0 ? totalRows / pageSize : totalRows
				/ pageSize + 1;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	@SuppressWarnings("rawtypes")
	public List getData() {
		return data;
	}

	@SuppressWarnings("rawtypes")
	public void setData(List data) {
		this.data = data;
	}

}
