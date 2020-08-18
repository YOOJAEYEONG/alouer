package mybatis;



import lombok.Data;

@Data
public class RevenueDTO {
	
	private String code;		//작품코드
	private String memberId;	//주문회원아이디
	private int purchase;		//낙찰가격
	private int auctionId;		//경매아이디
	private int auctionTotal;	//발행주식수
	private int stockCnt;		//보유주식수
	private int totalSales;		//총렌탈매출
	
	private int myProfitMoney;	//나의수익금
	private double myProfitPercent;//나의수익률
	
	
	private String name;		//작가명
	private String title;		//작품명
	private String imageUrl;	//이미지경로
	
	private int virtualNum;		//가상번호(페이징처리시)
	
	
}
