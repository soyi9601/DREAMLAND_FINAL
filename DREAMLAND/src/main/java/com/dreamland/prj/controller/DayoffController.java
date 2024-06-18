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
  
  //휴가관리 페이지이동
  @GetMapping("/info.do")
  public String dayoffPage(Model model) {
      EmployeeDto loginEmployee = getEmployeeFromSession();
      dayoffService.loadDayoffData(model, loginEmployee);
      return "dayoff/info";
  }
	
  // 휴가 리스트 조회 (연도별)
  @GetMapping("/list.do")
  public ResponseEntity<Map<String, Object>> getLeaveListByYear(@RequestParam int year) {
      EmployeeDto loginEmployee = getEmployeeFromSession();
      List<AppleaveDto> dayoffList = dayoffService.getDayoffListByYear(loginEmployee.getEmpNo(), year);
      Map<String, Object> result = new HashMap<>();
      result.put("dayoffList", dayoffList);
      return ResponseEntity.ok(result);
  }

  // 현재 세션에서 로그인된 사용자 정보 가져옴
  private EmployeeDto getEmployeeFromSession() {
    PrincipalUser principalUser = (PrincipalUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    return principalUser.getEmployeeDto();
  }
  
}