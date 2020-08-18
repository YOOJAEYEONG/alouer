package mybatis;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import org.springframework.stereotype.Service;

@Service
public interface AdminImpl {
	
	//렌탈관리
	public ArrayList<RentalTransDTO> listPage(ParameterDTO parameterDTO);
	public int modifyRT(RentalTransDTO rentalTransDTO);
	public int idCheck(String memberId);
	public int insertRT(RentalTransDTO rentalTransDTO);
	public int updateStatus(RentalTransDTO rentalTransDTO);

	//작품별 렌탈거래내역
	public ArrayList<RentalTransDTO> rentalList(ParameterDTO parameterDTO);
	public int rentalTransCount(ParameterDTO parameterDTO);
	
	//예약관리
	public int getBookCount(BookingDTO bookingDTO);
	public ArrayList<BookingDTO> bookListPage(BookingDTO bookingDTO);
	public int deleteBook(String code);
	
	public int getTotalCount(ParameterDTO parameterDTO);
	public int getTotalArtsCount(ParameterDTO parameterDTO);
	
	//어드민 - 작품관리 리스트
	public ArrayList<ArtsDTO> artListPage(ParameterDTO parameterDTO);
	//어드민 - 신규 작품 등록하기
	public void writeAction(ArtsDTO artsDTO);
	//어드민 - 작품정보 수정 페이지 로드
	public ArtsDTO modifyAT(ParameterDTO parameterDTO);
	//어드민 - 작품정보 수정하기
	public void modifyAction(ArtsDTO artsDTO);

	//어드민 - 작품 삭제하기
	public void deleteAction(String code);
	
	//경매 등록정보 리스트
	public ArrayList<AuctionInfoDTO> auctionListPage(ParameterDTO parameterDTO);
	//경매 등록 개수
	public int getAuctionTotalCount(ParameterDTO parameterDTO);

	//신규등록작품(경매준비중) 조회
	public ArrayList<ArtsDTO> aucReadyList(ParameterDTO parameterDTO);
	//
	public int getAuctionNewTotalCount(ParameterDTO parameterDTO);
	
	//메인> 입찰마감리스트
	public ArrayList<AuctionInfoDTO> terminatingAuctionList();


	
	//메인 그래프
	public ArrayList<Integer> getRentalSales();
	public ArrayList<Integer> dailyAuctionSales();
	public ArrayList<Integer> totalSales();
	public ArrayList<String> getday();
	
	//관리자 메인 화면 대시 보드에 오늘 매출액 출력
	public int todayRentalCount ();
	
	//관리자 메인 화면 대시 보드에 오늘 매출액 출력
	public int AuctionCount ();
	
	//관리자 메인 화면 대시 보드에 오늘 신규 등록된 작품 수 출력
	public int todayUploadArts ();
	
	//오늘 경매 매출
	public int todayAucSales();
	
	//오늘 렌탈 매출
	public int todayRentalSales();	
		
	//오늘 매출 총액
	public int todaySales();

	//메인> 작품status 현황 ( 원형 그래프)
	public ArrayList<ArtsDTO> countStatusGroup();
		

}
