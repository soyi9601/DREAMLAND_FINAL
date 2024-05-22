package com.dreamland.prj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.DepartmentDto;

@Mapper
public interface DepartMapper {
  
  List<DepartmentDto> getDepartList();
  void updateDepartment(DepartmentDto departmentDto);
  
  void deleteNode(DepartmentDto departmentDto);
  
}
