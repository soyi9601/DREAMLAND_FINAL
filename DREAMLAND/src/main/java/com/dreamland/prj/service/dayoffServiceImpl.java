package com.dreamland.prj.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.DayoffMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class dayoffServiceImpl implements dayoffService {

  private final DayoffMapper dayoffMapper;
  
  @Override
  public void loadDayoffData(Model model, EmployeeDto employee) {
    double totalDayOff = employee.getDayOff();                            // 총 연차
    double usedDayOff = employee.getUsedDayOff();                         // 사용연차
    double remainDayOff = calculateRemainDayOff(totalDayOff, usedDayOff); // 잔여연차
    List<Integer> yearList = getYearList(employee.getEmpNo());            // 사원의 입사연도 ~ 현재연도까지 연도리스트 가져옴 -> 드롭다운에 사용

    model.addAttribute("totalDayOff", totalDayOff);
    model.addAttribute("usedDayOff", usedDayOff);
    model.addAttribute("remainDayOff", remainDayOff);
    model.addAttribute("yearList", yearList);
  }
  
  // 휴가 리스트 (연도별)
  @Override
  public List<AppleaveDto> getDayoffListByYear(int empNo, int year) {
    Map<String, Object> params = new HashMap<>();
    params.put("empNo", empNo);
    params.put("year", year);
    return dayoffMapper.getDayoffListByYear(params);
  }
  
   // 잔여연차 계산
   @Override
   public double calculateRemainDayOff(double totalDayOff, double usedDayOff) {
     return totalDayOff - usedDayOff;
   }

  // 조회 연도 (입사연도 ~ 현재연도)
  @Override
  public List<Integer> getYearList(int empNo) {
    String enterDateStr = dayoffMapper.getEnterDate(empNo);         // "YYYY-MM-DD" 형식의 문자열로 반환
    int enterYear = Integer.parseInt(enterDateStr.substring(0, 4)); // 입사연도 (문자열에서 연도 추출)
    int currentYear = LocalDate.now().getYear();                    // 현재연도

    List<Integer> yearList = new ArrayList<>();  // 입사연도 ~ 현재연도까지 리스트에 추가
    for (int year = enterYear; year <= currentYear; year++) {
        yearList.add(year);
    }
    return yearList;
  }
}
