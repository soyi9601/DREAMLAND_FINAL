package com.dreamland.prj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;
import com.dreamland.prj.service.dayoffService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/dayoff")
@RequiredArgsConstructor
@Controller
public class DayoffController {
  private final dayoffService dayoffService;
	
	// 휴가관리 페이지이동
  @GetMapping("/info.do")
  public String dayoffPage(Model model) {
    EmployeeDto employee = getEmployeeFromSession();
    int totalDayOff = employee.getDayOff();
    int usedDayOff = employee.getUsedDayOff();
    int remainingDayOff = dayoffService.calculateRemainingDayOff(totalDayOff, usedDayOff);
    
    List<Integer> yearList = dayoffService.getYearList(employee.getEmpNo());
    
    model.addAttribute("totalDayOff", totalDayOff);
    model.addAttribute("usedDayOff", usedDayOff);
    model.addAttribute("remainingDayOff", remainingDayOff);
    model.addAttribute("yearList", yearList);
    
    return "dayoff/info";
  }
  
  // 휴가 리스트 조회 (연도별)
  @GetMapping("/list.do")
  public ResponseEntity<Map<String, Object>> getLeaveListByYear(@RequestParam int year) {
    //String email = getEmailFromSecurityContext();  
    //List<AppleaveDto> leaveList = dayoffService.getDayoffListByYear(email, year);
    EmployeeDto employee = getEmployeeFromSession();
    List<AppleaveDto> dayoffList = dayoffService.getDayoffListByYear(employee.getEmpNo(), year);
    
    Map<String, Object> result = new HashMap<>();
    result.put("dayoffList", dayoffList);
    System.out.println("====== 휴가 리스트 ======");
    System.out.println("Selected Year: " + year);
    System.out.println("Dayoff List: " + dayoffList);
    
    return ResponseEntity.ok(result);
  }
  
  //현재 로그인된 사용자의 이메일을 가져오는 메소드
//  private String getEmailFromSecurityContext() {
//    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//    if (principal instanceof UserDetails) {
//        return ((UserDetails) principal).getUsername();
//    } else {
//        return principal.toString();
//    }
//  }
  
 // 입사일 기준으로 연도 리스트 생성
//  @GetMapping("/yearList.do")
//  public ResponseEntity<Map<String, Object>> getYearList() {
//    EmployeeDto employee = getEmployeeFromSession();
//    List<Integer> yearList = dayoffService.getYearList(employee.getEmpNo());
//  
//    Map<String, Object> result = new HashMap<>();
//    result.put("yearList", yearList);
//    
//    return ResponseEntity.ok(result);
//  }
  
  // 세션 정보
  private EmployeeDto getEmployeeFromSession() {
    PrincipalUser principalUser = (PrincipalUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    return principalUser.getEmployeeDto();
}
  
}