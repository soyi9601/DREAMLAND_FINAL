package com.dreamland.prj.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class ApvAttachDto {
	
	private int attachNo, apvNo;
	private String uploadPath, filesystemName, originalFilename;

}
