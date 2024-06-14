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

public class EmployeeDto {
	
	private int empNo, deptNo, posNo;
	private double dayOff, usedDayOff;
	private String empName, email, address, detailAddress, password, profilePath, mobile, role, postcode, deptName, posName;
	private Date birth, enterDate, resignDate;

}
