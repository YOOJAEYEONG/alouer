package mybatis;

import java.util.ArrayList;

public interface MemberImpl {


		
	//크롤링을 위하여 1차적으로 만듬, 회원가입 만들면서 필요에 따라 수정할것
	public void register(MemberVO memberVO);



	//회원가입 메소드
	public void memberJoinMethod(MemberVO memberVO);
	
	//이메일 중복체크(View/member/register.jsp에서 중복체크 눌렀을 때 실행 ajax)
	public int memExist(MemberVO memberVO);
	
	

	//////////↑↑↑↑↑member↑↑↑↑↑↑//////////
	/*////////////////////////////////////////////*/
	//////////↓↓↓↓↓mypage↓↓↓↓↓↓//////////
	
	
	//회원정보 수정에서 아이디, 기존 비밀번호 체크
	public int mypageIdPwdCheckMethod(MemberVO memberVO);
	
	//회원정보 수정에서 비밀번호 수정
	public int mypageModifyPwdChangeMethod(MemberVO memberVO);
	
	//회원정보 수정할 때 사용자 정보 가지고 오기
	public MemberVO MemberInfoMethod(MemberVO memberVO);
	
	//회원정보 수정한 내용 업데이트 
	public void MemberInfoUpdateMethod(MemberVO memberVO);
	
	//마이페이지 1:1문의하기 게시판
	ArrayList<MyBoardDTO> mypageInquiryMethod(String memberId);


	//마이페이지에서 작가가 작품 올릴 때 사용
	public void artistWriteAction (ArtsDTO artsDTO);
}
