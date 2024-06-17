package com.dreamland.prj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PositionDto;

/******************************************
 * 
 * - 직원등록
 * - 마이페이지 정보 수정, 비밀번호 변경
 * - 임시비밀번호 발급
 * 작성자 : 고은정
 * 
 * ****************************************/

@Mapper
public interface EmployeeMapper {
  
  // 직원등록
  int insertEmployee(EmployeeDto emp);
  
  // 이메일, 사번을 통해 직원 정보 가져기
  EmployeeDto getEmployeeByEmail(String email);
  EmployeeDto getEmployeeByEmpNo(int empNo);
  
  // 부서, 세부부서, 직급 가져오기
  List<DepartmentDto> getDeptList();
  List<DepartmentDto> getDeptDetailList();
  List<PositionDto> getPosList();
  
  // 마이페이지 정보 수정
  int updateUserInfo(EmployeeDto emp);
  
  // 임시비밀번호, 비밀번호 변경
  int updatePassword(String email, String changePw);
  
  // 이메일 중복체크
  int emailCheck(String email);

}
