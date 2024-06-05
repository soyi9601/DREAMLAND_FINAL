package com.dreamland.prj.service;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;



@Transactional
@Service
public interface FacilityService {
	// 등록
	boolean registerFacility(MultipartHttpServletRequest multipartRequest);
	// 목록	
	void loadFacilityList(Model model); 
}
