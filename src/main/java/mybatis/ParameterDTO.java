package mybatis;


import java.util.Map;

//파라미터 처리를위한 dto객체

import lombok.Data;

@Data
public class ParameterDTO {
	
	private String idx;//게시물 일련번호
	private String memberId;//아이디
	private String authority;//권한
	
	//검색어처리를위한멤버변수
	private String searchField;
	private String searchTxt;//검색어
	
	//select구간을 위한 멤버변수
	private int start;//select의 시작
	private int end;//select의 끝
	private String backURL;//뒤로 갈때 	

	//작품리스트를 위해 추가
	private String code;	
	
    //리스트페이지 필터링 폼값용 파라미터
    private String selectedVal;
    private String quickChk;//렌탈가능,낮은가격순 중 선택된값을 가져오는용도
    
  	private String fltTheme;
  	private String fltColor;
  	private String fltSize;
  	private String fltShape;
  	private String fltPrice;
  	private String fltStatus;//렌탈가능 만 보기
  	private String fltOrderByPrice;//낮은가격순
  	
  	private String fltDelete;//리셋버튼폼값
  	
  	private String bname;
  	
  	private String page;//렌탈,지분경매,지분거래별 페이지에 따른 where문 값
  	private String name;//작가 이름
	
  	private String nowPage;
  	private String tableName;
  	private int auctionId;
  	
  	private int distance;//지도에서의 거리
  	private double latTxt;//경도
  	private double lngTxt;//위도
  	private String title;//작품명
  	
  	private String lat;//경도
	private String lng;//위도
	private String disKM;//거리
  	
  	
  	//렌탈주문 기간 파라미터
  	private int rentalPeriMonth;
  	private int rentalPeriDays;

  	
  	
}