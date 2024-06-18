package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    model.addAttribute("absenceCount", attendanceCounts.get("absenceCount"));
    model.addAttribute("totalWorkDays", attendanceCounts.get("totalWorkDays"));
    model.addAttribute("totalWorkHours", attendanceCounts.get("totalWorkHours"));
    model.addAttribute("avgWorkHours", attendanceCounts.get("avgWorkHours"));
    model.addAttribute("employee", attendanceCounts.get("employee"));
    
    return "work/workingStatus";
	}
	
	// 근무정보 리스트 (기간조회)
	@GetMapping("/list.do")
	public ResponseEntity<Map<String, Object>> getWorkListByPeriod(@RequestParam String startDate, @RequestParam String endDate, Model model) {
	  String email = getEmailFromSecurityContext();
	  Map<String, Object> workList = workService.getWorkListByPeriod(email, startDate, endDate);

	  return new ResponseEntity<>(workList, HttpStatus.OK);
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