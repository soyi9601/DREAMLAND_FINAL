package com.dreamland.prj.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dreamland.prj.dto.DepartmentDto;
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
  public void updateNode(DepartmentDto departmentDto)  {
    departMapper.updateDepartment(departmentDto);
  }
  
  @Override
  public void deleteNode(DepartmentDto departmentDto)  {
    departMapper.deleteNode(departmentDto);
  }

  

}
