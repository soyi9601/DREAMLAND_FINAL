package com.dreamland.prj.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class NoticeAttachDto {
	
	private int attachNo, noticeNo;
	private String uploadPath, filesystemName, originalfileSystem;
	
}
