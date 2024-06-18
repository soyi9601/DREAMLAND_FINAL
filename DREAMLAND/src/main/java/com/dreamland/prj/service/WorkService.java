package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.ui.Model;

import com.dreamland.prj.dto.EmployeeDto;

public interface WorkService {
  
  void loadWorkData(Model model, EmployeeDto employee);
  Map<String, Object> getWorkListByPeriod(int empNo, String startDate, String endDate);
  void checkLate();    
  void checkHafDayoff();
  void checkDayoff();
  void checkAbsence();
 
}
