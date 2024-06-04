package com.dreamland.prj.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WorkMapper {
  
  //List<WorkDto> getAbsenceList (String workDate);
  void updateLate(String workDate);                // 지각 처리
  void updateAbsence(String workDate);             // 결근 처리
  int getLateCount(Map<String, Object> map);       // 지각 횟수
  int getEarlyLeaveCount(Map<String, Object> map); // 조기퇴근 횟수
  int getAbsenceCount(Map<String, Object> map);    // 결근 횟수
  int getTotalWorkDays(Map<String, Object> map);   // 총 근무일수
  int getTotalWorkHours(Map<String, Object> map);  // 총 근무시간
  double getAvgWorkHours(Map<String, Object> map); // 평균 근무시간
  
}
