package com.dreamland.prj.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class FacilityAttachDto {
	
	private int attachNo, facilityNo;
	private String uploadPath, filesystemName, originalFilename;
	
}
