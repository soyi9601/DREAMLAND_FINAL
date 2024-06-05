package com.dreamland.prj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
}
