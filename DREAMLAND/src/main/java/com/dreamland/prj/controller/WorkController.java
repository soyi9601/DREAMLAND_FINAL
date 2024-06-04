package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dreamland.prj.service.WorkService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/work")
@RequiredArgsConstructor
@Controller
public class WorkController {
  private final WorkService workService;
	
	// 근무관리 페이지이동
	@GetMapping("/status.do")
	public String statusPage(HttpServletRequest request, Model model) {
	  String email = getEmailFromSecurityContext();
    Map<String, Object> attendanceCounts = workService.getWorkCountByEmail(email);
    
    model.addAttribute("lateCount", attendanceCounts.get("lateCount"));
    model.addAttribute("earlyLeaveCount", attendanceCounts.get("earlyLeaveCount"));
    model.addAttribute("absenceCount", attendanceCounts.get("absenceCount"));
    model.addAttribute("totalWorkDays", attendanceCounts.get("totalWorkDays"));
    model.addAttribute("totalWorkHours", attendanceCounts.get("totalWorkHours"));
    model.addAttribute("avgWorkHours", attendanceCounts.get("avgWorkHours"));
    
    return "work/workingStatus";
//	  Map<String, Object> workCount = workService.getWorkCount(request);
//	  
//    model.addAttribute("lateCount", workCount.get("lateCount"));
//    model.addAttribute("earlyLeaveCount", workCount.get("earlyLeaveCount"));
//    model.addAttribute("absenceCount", workCount.get("absenceCount"));
//  
//	  return "work/workingStatus";
	}
	
	// 휴가관리 페이지이동
  @GetMapping("/dayoff.do")
  public String dayoffPage() {
    return "work/dayoff";
  }
  
  private String getEmailFromSecurityContext() {
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    if (principal instanceof UserDetails) {
        return ((UserDetails) principal).getUsername();
    } else {
        return principal.toString();
    }
  }
}