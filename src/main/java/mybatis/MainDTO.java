package mybatis;

import lombok.Data;

@Data
public class MainDTO {

	//	A.code, A.title, A.name, A.imageurl, B.auctiontotal, C.counttrans, C.auctionid
	private String code;
	private String title;
	private String name;
	private String imageUrl;
	private int auctionTotal;
	private int countTrans;
	private int auctionId;

	//경매 경쟁률을 위해 추가
	private double competition;

	//경매준비중 가져오기 위해 추가
	private int startBids;

	//롤링배너 낙찰가능가
	private int minPrice;// 낙찰 가능한 최소 금액
}

