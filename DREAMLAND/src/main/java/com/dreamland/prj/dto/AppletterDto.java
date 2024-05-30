package com.dreamland.prj.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class AppletterDto {
	
	private int letterNo, apvNo, letterStatus;
	private String detail, oriFilename, rerFilename;

}
