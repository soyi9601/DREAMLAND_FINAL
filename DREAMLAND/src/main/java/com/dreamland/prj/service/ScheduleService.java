package com.dreamland.prj.service;

import org.springframework.ui.Model;

import com.dreamland.prj.dto.ScheduleDto;

import jakarta.servlet.http.HttpServletRequest;

public interface ScheduleService {

  int registerSkd(HttpServletRequest request);                // 일정 등록
  void loadSkdList(HttpServletRequest request, Model model);  // 일정 조회
  ScheduleDto getSkdByNo(int skdNo);
  int modifySkd(ScheduleDto schedule);                        // 일정 수정
  int removeSkd(int skdNo);                                   // 일정 삭제
  
}
