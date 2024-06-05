package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.ScheduleDto;
import com.dreamland.prj.dto.SkdShrDeptDto;

@Mapper
public interface ScheduleMapper {
  int skdAdd(ScheduleDto schedule);
  int addShrDept(SkdShrDeptDto shrDept);
  List<ScheduleDto> getSkdList(Map<String, Object> map);
  ScheduleDto getSkdByNo(int skdNo);
  List<SkdShrDeptDto> getShrDeptNo(int skdNo);
  int updateSkd(ScheduleDto schedule);
  int deleteSkd(int skdNo);
  int deleteShrDept(int skdNo);
  
}
