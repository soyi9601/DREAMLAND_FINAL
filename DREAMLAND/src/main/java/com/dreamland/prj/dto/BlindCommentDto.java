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

public class BlindCommentDto {
	private int commentNo, depth, groupNo, blindNo;
	private String contents, delYn;
	private Date createDt;
}
