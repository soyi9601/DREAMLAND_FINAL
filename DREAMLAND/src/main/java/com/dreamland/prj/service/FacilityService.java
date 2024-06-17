package com.dreamland.prj.service;


import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.FacilityDto;

import jakarta.servlet.http.HttpServletRequest;



@Transactional
@Service
public interface FacilityService {
	boolean registerFacility(MultipartHttpServletRequest multipartRequest); // 시설 등록
	void loadFacilityList(Model model); // 모든 시설 목록 
	
	void loadFacilityByNo(int facilityNo, Model model); // 특정 시설 번호에 해당하는 시설을 로드하여 모델에 추가
	
	ResponseEntity<Resource> download(HttpServletRequest request); // 첨부 파일 다운로드를 처리
	
	FacilityDto getFacilityByNo(int facilityNo); // 특정 시설 번호에 해당하는 시설 정보
	int modifyFacility(FacilityDto facility); // 시설 정보를 수정
	int deleteAttach(int attachNo); // 첨부 파일을 삭제
	
	ResponseEntity<Map<String, Object>> getAttachList(int facilityNo); // 특정 시설 번호에 해당하는 첨부 파일 목록
	
	ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception; // 첨부 파일을 추가
	ResponseEntity<Map<String, Object>> removeAttach(int attachNo); // 첨부 파일을 삭제
	int removeFacility(int FacilityNo); // 시설 정보를 삭제
	int deleteAttach2(int attachNo); // 특정 첨부 파일 번호에 해당하는 첨부 파일을 삭제
}
