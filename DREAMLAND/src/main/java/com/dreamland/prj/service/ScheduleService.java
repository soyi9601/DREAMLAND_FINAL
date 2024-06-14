package com.dreamland.prj.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.ScheduleDto;

import jakarta.servlet.http.HttpServletRequest;
public interface ScheduleService {

  int registerSkd(HttpServletRequest request);                // 일정 등록
  void loadSkdList(HttpServletRequest request, Model model);  // 일정 조회
  ScheduleDto getSkdByNo(int skdNo);                          // 일정 상세보기
  int modifySkd(ScheduleDto schedule);                        // 일정 수정
  int removeSkd(int skdNo);                                   // 일정 삭제
  List<EmployeeDto> searchEmp(String query);     // 공유 사원 검색
  List<DepartmentDto> searchDept(String query);  // 공유 부서 검색
}
