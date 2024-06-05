package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamland.prj.service.BlindBoardService;


import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/board/blind")
@RequiredArgsConstructor
@Controller
public class BlindBoardController {
	
	private final BlindBoardService blindBoardService;
	
	@GetMapping("/list.page")
	public String list() {
		return "board/blind/list";
	}
	
	@GetMapping("/write.page")
	public String writePage() {
		return "board/blind/write";
	}
	
	@PostMapping(value="/summernote/imageUpload.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> summernoteImageUpload(@RequestParam("image") MultipartFile multipartFile){
		return blindBoardService.summernoteImageUpload(multipartFile);
	}
	
	
	@PostMapping("/registerBlind.do")
	public String register(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		int insertCount = blindBoardService.registerBlind(request);
		redirectAttributes.addFlashAttribute("insertResult", insertCount == 1 ? "블로그가 등록되었습니다." : "블로그가 등록되지 않았습니다.");
		return "redirect:/board/blind/list.page";
	}
	
	
	@GetMapping(value="/getBlindList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> getBlindList(HttpServletRequest request){
		return blindBoardService.getBlindList(request);
	}
	
	@GetMapping("/detail.do")
	public String detail(@RequestParam int blindNo, Model model) {
		model.addAttribute("blind", blindBoardService.getBlindByNo(blindNo));
		return "board/blind/detail";
	}
	
	
	@GetMapping("/edit.do")
	public String editBlind(@RequestParam int blindNo, Model model) {
		model.addAttribute("blind", blindBoardService.getBlindByNo(blindNo));
		return "board/blind/edit";
	}
	
	// 비밀번호
	@PostMapping("/validateEdit.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> validateEdit(@RequestParam int blindNo, @RequestParam String password) {
	    boolean isValid = blindBoardService.validatePassword(blindNo, password);
	    if (isValid) {
	        return ResponseEntity.ok(Map.of("success", true));
	    } else {
	    	
	        return ResponseEntity.ok(Map.of("success", false, "message", "비밀번호가 맞지않습니다."));
	    }
	}
	
	@PostMapping("/validateRemove.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> validateRemove(@RequestParam int blindNo, @RequestParam String password) {
	    boolean isValid = blindBoardService.validatePassword(blindNo, password);
	    if (isValid) {
	        return ResponseEntity.ok(Map.of("success", true));
	    } else {
	        return ResponseEntity.ok(Map.of("success", false, "message", "비밀번호가 맞지않습니다."));
	    }
	}
	
	@PostMapping("/modify.do")
	public String modify(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		
		int modifyCount = blindBoardService.modifyBlind(request);
		redirectAttributes
				.addAttribute("blindNo", request.getParameter("blindNo"))
				.addFlashAttribute("modifyResult",modifyCount == 1 ? "수정되었습니다.": "수정되지 않았습니다.");
		return "redirect:/board/blind/detail.do?blindNo={blindNo}";
	}
	
	
	// 본인삭제
	@GetMapping("/removeBlind.do")
	public String removeBlind(@RequestParam(value="blindNo", required=false, defaultValue = "0") int blindNo
													 , RedirectAttributes redirectAttributes) {
		int removeCount = blindBoardService.removeBlind(blindNo);
		redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "게시글이 삭제되었습니다." : "게시글이 삭제되지 않았습니다.");
    return "redirect:/board/blind/list.page";
	}
	
	//관리자삭제
	@PostMapping("/removeBlind.do")
	public String removeBlindAdmin(@RequestParam(value="blindNo", required=false, defaultValue = "0") int blindNo
													 , RedirectAttributes redirectAttributes) {
		int removeCount = blindBoardService.removeBlind(blindNo);
		redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "게시글이 삭제되었습니다." : "게시글이 삭제되지 않았습니다.");
    return "redirect:/board/blind/list.page";
	}
	
	
	//조회수
	@GetMapping("/updateHit.do")
	public String updateHit(@RequestParam int blindNo) {
		blindBoardService.updateHit(blindNo);
		return "redirect:/board/blind/detail.do?blindNo=" + blindNo;
	}
	
	// 댓글
	@PostMapping(value = "/regitserComment.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> registerComment(HttpServletRequest request){
		return ResponseEntity.ok(Map.of("insertCount", blindBoardService.registerComment(request)));
	}
	
	@GetMapping(value="/comment/list.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> commentList(HttpServletRequest request){
		return ResponseEntity.ok(blindBoardService.getCommentList(request));
	}
	
	@PostMapping(value="/comment/registerReply.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> registerReply(HttpServletRequest request){
		return ResponseEntity.ok(Map.of("insertReplyCount", blindBoardService.registerReply(request)));
	}
	
	@GetMapping(value="/removeComment.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> removeComment(@RequestParam(value="commentNo", required=false, defaultValue="0") int commentNo){
    return ResponseEntity.ok(Map.of("removeResult", blindBoardService.removeComment(commentNo) == 1 ? "댓글이 삭제되었습니다." : "댓글이 삭제되지 않았습니다."));
	}
	
	
	// 댓글 비밀번호확인
	// 비밀번호
	@PostMapping("/validatePw.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> validatePw(@RequestParam int commentNo, @RequestParam String pw) {
	    boolean isValid = blindBoardService.validatePw(commentNo, pw);
	    if (isValid) {
	        return ResponseEntity.ok(Map.of("success", true));
	    } else {
	    	
	        return ResponseEntity.ok(Map.of("success", false, "message", "비밀번호가 맞지않습니다."));
	    }
	}
}
