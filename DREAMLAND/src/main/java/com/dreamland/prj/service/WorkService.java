package com.dreamland.prj.service;

import java.util.Map;

public interface WorkService {
  
  void checkLate();
  void checkAbsence();
  Map<String, Object> getWorkCountByEmail(String email);
  Map<String, Object> getWorkListByPeriod(String email, String startDate, String endDate);
  // Map<String, Object> getWorkCount(HttpServletRequest request); 
 
}
