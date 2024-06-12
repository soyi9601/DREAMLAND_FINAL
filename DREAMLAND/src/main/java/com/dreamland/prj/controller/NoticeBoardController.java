package com.dreamland.prj.controller;

import java.util.List;
import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamland.prj.dto.NoticeBoardDto;
import com.dreamland.prj.service.NoticeBoardService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/board/notice")
@RequiredArgsConstructor
@Controller
public class NoticeBoardController {
	
	private final NoticeBoardService noticeBoardService;
	
	@GetMapping("/list.do")
	public String list(HttpServletRequest request, Model model) {
	 	 model.addAttribute("request", request);
	 	 noticeBoardService.loadNoticeList(model);
	 	 return "board/notice/list";
	}
	
	//삭제 후 비동기 목록갱신
	@GetMapping("/listAjax")
  public String listAjax(Model model) {
      noticeBoardService.loadNoticeList(model);
      return "board/notice/list :: .table-border-bottom-0";
  }
	
	@GetMapping("/write.page")
	public String writePage() {
		return "board/notice/write";
	}
	
	@PostMapping("/registerNotice.do")
	public String register(MultipartHttpServletRequest multipartRequest
												, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("inserted", noticeBoardService.registerNotice(multipartRequest));
		return "redirect:/board/notice/list.do";
	}
	
	@GetMapping("/detail.do")
	public String detail(@RequestParam(value="noticeNo", required=false,  defaultValue="0") int noticeNo
											,Model model) {
		noticeBoardService.loadNoticeByNo(noticeNo, model);
		return "board/notice/detail";
	}
	
	@GetMapping("/download.do")
  public ResponseEntity<Resource> download(HttpServletRequest request) {
		return noticeBoardService.download(request);
  }
	
  @GetMapping(value="/downloadAll.do", produces="application/octet-stream")
  public ResponseEntity<Resource> downloadAll(HttpServletRequest request) {
    return noticeBoardService.downloadAll(request);
  }
	
  @PostMapping("/edit.do")
  public String edit(@RequestParam int noticeNo, Model model) {
    model.addAttribute("notice", noticeBoardService.getNoticeByNo(noticeNo));
    return "board/notice/edit";
  }
  
  
  @GetMapping(value="/attachList.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> attachList(@RequestParam int noticeNo) {
    return noticeBoardService.getAttachList(noticeNo);
  }
  
  
  @PostMapping("/modify.do")
  public String modify(NoticeBoardDto notice, RedirectAttributes redirectAttributes) {
  	
  	// todo delAttachList를 split("|") 해서 attachNo를 delete하는 구문 작성(service, mapper-sql)
  	String[] delAttachArr = notice.getDelAttachList().split("\\|");
  	for (String attachNo : delAttachArr) {
  	    if (!attachNo.isEmpty()) {
  	        noticeBoardService.deleteAttach(Integer.parseInt(attachNo));
  	        System.out.println(noticeBoardService.deleteAttach(Integer.parseInt(attachNo)));
  	    }
  	}
  	
  	// todo insAttachList를 split("|") 해서 attachNo를 insert하는 구문 작성
    redirectAttributes
      .addAttribute("noticeNo", notice.getNoticeNo())
      .addFlashAttribute("modifyResult", noticeBoardService.modifyNotice(notice) == 1 ? "수정되었습니다." : "수정을 하지 못했습니다.");
    return "redirect:/board/notice/detail.do?noticeNo={noticeNo}";
  }		
 
 
  @PostMapping(value="/addAttach.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception {
    return noticeBoardService.addAttach(multipartRequest);
  }
	
  @PostMapping("/removeNotice.do")
  public String removeNotice(@RequestParam(value="noticeNo", required=false, defaultValue="0") int noticeNo
                           , RedirectAttributes redirectAttributes) {
    int removeCount = noticeBoardService.removeNotice(noticeNo);
    redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "삭제되었습니다." : "삭제를 하지 못했습니다.");
    return "redirect:/board/notice/list.do";
  }
  
  // 게시글 목록(list)에서 체크박스로 삭제
  @PostMapping("/removeNo.do")
  @ResponseBody  
  public String delete(@RequestParam List<Integer> no) {
  		int deleteCount = 0;
      for (int n : no) {
          noticeBoardService.removeNotice(n);
          deleteCount++;
      }
      return deleteCount > 0 ? "삭제되었습니다." : "삭제할 게시글이 없습니다.";
  }
  
  @GetMapping("/updateHit.do")
  public String updateHit(@RequestParam int noticeNo) {
  	noticeBoardService.updateHit(noticeNo);
  	return "redirect:/board/notice/detail.do?noticeNo=" + noticeNo;
  }
  
}
