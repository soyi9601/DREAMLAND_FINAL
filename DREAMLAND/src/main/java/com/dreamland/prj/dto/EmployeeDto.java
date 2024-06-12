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
	
	private int empNo, dayOff, deptNo, posNo, usedDayOff;
	private String empName, email, address, detailAddress, password, profilePath, signPath, mobile, role, postcode, deptName, posName;
	private Date birth, enterDate, resignDate;

}
