package mybatis;


import lombok.Data;


@Data
public class AuctionInfoDTO {

	//공통
	private String code;					//작품코드
	private String auctionId;				//경매id
	private String startBids;				//최소입찰가
	private java.sql.Timestamp startTime;	//경매시작
	private java.sql.Timestamp endTime;		//경매마감
	private String auctionTotal;
	private int isFinish;				//경매종료(미낙찰건환불,주식등록,작품상태변경시 완료체크
	
	//Timestamp 포맷을 형변환해서 저장할 변수
	private String fmtStartTime;
	private String fmtEndTime;
	private int minPrice;// 낙찰 가능한 최소 금액
	private int r;//rownum R 값 받는용도
	
	//경매물의 작품 제목, 작가명 ( inner join 사용시 필요)
	private String title;
	private String name;
	
	
}
