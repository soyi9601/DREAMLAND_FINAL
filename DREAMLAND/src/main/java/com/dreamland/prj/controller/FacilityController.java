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
		
		//시설 목록 조회 페이지
		@GetMapping("/list.do")
		public String list(HttpServletRequest request, Model model) {
			model.addAttribute("request", request);
			facilityService.loadFacilityList(model);
			return "facility/list";
		}
		
		//삭제 후 비동기 목록갱신
		@GetMapping("/listAjax")
	  public String listAjax(Model model) {
	      facilityService.loadFacilityList(model);
	      return "facility/list :: .table-border-bottom-0";
	  }
		
		// 시설 등록 페이지 이동
		@GetMapping("/write.page")
		public String writePage() {
			return "facility/write";
		}
		
		// 시설 등록 처리
		@PostMapping("/register.do")
		public String register(MultipartHttpServletRequest multipartRequest
												,  RedirectAttributes redirectAttributes) {
			redirectAttributes.addFlashAttribute("inserted", facilityService.registerFacility(multipartRequest));
			return "redirect:/facility/list.do";
		}	
		
		// 시설 상세 정보 조회
		@GetMapping("/detail.do")
		public String detail(@RequestParam(value="facilityNo", required=false, defaultValue="0") int facilityNo
												,Model model) {
			facilityService.loadFacilityByNo(facilityNo, model);
			return "facility/detail";
		}
		
		// 첨부 파일 다운로드
		@GetMapping("/download.do")
		public ResponseEntity<Resource> download(HttpServletRequest request) {
			return facilityService.download(request);
		}
		
		// 시설 수정 페이지 이동
		@PostMapping("/edit.do")
		public String edit(@RequestParam int facilityNo, Model model) {
			model.addAttribute("facility", facilityService.getFacilityByNo(facilityNo));
			return "facility/edit";
		}
		
		// 시설의 첨부 파일 목록 조회 (JSON 형식)
		@GetMapping(value="/attachList.do", produces="application/json")
		public ResponseEntity<Map<String, Object>> attachList(@RequestParam int facilityNo){
			return facilityService.getAttachList(facilityNo);
		}
		
		// 시설 수정 처리
		@PostMapping("/modify.do")
		public String modify(FacilityDto facility, RedirectAttributes redirectAttributes) {
			
			// 삭제할 첨부 파일 목록을 처리합니다
			String[] delAttachArr = facility.getDelAttachList().split("\\|");
			for (String attachNo : delAttachArr) {
				if(!attachNo.isEmpty()) {
					facilityService.deleteAttach2(Integer.parseInt(attachNo));
				}
			}
			
			// 시설 정보를 수정하고 결과를 리다이렉트 속성에 추가
			redirectAttributes
				.addAttribute("facilityNo", facility.getFacilityNo())
				.addFlashAttribute("modifyResult", facilityService.modifyFacility(facility) == 1 ? "수정되었습니다." : "수정을 하지 못했습니다.");
			return "redirect:/facility/detail.do?facilityNo={facilityNo}";
		}
		
		// 첨부 파일 추가 처리 (JSON 형식으로 결과 반환)
	  @PostMapping(value="/addAttach.do", produces="application/json")
	  public ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception {
	    System.out.println(multipartRequest + "안녕");
	  	return facilityService.addAttach(multipartRequest);
	  }
		
		// 시설 삭제 처리
		@PostMapping("/removeFacility.do")
		public String removefacility(@RequestParam(value="facilityNo", required=false, defaultValue="0") int facilityNo
															 , RedirectAttributes redirectAttributes) {
			int removeCount = facilityService.removeFacility(facilityNo);
			redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "삭제되었습니다." : "삭제를 하지 못했습니다.");
			return "redirect:/facility/list.do";
		}
		
		// 여러 시설 삭제 처리 (비동기 방식으로 결과 반환)
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











