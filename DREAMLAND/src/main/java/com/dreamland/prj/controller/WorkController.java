package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;
import com.dreamland.prj.service.WorkService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/work")
@RequiredArgsConstructor
@Controller
public class WorkController {
  private final WorkService workService;
	
	// 근무관리 페이지이동
	@GetMapping("/status.do")
	public String statusPage(Model model) {
    EmployeeDto loginEmployee = getEmployeeFromSession();
    workService.loadWorkData(model, loginEmployee);
    return "work/workingStatus";
}
	
	// 근무정보 리스트 (기간조회)
	@GetMapping("/list.do")
	public ResponseEntity<Map<String, Object>> getWorkListByPeriod(@RequestParam String startDate, @RequestParam String endDate) {
    EmployeeDto loginEmployee = getEmployeeFromSession();
    Map<String, Object> workList = workService.getWorkListByPeriod(loginEmployee.getEmpNo(), startDate, endDate);

    return new ResponseEntity<>(workList, HttpStatus.OK);
}
	
	 private EmployeeDto getEmployeeFromSession() {
     PrincipalUser principalUser = (PrincipalUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
     return principalUser.getEmployeeDto();
 }
}