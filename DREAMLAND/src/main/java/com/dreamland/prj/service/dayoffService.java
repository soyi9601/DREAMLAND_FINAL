package com.dreamland.prj.service;

import java.util.List;

import com.dreamland.prj.dto.AppleaveDto;

public interface dayoffService {
 
  List<AppleaveDto> getDayoffListByYear(int empNo, int year);
  int calculateRemainingDayOff(int totalDayOff, int usedDayOff);
  public List<Integer> getYearList(int empNo);

}
