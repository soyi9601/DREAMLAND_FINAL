package com.dreamland.prj.service;

import java.util.List;

import org.springframework.ui.Model;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.EmployeeDto;

public interface dayoffService {
 
  void loadDayoffData(Model model, EmployeeDto employee);
  List<AppleaveDto> getDayoffListByYear(int empNo, int year);
  double calculateRemainDayOff(double totalDayOff, double usedDayOff);
  public List<Integer> getYearList(int empNo);

}
