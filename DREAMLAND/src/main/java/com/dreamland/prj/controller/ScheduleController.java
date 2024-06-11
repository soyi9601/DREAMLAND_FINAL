package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;
import com.dreamland.prj.dto.ScheduleDto;
import com.dreamland.prj.service.ScheduleService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/schedule")
@RequiredArgsConstructor
@Controller
public class ScheduleController {
	private final ScheduleService scheduleService;
	
  //일정 조회
  @GetMapping(value="/calendar.do", produces="application/json")
  public String list(HttpServletRequest request, Model model) {
    EmployeeDto loginEmployee = getEmployeeFromSession(); // 현재 세션에서 로그인된 사용자 정보 가져옴
    model.addAttribute("loginEmployee", loginEmployee);   // 사용자 정보 모델에 추가
    scheduleService.loadSkdList(request, model);          // 일정목록
    return "schedule/calendar";
  }
	
  //일정 등록
  @PostMapping(value="/register.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> register(HttpServletRequest requset) {
    return ResponseEntity.ok(Map.of("insertSkdCount", scheduleService.registerSkd(requset)));
  }
  
  // 일정 상세보기
  @GetMapping("/detail.do")
  public String detail(@RequestParam int skdNo, Model model) {
    model.addAttribute("skd", scheduleService.getSkdByNo(skdNo));
    return "schedule/detail";
  }
  
  //일정 수정
  @PostMapping("/modify.do")
  public ResponseEntity<Map<String, Object>> modify(@RequestBody ScheduleDto schedule) {
     int modifyCount = scheduleService.modifySkd(schedule);
     return ResponseEntity.ok(Map.of("modifyCount", modifyCount));
  }
  
  // 일정 삭제
  @GetMapping("/remove.do")
  public String remove(@RequestParam int skdNo, RedirectAttributes redirectAttributes) {
      int removeCount = scheduleService.removeSkd(skdNo);
      redirectAttributes.addFlashAttribute("removeResult", removeCount == 1 ? "삭제되었습니다." : "삭제를 하지 못했습니다.");
    return "redirect:/schedule/calendar.do"; 
  }
  
  // 현재 세션에서 로그인된 사용자 정보 가져옴
  private EmployeeDto getEmployeeFromSession() {
    // Spring Security Context에서 PrincipalUser 객체를 가져옴
    PrincipalUser principalUser = (PrincipalUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    return principalUser.getEmployeeDto(); // PrincipalUser 객체에서 EmployeeDto를 반환
  }
  
}