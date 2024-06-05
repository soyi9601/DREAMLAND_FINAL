package com.dreamland.prj.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class FacilityDto {
	
	private int    facilityNo, management;
	private String facilityName, remarks;
	private Date 	 facilityDate;
	private DepartmentDto department; 
	
}
