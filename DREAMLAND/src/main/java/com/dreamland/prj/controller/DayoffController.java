package com.dreamland.prj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dreamland.prj.service.dayoffService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/dayoff")
@RequiredArgsConstructor
@Controller
public class DayoffController {
  private final dayoffService dayoffService;
	
//	// 근무관리 페이지이동
//	@GetMapping("/status.do")
//	public String statusPage(HttpServletRequest request, Model model) {
//	  String email = getEmailFromSecurityContext();
//    Map<String, Object> attendanceCounts = workService.getWorkCountByEmail(email);
//   
//    
//    return "work/workingStatus";
//	}
	
	// 휴가관리 페이지이동
  @GetMapping("/info.do")
  public String dayoffPage() {
    return "dayoff/info";
  }
  
//  private String getEmailFromSecurityContext() {
//    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//    if (principal instanceof UserDetails) {
//        return ((UserDetails) principal).getUsername();
//    } else {
//        return principal.toString();
//    }
//  }
}