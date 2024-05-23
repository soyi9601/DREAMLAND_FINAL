package com.dreamland.prj.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.mapper.DepartMapper;


@Service
public class DepartServiceImpl implements DepartService {

  private final DepartMapper departMapper;
  
  public DepartServiceImpl(DepartMapper departMapper) {
    super();
    this.departMapper = departMapper;
  }
  
  @Override
  public List<DepartmentDto> getDepartList() {
    return departMapper.getDepartList();
  }
  
  @Override
  public void updateDepart(DepartmentDto departmentDto)  {
    departMapper.updateDepart(departmentDto);
  }
  
  @Override
  public void deleteDepart(DepartmentDto departmentDto) {
    departMapper.deleteDepart(departmentDto); 
  }
  
  @Override
  public void deleteEmployee(EmployeeDto employeeDto) {
    departMapper.deleteEmployee(employeeDto); 
  }
  

  

}
