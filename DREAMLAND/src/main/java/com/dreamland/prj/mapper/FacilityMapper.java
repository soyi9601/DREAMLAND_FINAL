package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.FacilityAttachDto;
import com.dreamland.prj.dto.FacilityDto;

@Mapper
public interface FacilityMapper {
	int insertFacility(FacilityDto facility);
	int insertFacilityAttach(FacilityAttachDto facilityAttach);
	int getFacilityCount();
	List<FacilityDto> getFacilityList(Map<String, Object> map);
}
