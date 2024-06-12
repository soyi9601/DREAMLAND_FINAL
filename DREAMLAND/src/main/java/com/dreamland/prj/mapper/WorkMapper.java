package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.WorkDto;

@Mapper
public interface WorkMapper {
  
  WorkDto getWorkByDate(String today, int empNo);                   // 근무기록 조회 (오늘날짜)
  List<Integer> getNonAdminEmpNo();                                 // 관리자 제외 사원 목록 조회
  String getRoleByEmpNo(int empNo);                                 // 사원 권한 조회
  void updateLate(String today, String lateCheckTime, int empNo);   // 지각 처리
  List<Integer> getDayoffEmpList(String today);                     // 반차, 연차 사원 목록 조회 (오늘날짜)
  String getHalfDayType(String today, int empNo);                   // 반차 유형 조회 (오전,오후)
  void updateDayoffStatus(String today, int dayoffType, int empNo); // 반차 상태 업데이트
  void insertDayoff(String today, int dayoffType, int empNo);       // 연차 상태 삽입
  List<Integer> getAbsenceEmpList(String today);                    // 결근 사원 목록
  void insertAbsence(String today, int empNo);                      // 결근 처리
  int getDayoffType (String today, int empNo);                      // 휴가종류 조회
  int getLateCount(Map<String, Object> map);                        // 지각 횟수
  //int getEarlyLeaveCount(Map<String, Object> map);                // 조기퇴근 횟수
  int getAbsenceCount(Map<String, Object> map);                     // 결근 횟수
  int getTotalWorkDays(Map<String, Object> map);                    // 총 근무일수
  int getTotalWorkHours(Map<String, Object> map);                   // 총 근무시간
  double getAvgWorkHours(Map<String, Object> map);                  // 평균 근무시간
  List<WorkDto> getWorkListByPeriod(Map<String, Object> map);       // 근무정보 기간조회 
  
}
