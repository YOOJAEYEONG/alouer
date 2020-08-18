package mybatis;

import java.sql.Date;


import lombok.Data;

@Data
public class RentalTransDTO {
	private String idx;			//인덱스
	private String code;		//작품코드
	private String memberId;	//주문회원아이디
	private Date rentalBegin;	//렌탈시작날짜
	private Date rentalEnd;		//렌탈종료날짜
	private Date returnDate;	//반납일
	private String transType;	//취소,렌탈중,반납,렌탈가능
	private int totalAmount;	//총 주문 합계
	private int rentalPrice;	//렌탈 가격(월)
	private String phone;		//연락처
	private String address1;	//배송지 주소
	private String address2;	//배송지 상세주소
	private String memo;		//배송요청사항
	private java.sql.Timestamp orderTime;//주문일시
	private String receiver;	//받는사람
		
	private String name;
	private String title;
	private String height;
	private String width;
	private String imageUrl;

	
  	//렌탈주문 기간 파라미터
  	private int rentalPeriMonth;
  	private int rentalPeriDays;

  	
	private int virtualNum;
	private String status;
	private int count;
	
	
}
