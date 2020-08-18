package mybatis;

import lombok.Data;

@Data
public class DepositTbDTO {

	private String idx;
	private String memberId;
	private int withdraw;
	private int deposit;
	private int balance;
	private String history;
	private java.sql.Date transtime;
	private String fmtTransTime;//오라클 data 형변환해서 저장할 변수
	
	private int totalPrice;
	private int r; //mypage > 입추금리스트 페이징의 rownum R 을 저장할 변수
	
}
