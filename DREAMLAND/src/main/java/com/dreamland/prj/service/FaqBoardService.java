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
}
