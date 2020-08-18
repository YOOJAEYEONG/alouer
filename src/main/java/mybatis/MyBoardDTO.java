package mybatis;

import lombok.Data;

@Data
public class MyBoardDTO {
	//멤버변수
	private int idx;//일련번호
	private String title;//제목
	private String contents;//내용
	private java.sql.Date postdate;//게시일
	
	private int hits;//조회수
    private String memberId;//아이디
    //테이블 타입 변수
    private String bname;
    private String pass;//비번
    
	//가상번호 부여를 위한 멤버변수 추가
	private int virtualNum;
	
	//검색어처리를위한멤버변수
	private String searchField;
	private String searchTxt;//검색어
	
	
	//1:1문의 게시판 답변과 답변 여부 멤버변수 추가
	private String reply; 
	private int replyOX; //디폴트값 0 / 0=답변 전 1= 답변 후
	private java.sql.Date replydate;//답변을 남긴 날짜
}
