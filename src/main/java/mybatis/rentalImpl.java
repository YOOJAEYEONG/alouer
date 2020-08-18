package mybatis;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

@Service
public interface rentalImpl {
	
	public int rentalBook(ParameterDTO parameterDTO);
	public int selectBook(ParameterDTO parameterDTO);
	
	public int rentalInsert(RentalTransDTO rentalTransDTO);
	public int updateStatus(RentalTransDTO rentalTransDTO);
	
	

	//작품코드로 작품정보 가져오기
	public ArtsDTO viewinfo(ParameterDTO parameterDTO);
	
	//회원아이디로 회원정보 가져오기
	public MemberVO memberinfo(ParameterDTO parameterDTO);
	
	//렌탈 결제완료 후 DB 입력처리
	public int rentalTrans(RentalTransDTO rentalTransDTO);
	
	//멤버아이디로 렌탈내역 가져오기
	public ArrayList<RentalTransDTO> rentalTransInfo(ParameterDTO parameterDTO);
	
	public int getTotalRentCount(ParameterDTO parameterDTO);
	
}
