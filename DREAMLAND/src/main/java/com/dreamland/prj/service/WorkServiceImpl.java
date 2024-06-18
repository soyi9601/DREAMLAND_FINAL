package com.dreamland.prj.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.WorkDto;
import com.dreamland.prj.mapper.WorkMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WorkServiceImpl implements WorkService {
  
  private final WorkMapper workMapper;
  private final DepartService departService;
  
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String today = sdf.format(new Date());
  
  // 근무정보 조회 
  @Override
  public void loadWorkData(Model model, EmployeeDto employee) {
    DepartmentDto department = departService.getDepartById(employee.getDeptNo());  // 부서번호 가져오기
    model.addAttribute("loginEmployee", employee);
    model.addAttribute("department", department);
    
    int year = java.time.Year.now().getValue();

    Map<String, Object> map = new HashMap<>();
    map.put("empNo", employee.getEmpNo());
    map.put("year", year);

    int lateCount = workMapper.getLateCount(map);
    int absenceCount = workMapper.getAbsenceCount(map);
    int totalWorkDays = workMapper.getTotalWorkDays(map);
    int totalWorkHours = workMapper.getTotalWorkHours(map);
    String avgWorkHours = String.format("%.2f", workMapper.getAvgWorkHours(map)); 

    model.addAttribute("lateCount", lateCount);
    model.addAttribute("absenceCount", absenceCount);
    model.addAttribute("totalWorkDays", totalWorkDays);
    model.addAttribute("totalWorkHours", totalWorkHours);
    model.addAttribute("avgWorkHours", avgWorkHours);
    
  }  
  
  // 근무정보 리스트 (기간조회)
  @Override
  public Map<String, Object> getWorkListByPeriod(int empNo, String startDate, String endDate) {
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
  
  // 지각
  @Override
  public void checkLate() {
    List<Integer> nonAdminEmpNos = workMapper.getNonAdminEmpNo();
    for(Integer empNo : nonAdminEmpNos) {
      String halfDayType = workMapper.getHalfDayType(today, empNo);
      String lateCheckTime = "";
      
      if ("morning".equals(halfDayType)) {
        // 오전 반차인 경우 출근 시간 14:00
        lateCheckTime = "14:00:00";
      } else if ("afternoon".equals(halfDayType)) {
        // 오후 반차인 경우 출근 시간 09:00
        lateCheckTime = "09:00:00";
      } else {
        lateCheckTime = "09:00:00";
      }
      workMapper.updateLate(today, lateCheckTime, empNo);
    }
  }

  // 연차
  @Override
  public void checkDayoff() {
      List<Integer> dayoffEmpList = workMapper.getDayoffEmpList(today); // 오늘 날짜 연차 사원 리스트 조회
      for (Integer empNo : dayoffEmpList) {
        Integer dayoffType = workMapper.getDayoffType(today, empNo);    // 연차 유형 조회
        if (dayoffType != null && dayoffType == 30) { // 30 : 연차
          WorkDto workRecord = workMapper.getWorkByDate(today, empNo);  // 오늘 날짜 근무기록 조회
            workMapper.updateDayoffStatus(today, dayoffType, empNo);    // 연차 상태 업데이트
            if (workRecord == null) {
              workMapper.insertDayoff(today, dayoffType, empNo);        // 근무기록 없으면 데이터 삽입
          }
        }
      }
    }
  
  // 반차
  @Override
  public void checkHafDayoff() {
      List<Integer> dayoffEmpList = workMapper.getDayoffEmpList(today);
      for (Integer empNo : dayoffEmpList) {
        Integer dayoffType = workMapper.getDayoffType(today, empNo);
        if (dayoffType != null && dayoffType == 20) {  // 20 : 반차
            workMapper.updateDayoffStatus(today, dayoffType, empNo);
        } 
      }
    }

  
  // 결근
  @Override
  public void checkAbsence() {
      List<Integer> empNos = workMapper.getAbsenceEmpList(today); 
      for (Integer empNo : empNos) {
        String role = workMapper.getRoleByEmpNo(empNo); 
        if(!"ROLE_ADMIN".equals(role)) {
          WorkDto workRecord = workMapper.getWorkByDate(today, empNo);
          if (workRecord == null) {
            workMapper.insertAbsence(today, empNo);
          }
        }
      }
    }
 }
