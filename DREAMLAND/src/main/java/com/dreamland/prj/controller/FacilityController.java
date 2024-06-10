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

import com.dreamland.prj.dto.FacilityDto;
import com.dreamland.prj.service.FacilityService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/facility")
@RequiredArgsConstructor
@Controller
public class FacilityController {

		private final FacilityService facilityService;
		
		@GetMapping("/list.do")
		public String list(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			facilityService.loadFacilityList(model);
			return "facility/list";
		}
		
		@GetMapping("/write.page")
		public String writePage() {
			return "facility/write";
		}
		
		@PostMapping("/register.do")
		public String register(MultipartHttpServletRequest multipartRequest
												,  RedirectAttributes redirectAttributes) {
			redirectAttributes.addFlashAttribute("inserted", facilityService.registerFacility(multipartRequest));
			return "redirect:/facility/list.do";
		}	
		
		@GetMapping("/detail.do")
		public String detail(@RequestParam(value="facilityNo", required=false, defaultValue="0") int facilityNo
												,Model model) {
			facilityService.loadFacilityByNo(facilityNo, model);
			return "facility/detail";
		}
		
		@GetMapping("/download.do")
		public ResponseEntity<Resource> download(HttpServletRequest request) {
			return facilityService.download(request);
		}
		
		@PostMapping("/edit.do")
		public String edit(@RequestParam int facilityNo, Model model) {
			model.addAttribute("facility", facilityService.getFacilityByNo(facilityNo));
			return "facility/edit";
		}
		
		@PostMapping("/edit2.do")
		public String edit2(@RequestParam int facilityNo, Model model) {
			model.addAttribute("facility", facilityService.getFacilityByNo(facilityNo));
			return "facility/edit";
		}
		
		@GetMapping(value="/attachList.do", produces="application/json")
		public ResponseEntity<Map<String, Object>> attachList(@RequestParam int facilityNo){
			return facilityService.getAttachList(facilityNo);
		}
		
		@PostMapping("/modify.do")
		public String modify(FacilityDto facility, RedirectAttributes redirectAttributes) {
			
			// todo delAttachList를 split("|")해서 attachNo를 delete하는 구문 작성(service, mapper-sql)
			
			String[] delAttachArr = facility.getDelAttachList().split("\\|");
			for (String attachNo : delAttachArr) {
				if(!attachNo.isEmpty()) {
					facilityService.deleteAttach(Integer.parseInt(attachNo));
				}
			}
			
			// todo insAttachList를 split("|")해서 attachNo를 insert하는 구문 작성
			redirectAttributes
				.addAttribute("facilityNo", facility.getFacilityNo())
				.addFlashAttribute("modifyResult", facilityService.modifyFacility(facility) == 1 ? "수정되었습니다." : "수정을 하지 못했습니다.");
			return "redirect:/facility/detail.do?facilityNo={facilityNo}";
		}
		
		@PostMapping(value="/addAttach.do", produces="application/json")
		public ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception {
			return facilityService.addAttach(multipartRequest);
		}
		
		@PostMapping("/removeFacility.do")
		public String removefacility(@RequestParam(value="facilityNo", required=false, defaultValue="0") int facilityNo
															 , RedirectAttributes redirectAttributes) {
			int removeCount = facilityService.removeFacility(facilityNo);
			redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "삭제되었습니다." : "삭제를 하지 못했습니다.");
			return "redirect:/facility/list.do";
		}
		
		@PostMapping("/removeNo.do")
		@ResponseBody
		public String delete(@RequestParam List<Integer> no) {
		    int deleteCount = 0;
		    for (int n : no) {
		        facilityService.removeFacility(n);
		        deleteCount++;
		    }
		    return deleteCount > 0 ? "삭제되었습니다." : "삭제할 게시글이 없습니다.";
		}
}











