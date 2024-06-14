package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.ScheduleDto;
import com.dreamland.prj.dto.SkdShrDeptDto;
import com.dreamland.prj.dto.SkdShrEmpDto;

@Mapper
public interface ScheduleMapper {
  
  // 일정 등록
  int skdAdd(ScheduleDto schedule);      
  int addShrEmp(SkdShrEmpDto shrEmp);    
  int addShrDept(SkdShrDeptDto shrDept); 
  
  // 전체 일정 조회
  List<ScheduleDto> getSkdList(Map<String, Object> map); 
  
  // 일정 상세보기
  ScheduleDto getSkdByNo(int skdNo);
  //List<SkdShrDeptDto> getShrDeptNo(int skdNo);
  
  // 공유 검색
  List<EmployeeDto> searchEmp(String query);  
  List<DepartmentDto> searchDept(String query);  
  
  // 수정
  int updateSkd(ScheduleDto schedule);
  
  // 삭제
  int deleteSkd(int skdNo);     
  int deleteShrEmp(int skdNo);  
  int deleteShrDept(int skdNo); 
  
}
