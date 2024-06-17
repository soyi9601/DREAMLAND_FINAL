package com.dreamland.prj.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.FacilityAttachDto;
import com.dreamland.prj.dto.FacilityDto;

@Mapper
public interface FacilityMapper {
	int insertFacility(FacilityDto facility); // FacilityDto 객체를 데이터베이스에 삽입
	int insertFacilityAttach(FacilityAttachDto facilityAttach); // FacilityAttachDto 객체를 데이터베이스에 삽입
	int getFacilityCount(); // FACILITY 테이블의 전체 레코드 수를 반환
	List<FacilityDto> getFacilityList(Map<String, Object> map); // 조건에 맞는 FACILITY 레코드 리스트를 반환
	
	FacilityDto getFacilityByNo(int facilityNo); // 주어진 facilityNo에 해당하는 FACILITY 정보를 조회
	
	List<FacilityAttachDto> getAttachList(int facilityNo); // 주어진 facilityNo에 해당하는 FACILITY_ATTACH 리스트를 조회
	
	FacilityAttachDto getAttachByNo(int facilityNo); // 주어진 attachNo에 해당하는 FACILITY_ATTACH 정보를 조회
	int updateFacility(FacilityDto facility); // 주어진 FacilityDto 객체 정보를 사용하여 FACILITY 정보를 업데이트
	int deleteAttach(int attachNo); // 주어진 attachNo에 해당하는 FACILITY_ATTACH 정보를 삭제
	int deleteFacility(int FacilityNo); // 주어진 facilityNo에 해당하는 FACILITY 정보를 삭제
	int deleteAttach2(int attachNo); // 주어진 attachNo에 해당하는 FACILITY_ATTACH 정보를 삭제
}
