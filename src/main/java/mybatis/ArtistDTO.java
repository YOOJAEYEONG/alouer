package mybatis;

import java.sql.Date;

import lombok.Data;

@Data
public class ArtistDTO {
	private String code;
	private String title;
	private String memberId;
	private String name;
	private String note1;
	private String note2;    
	private String material;
	private int prodYear;
	private int sizeHo;
	private int height;
	private int width;
	private Date regiDate;
	private String imageUrl;
	private int artValue;
	private int rentalPrice;
	private String pageUrl;
	private String theme;
	private String color;
	private String lat;
	private String lng;
	private String status;


	private String artValueFormat;
	private String rentalPriceFormat;
	
//	Admin 작품관리 페이지에 필요한 게시물의 가상번호 부여
	private int virtualNum;
	
	private int start;//select의 시작
	private int end;//select의 끝
	
	private String searchField;
	private String searchTxt;//검색어
	
  	
  	private String diskm;
	private String rNum;
    
    
}

