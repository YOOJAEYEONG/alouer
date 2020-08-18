package mybatis;

import lombok.Data;

@Data
public class AuTransDTO {

	
	private String code;					//작품코드
	private String auctionId;				//경매id
	private String a_transId; 				//PK;경매거래 시퀀스
	private String memberId;				//회원아이디
	private int bidsPrice;					//입찰가
	private java.sql.Timestamp auctionTime;	//입찰시간
	
	//Timestamp 포맷을 형변환해서 저장할 변수
	private String fmtAuctionTime;
	private int lot;//입찰시 수량
	private int sum;//총 낙찰금액
	
	/*지분경매작품상세보기 */
	private int rn; //경매 상세보기에서  게시판의 No. 컬럼 (2차 서브쿼리 rownum)
	
	/*마이페이지*/
	private int roNum;// 마이페이지> 내가 참여한 모든 지분경매의 낙찰리스트의 No. 컬럼 (3차 서브쿼리 rownum)
	private String title;//inner join으로 받기위해 추가함
	
	private java.sql.Timestamp endTime;	
	private String fmtEndTime;
	private String imageurl;

}

