package com.dreamland.prj.service;

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
    
    // 뷰에서 전달된 데이터
    int empNo = Integer.parseInt(request.getParameter("empNo"));
    int deptNo = Integer.parseInt(request.getParameter("deptNo"));
    String start = request.getParameter("start");
    String end = request.getParameter("end");
 
//    Date start = null;
//    Date end = null;
//    
//    try {
//      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
//      start = formatter.parse(request.getParameter("start"));
//      end = formatter.parse(request.getParameter("end"));
//
//    } catch (ParseException e) {
//      System.out.println("날짜포맷오류");
//    }
    String category = request.getParameter("category");
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    String color = request.getParameter("color");
    
//    SimpleDateFormat outputFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//    System.out.println("start: " + outputFormatter.format(start));
//    System.out.println("end: " + outputFormatter.format(end));
    
    // 로그 출력
    System.out.println("====== service ======");
    System.out.println("title: " + title);
    System.out.println("start: " + start);
    System.out.println("end: " + end);
    System.out.println("category: " + category);
    System.out.println("color: " + color);
    System.out.println("contents: " + contents);
    System.out.println("empNo: " + empNo);
    System.out.println("deptNo: " + deptNo);
    
    
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
                                     .employee(emp)
                                    .build(); 
    
    // DB에 일정 저장
    return scheduleMapper.skdAdd(schedule);
  }
  
}
