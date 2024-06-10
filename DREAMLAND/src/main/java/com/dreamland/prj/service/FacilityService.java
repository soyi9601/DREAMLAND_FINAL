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
	boolean registerFacility(MultipartHttpServletRequest multipartRequest);
	void loadFacilityList(Model model); 
	
	void loadFacilityByNo(int facilityNo, Model model);
	
	ResponseEntity<Resource> download(HttpServletRequest request);
	
	FacilityDto getFacilityByNo(int facilityNo);
	int modifyFacility(FacilityDto facility);
	int deleteAttach(int attachNo);
	
	ResponseEntity<Map<String, Object>> getAttachList(int facilityNo);
	
	ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception;
	ResponseEntity<Map<String, Object>> removeAttach(int attachNo);
	int removeFacility(int FacilityNo);
}
