package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.ScheduleDto;
import com.dreamland.prj.dto.SkdShrDeptDto;
import com.dreamland.prj.dto.SkdShrEmpDto;
import com.dreamland.prj.mapper.ScheduleMapper;

import io.jsonwebtoken.lang.Arrays;
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
    
    System.err.println("======== 일정 등록 ========");
    System.out.println(schedule);
    
    // 삽입된 일정의 SKD_NO 가져오기
    int skdNo = schedule.getSkdNo();
    System.out.println("Schedule SKD_NO: " + skdNo); 
    
    // 부서 공유 데이터 삽입
    String[] shrNos = request.getParameterValues("shrNo");  
    System.err.println("======== 공유 번호 확인 ========");
     if (shrNos != null) {
       Set<String> shrNoList = new HashSet<>(Arrays.asList(shrNos));  // 중복 데이터 제거 (중복 삽입 방지)
       
        for (String shrNo : shrNoList) {
          // shrNo 앞에 E, D 로 구분 (E : 사원, D : 부서)
          System.out.println("shrNo: " + shrNo); 
          if(shrNo.startsWith("E")) { // 사원
            SkdShrEmpDto shrEmp = new SkdShrEmpDto();
            shrEmp.setSkdNo(skdNo); // SKD_NO 설정
            shrEmp.setEmpNo(Integer.parseInt(shrNo.substring(1))); // 'E' 이후 문자열 정수로 변환하여 EMP_NO 설정
            scheduleMapper.addShrEmp(shrEmp);// DB에 사원 공유 데이터 삽입
          } else if(shrNo.startsWith("D")) { // 부서
            SkdShrDeptDto shrDept = new SkdShrDeptDto();
            shrDept.setSkdNo(skdNo);
            shrDept.setDeptNo(Integer.parseInt(shrNo.substring(1)));
            scheduleMapper.addShrDept(shrDept);
         }
       }
     } 
    return insertCount; // 모든 데이터 처리 후 일정 삽입 결과 반환
  }
  
  // 전체 일정 조회 (필터링)
  @Override
  public void loadSkdList(HttpServletRequest request, Model model) {
    
    // 현재 세션에서 로그인된 사용자 정보를 가져오기
    EmployeeDto loginEmployee = (EmployeeDto) request.getSession().getAttribute("loginEmployee");
    
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
    
    // 기존 공유 사원 및 부서 삭제
    scheduleMapper.deleteShrEmp(schedule.getSkdNo());
    scheduleMapper.deleteShrDept(schedule.getSkdNo());
    
    List<SkdShrEmpDto> shrEmpList = schedule.getShrEmp();
    List<SkdShrDeptDto> shrDeptList = schedule.getShrDept();
    
    // 사원 공유 데이터 삽입
    if (shrEmpList != null && !shrEmpList.isEmpty()) {
        for (SkdShrEmpDto shrEmps : shrEmpList) {
            SkdShrEmpDto shrEmp = new SkdShrEmpDto();
            shrEmp.setSkdNo(schedule.getSkdNo());
            shrEmp.setEmpNo(shrEmps.getEmpNo());
            scheduleMapper.addShrEmp(shrEmp);
        }
    }
    
    // 부서 공유 데이터 삽입
    if (shrDeptList != null && !shrDeptList.isEmpty()) {
        for (SkdShrDeptDto shrDeps : shrDeptList) {
            SkdShrDeptDto shrDept = new SkdShrDeptDto();
            shrDept.setSkdNo(schedule.getSkdNo());
            shrDept.setDeptNo(shrDeps.getDeptNo());
            scheduleMapper.addShrDept(shrDept);
        }
    }
    System.out.println("수정 테스트 :" + schedule);

    // 일정 업데이트
    return scheduleMapper.updateSkd(schedule);
  }
  
  // 일정 삭제 
  @Override
  public int removeSkd(int skdNo) {
    return  scheduleMapper.deleteSkd(skdNo);
  }
 
  // 공유 사원 검색 
  @Override
  public List<EmployeeDto> searchEmp(String query) {
    return scheduleMapper.searchEmp(query);  
  }

  //공유 부서 검색
  @Override
  public List<DepartmentDto> searchDept(String query) {
    return scheduleMapper.searchDept(query);
  }
}
