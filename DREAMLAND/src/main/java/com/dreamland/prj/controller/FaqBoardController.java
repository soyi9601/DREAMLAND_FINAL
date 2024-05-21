package com.dreamland.prj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.service.FaqBoardService;


import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/board/faq")
@RequiredArgsConstructor
@Controller
public class FaqBoardController {
	private final FaqBoardService faqBoardService;
	
	 @GetMapping("/list.do")
	  public String list(HttpServletRequest request, Model model) {
		 	 model.addAttribute("request", request);
		 	 faqBoardService.loadFaqBoardList(model);
	    return "board/faq/list";
	  }
	 
	  @GetMapping("/write.page")
	  public String writePage() {
	    return "board/faq/write";
	  } 
	  @PostMapping("/registerFaq.do")
	  public String register(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		  redirectAttributes.addFlashAttribute("insertFaqCount", faqBoardService.registerFaq(request));
		 return "redirect:/board/faq/list.do";
	  }
	  @GetMapping("/edit.do")
	  public String edit(@RequestParam int faqNo, Model model) {
	  	model.addAttribute("faq",faqBoardService.getFaqBoardByNo(faqNo));
	  	return "board/faq/edit";
	  }
	  
	  @PostMapping("/modify.do")
	  public String modify(FaqBoardDto faq, RedirectAttributes redirectAttributes) {
	  		redirectAttributes.addFlashAttribute("faqNo",faq.getFaqNo());
	  	  redirectAttributes.addFlashAttribute("modifyResult", faqBoardService.modifyFaqBoard(faq) == 1 ? "수정되었습니다." : "수정을 하지 못했습니다.");
	  	return "redirect:/board/faq/list.do"; 
	  }
	  
	  @GetMapping("/remove.do")
	  public String remove(@RequestParam int faqNo, RedirectAttributes redirectAttributes) {
	  		int removeCount = faqBoardService.removeFaqBoard(faqNo);
	  	  redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "삭제되었습니다." : "삭제를 하지 못했습니다.");
	  	return "redirect:/board/faq/list.do"; 
	  }
	  
	  
}
