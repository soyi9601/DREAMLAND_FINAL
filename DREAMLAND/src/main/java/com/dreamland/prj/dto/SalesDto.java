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

public class SalesDto {
	
	 private int  salesNo, qty;
	 private Date salesDate;
	 private ProductDto product;
	 private DepartmentDto dept;
}
