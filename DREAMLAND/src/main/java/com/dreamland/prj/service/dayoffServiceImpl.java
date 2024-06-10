package com.dreamland.prj.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.mapper.dayoffMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class dayoffServiceImpl implements dayoffService {

  private final dayoffMapper dayoffMapper;
  
  // 휴가 조회 (연도별)
  @Override
  public List<AppleaveDto> getDayoffListByYear(int empNo, int year) {
    Map<String, Object> params = new HashMap<>();
    params.put("empNo", empNo);
    params.put("year", year);
    return dayoffMapper.getDayoffListByYear(params);
  }
  
  // 잔여연차 계산
  @Override
  public int calculateRemainingDayOff(int totalDayOff, int usedDayOff) {
    return totalDayOff - usedDayOff;
  }

  // 조회 연도
  @Override
  public List<Integer> getYearList(int empNo) {
    String enterDateStr = dayoffMapper.getEnterDate(empNo);         // "YYYY-MM-DD" 형식의 문자열로 반환
    int enterYear = Integer.parseInt(enterDateStr.substring(0, 4)); // 문자열에서 연도 추출

    int currentYear = LocalDate.now().getYear();

    List<Integer> yearList = new ArrayList<>();
    for (int year = enterYear; year <= currentYear; year++) {
        yearList.add(year);
    }
    return yearList;
  }
}
