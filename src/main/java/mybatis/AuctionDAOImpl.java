package mybatis;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface AuctionDAOImpl {

	ArtsDTO getAuctionView(ParameterDTO parameterDTO);

	AuctionInfoDTO getAuctionInfo(ParameterDTO parameterDTO);
	//입찰하기
	int putBid(AuTransDTO auTransDTO);
	
	//입찰 리스트
	ArrayList<AuTransDTO> bidList(String auctionId, int start, int end);
	ArrayList<AuTransDTO> bidList(ParameterDTO parameterDTO);

	ArrayList<AuTransDTO> getMyAuctionResult(ParameterDTO parameterDTO);

	ArrayList<AuTransDTO> getThisAuctionResult(String auctionId);

	ArrayList<AuctionInfoDTO> getTotalAuctionInfo(ArrayList<String> list);

	int getBalance(String parameter);

	//DepositTb 테이블에 입금,출금을 담당하는 테이블
	int setBalance(DepositTbDTO depositTbDTO);
	//예치금 충전 결제시 사용자의 정보를 받아온다.
	MemberVO getMemberInfo(String string);

	int getMinPrice(String auctionId);

	ArrayList<AuTransDTO> getTotalSuccessfulBid(String memberId);

	//마이페이지 > 예치금 충전
	ArrayList<DepositTbDTO> getBalanceHistory(ParameterDTO parameterDTO);

	int getTotalDepositCnt(ParameterDTO parameterDTO);
	//[신규계좌생성]예치금 충전시 기존계좌가 없으면 예외발생 depositTb 테이블에 회원의 레코드 생성
	int newBalance(String string);
	//신규지분경매등록
	int addAuction(AuctionInfoDTO auctionInfoDTO);
	//작품의 status를 지분경매로 변경
	int updateArtAuction(AuctionInfoDTO auctionInfoDTO);
	//옥션아이디의 경매정보를 가져온다
	AuctionInfoDTO getAuctionCodeInfo(String auctionId);
	//낙찰안된 입찰건 환불
	int bidRefund(String auctionId);
	//낙찰건들 지분거래에 등록, 경매완료처리, 작품상태 '지분거래'로 변경
	int addStock(String auctionId);
	//경매정보 업데이트
	int upDateAuction(AuctionInfoDTO auctionInfoDTO);
	
	ArrayList<AuTransDTO> getTotalBidding(String memberId);

	// 필수 파라미터 : tableName 
	int getTotalCount(ParameterDTO parameterDTO);
	//int getTotalCount(String tableName, String columnName);
	//상세보기페이지에서 실시간 낙찰현황
	ArrayList<AuTransDTO> currentAuction(ParameterDTO parameterDTO);




	
	
}
