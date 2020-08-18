package mybatis;

import lombok.Data;

//파라미터 처리를위한 dto객체
@Data
public class BoardParameterDTO {
	
	private int idx;//게시물 일련번호
	private String memberId;//아이디
	private String authority;//권한
	
	//검색어처리를위한멤버변수
	private String searchField;
	private String searchTxt;//검색어
	
	//select구간을 위한 멤버변수
	private int start;//select의 시작
	private int end;//select의 끝
	private String backURL;//뒤로 가기 위한 것

	//게시판타입 설정
	private String bname;
	
	
	
}
