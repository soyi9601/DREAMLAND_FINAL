package com.dreamland.prj.service;

import org.springframework.ui.Model;

import com.dreamland.prj.dto.FaqBoardDto;

import jakarta.servlet.http.HttpServletRequest;

public interface FaqBoardService {
	int registerFaq(HttpServletRequest request);
	void loadFaqBoardList(Model model);
	FaqBoardDto getFaqBoardByNo(int boardNo);
	int modifyFaqBoard(FaqBoardDto faqBoardDto);
	int removeFaqBoard(int faqNo);
	// 분류 카테고리 
	void loadFaqCategoryList(HttpServletRequest request, Model model);
	// 검색
	void loadFaqSearchList(HttpServletRequest request, Model model);
	
}
