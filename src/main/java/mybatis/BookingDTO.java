package mybatis;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class BookingDTO {
	
	private String idx;
	private String code;
	private String memberId;
	private Timestamp waitingTime;
	private String jsTime;
	
	private int start;
	private int end;
	private int virtualNum;
	
	private String moSearchField;
	private String moSearchTxt;
	
	
	
}
