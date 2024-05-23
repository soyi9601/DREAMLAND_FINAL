package com.dreamland.prj.service;

import java.sql.Date;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.ScheduleDto;
import com.dreamland.prj.mapper.ScheduleMapper;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ScheduleServiceImpl implements ScheduleService {

  private final ScheduleMapper scheduleMapper;

  public ScheduleServiceImpl(ScheduleMapper scheduleMapper) {
    super();
    this.scheduleMapper = scheduleMapper;
  }

  // 일정 등록
  @Override
  public int registerSkd(HttpServletRequest request) {
    
    // 뷰에서 전달된 데이
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int deptNo = Integer.parseInt(request.getParameter("deptNo"));
    Date start = Date.valueOf(request.getParameter("start"));
    Date end = Date.valueOf(request.getParameter("end"));
    String category = request.getParameter("category");
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    String color = request.getParameter("color");
    
 // 로그 출력
    System.out.println("empNo: " + empNo);
    System.out.println("skdStart: " + start);
    System.out.println("skdEnd: " + end);
    System.out.println("skdCategory: " + category);
    System.out.println("skdTitle: " + title);
    System.out.println("skdContents: " + contents);
    System.out.println("skdColor: " + color);
    
    
    // EmployeeDto 객체 생성 (
    EmployeeDto emp = new EmployeeDto();
    emp.setEmpNo(empNo);
    emp.setDeptNo(deptNo);
    
    // ScheduleDto 객체 생성
    ScheduleDto schedule = ScheduleDto.builder()
                                     .skdStart(start)
                                     .skdEnd(end)
                                     .skdCategory(category)
                                     .skdTitle(title)
                                     .skdContents(contents)
                                     .skdColor(color)
                                    .build(); 
    
    // DB에 일정 저장
    return scheduleMapper.skdAdd(schedule);
  }
  
}
