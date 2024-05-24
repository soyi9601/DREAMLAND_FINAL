package com.dreamland.prj.service;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;

public interface ScheduleService {

  int registerSkd(HttpServletRequest request);                // 일정 등록
  void loadSkdList(HttpServletRequest request, Model model);  // 일정 조회
  
}
