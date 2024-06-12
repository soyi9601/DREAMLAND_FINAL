package com.dreamland.prj.service;

import java.util.Map;

public interface WorkService {
  
  void checkLate();    
  void checkHafDayoff();
  void checkDayoff();
  void checkAbsence();
  //boolean isAdmin();
  Map<String, Object> getWorkCountByEmail(String email);
  Map<String, Object> getWorkListByPeriod(String email, String startDate, String endDate);
  // Map<String, Object> getWorkCount(HttpServletRequest request); 
 
}
