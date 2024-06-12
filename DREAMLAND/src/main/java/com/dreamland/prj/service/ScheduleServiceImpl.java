package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.ScheduleDto;
import com.dreamland.prj.dto.SkdShrDeptDto;
import com.dreamland.prj.mapper.ScheduleMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
    // String[] deptNoList = request.getParameterValues("deptNo");
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String category = request.getParameter("category");
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    String color = request.getParameter("color");
    
    
    // 로그 출력
    System.out.println("============ service ===========");
    System.out.println("title: " + title);
    System.out.println("start: " + start);
    System.out.println("end: " + end);
    System.out.println("category: " + category);
    System.out.println("color: " + color);
    System.out.println("contents: " + contents);
    System.out.println("empNo: " + empNo);
    System.out.println("===============================");
    
    
    // EmployeeDto 객체 생성 
    EmployeeDto emp = new EmployeeDto();
    emp.setEmpNo(empNo);
    
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
    int insertCount = scheduleMapper.skdAdd(schedule);
    
    // 삽입된 일정의 SKD_NO 가져오기
    int skdNo = schedule.getSkdNo();
    System.out.println("INSERT : " + skdNo);
    
    // 부서 공유 데이터 삽입
    String[] deptNoList = request.getParameterValues("deptNo");
    if (deptNoList != null) {
        Set<Integer> uniqueDepts = new HashSet<>();
        for (String deptNo : deptNoList) {
            uniqueDepts.add(Integer.parseInt(deptNo));
        }
        for (Integer deptNo : uniqueDepts) {
            SkdShrDeptDto shrDept = new SkdShrDeptDto();
            shrDept.setSkdNo(skdNo);
            shrDept.setDeptNo(deptNo);
            scheduleMapper.addShrDept(shrDept);
        }
    }  
    return insertCount;
  }
  
  // 모든 일정 조회
  @Override
  public void loadSkdList(HttpServletRequest request, Model model) {
    // 현재 세션에서 로그인된 사용자 정보를 가져옵니다.
    EmployeeDto loginEmployee = (EmployeeDto) request.getSession().getAttribute("loginEmployee");
    
    System.out.println(loginEmployee);
    
    // 사용자 정보를 기반으로 일정 조회
    Map<String, Object> map = new HashMap<>();
    map.put("empNo", loginEmployee.getEmpNo());
    map.put("deptNo", loginEmployee.getDeptNo());

    // 일정 리스트를 가져와서 모델에 추가
    List<ScheduleDto> skdList = scheduleMapper.getSkdList(map);
    model.addAttribute("skdList", skdList);

  }
  
  @Override
  public ScheduleDto getSkdByNo(int skdNo) {
    return scheduleMapper.getSkdByNo(skdNo);
  }
  
  // 일정 수정
  @Override
  public int modifySkd(ScheduleDto schedule) {
    
    // 일정 업데이트
    int result = scheduleMapper.updateSkd(schedule);

    // 기존 공유 부서 삭제
    scheduleMapper.deleteShrDept(schedule.getSkdNo());
    
    System.out.println("수정 테스트 :" + schedule);
    // 새로운 공유 부서 삽입
    List<SkdShrDeptDto> deptNoList = schedule.getShrDept(); 
    if (deptNoList != null && !deptNoList.isEmpty()) {
        for (SkdShrDeptDto deptNo : deptNoList) {
            SkdShrDeptDto shrDept = new SkdShrDeptDto();
            shrDept.setSkdNo(schedule.getSkdNo());
            shrDept.setDeptNo(deptNo.getDeptNo()); 
            scheduleMapper.addShrDept(shrDept);
            System.out.println("수정 테스트 공유부서:" + deptNo);
        }
    }
    return result;
}
  
  // 일정 삭제 
  @Override
  public int removeSkd(int skdNo) {
    return  scheduleMapper.deleteSkd(skdNo);
  }
  
}
