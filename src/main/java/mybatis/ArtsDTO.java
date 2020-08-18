package mybatis;

import java.sql.Date;

import lombok.Data;

@Data
public class ArtsDTO {
	private String code;		//작품 코드
	private String title;		//작품 제목
	private String memberId;	//arts 테이블의 멤버 아이디(작가의 아이디)
	private String name;		//작가의 이름
	private String note1;		//큐레이터 노트
	private String note2;    	//추천 이유
	private String material;	//재료	
	private int prodYear;		//제작년도 
	private int sizeHo;			//그림크기(호수)
	private int height;			//세로길이(cm)
	private int width;			//가로길이(cm)
	private Date regiDate;		//작품등록일
	private String imageUrl;	//이미지 url
	private int artValue;		//작품추정가치
	private int rentalPrice;	//렌탈가격
	private String pageUrl;		//오픈갤러리 페이지 url
	private String theme;		//작품의 테마
	private String color;		//작품의 색깔
	private String lat;			//
	private String status;		//작품의 현재 거래 상태
	private String lng;			//


	private String artValueFormat;
	private String rentalPriceFormat;
	
//	Admin 작품관리 페이지에 필요한 게시물의 가상번호 부여
	private int virtualNum;
    
    private int sum;//Auctionmapper.xml > countStatusGroup 에서 사용
    
    
    
}

