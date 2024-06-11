package com.dreamland.prj.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.WorkDto;
import com.dreamland.prj.mapper.WorkMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
public class WorkServiceImpl implements WorkService {
  
  private final WorkMapper workMapper;
  private final LoginService loginService;
  
  // 지각처리
  @Override
  @Transactional
  public void checkLate() {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
    workMapper.updateLate(today);
  }

  // 결근처리
  @Override
  @Transactional
  public void checkAbsence() {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
    List<Integer> empNos = workMapper.getAbsenceEmpList(today);
    for (Integer empNo : empNos) {
      List<WorkDto> workRecords = workMapper.getWorkListByDate(today, empNo);
      if (workRecords.isEmpty()) {
          workMapper.insertAbsence(today, empNo);
      }
    }
  }

  // 반차, 연차 처리
  @Override
  @Transactional
  public void checkDayoff() {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      String today = sdf.format(new Date());
      
      List<Integer> dayoffEmpList = workMapper.getDayoffEmpList(today);
      for (Integer empNo : dayoffEmpList) {
              Integer dayoffType = workMapper.getDayoffType(today, empNo);
              if (dayoffType != null) {
                  if (dayoffType == 30) {  // 연차
                      List<WorkDto> workList = workMapper.getWorkListByDate(today, empNo);
                      if (workList.isEmpty()) {
                          workMapper.insertDayoff(today, dayoffType, empNo);
                      }
                  } else if (dayoffType == 20) { // 반차
                      workMapper.updateDayoffStatus(today, dayoffType, empNo);
                  }
              }
          }
      }
  
  // 지각 + 조기퇴근 + 결근 횟수 + 근무시간 조회
  @Override
  public Map<String, Object> getWorkCountByEmail(String email) {
    EmployeeDto employeeDto = loginService.getEmployeeByEmail(email);
    Integer empNo = loginService.getEmployeeByEmail(email).getEmpNo();
    int year = java.time.Year.now().getValue();
    
    Map<String, Object> map = new HashMap<>();
    map.put("empNo", empNo);
    map.put("year", year);
    
    // 로그 추가
    System.out.println("======= 파라미터 테스트 =======");
    System.out.println(map);
    
    int lateCount = workMapper.getLateCount(map);
    // int earlyLeaveCount = workMapper.getEarlyLeaveCount(map);
    int absenceCount = workMapper.getAbsenceCount(map);
    int totalWorkDays = workMapper.getTotalWorkDays(map);
    int totalWorkHours = workMapper.getTotalWorkHours(map);
    String avgWorkHours = String.format("%.2f", workMapper.getAvgWorkHours(map)); 

    // 로그 추가
    System.out.println("======= 쿼리 결과 =======");
    System.out.println("Late Count: " + lateCount);
    //System.out.println("Early Leave Count: " + earlyLeaveCount);
    System.out.println("Absence Count: " + absenceCount);
    System.out.println("total Work Days: " + totalWorkDays);
    System.out.println("total Work Hours: " + totalWorkHours);
    System.out.println("avg Work Hours: " + avgWorkHours);

    Map<String, Object> counts = new HashMap<>();
    counts.put("lateCount", lateCount);
    //counts.put("earlyLeaveCount", earlyLeaveCount);
    counts.put("absenceCount", absenceCount);
    counts.put("totalWorkDays", totalWorkDays);
    counts.put("totalWorkHours", totalWorkHours);
    counts.put("avgWorkHours", avgWorkHours);
    counts.put("employee", employeeDto); 

    return counts;
    
  }
  
  // 근무정보 리스트 (기간조회)
  @Override
  public Map<String, Object> getWorkListByPeriod(String email, String startDate, String endDate) {
    Integer empNo = loginService.getEmployeeByEmail(email).getEmpNo();
    
    Map<String, Object> map = new HashMap<>();
    map.put("empNo", empNo);
    map.put("startDate", startDate);
    map.put("endDate", endDate);
   
    List<WorkDto> workList = workMapper.getWorkListByPeriod(map);

    if (workList == null || workList.isEmpty()) {
        workList = new ArrayList<>(); // 값이 비어있을 때, 빈 리스트 반환
    }
    
    Map<String, Object> result = new HashMap<>();
    result.put("workList", workList);

    return result;

  }
}
