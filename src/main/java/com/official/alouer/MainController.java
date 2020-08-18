package com.official.alouer;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.function.Consumer;

import javax.activation.CommandMap;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonFormat.Value;

import mybatis.AdminImpl;
import mybatis.ArtMapImpl;
import mybatis.ArtistDTO;
import mybatis.AuTransDTO;
import mybatis.AuctionDAOImpl;
import mybatis.AuctionInfoDTO;
import mybatis.BoardParameterDTO;
import mybatis.MainDTO;
import mybatis.MainImpl;
import mybatis.ParameterDTO;
import util.ArtList;

@Controller
public class MainController {

	@Autowired
	private SqlSession sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	LocalDateTime currentTime = LocalDateTime.now();
	// 1] DB저장값: 2020/08/23 15:23:01.123
	// 2] new Date("2020-07-27 18:23:01:000")); //JS에서 파싱할수있는 포맷
	SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss:SSS");
	//SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm");

	//메인페이지
	@RequestMapping("/")
	public String main(Locale locale, Principal principal, Authentication authentication, HttpServletRequest req,
			Model model, HttpSession session) {
		logger.info("메인페이지요청됨. ", locale);
		
		if(authentication!=null) {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			String user_id = userDetails.getUsername();
			String detail_id = userDetails.getUsername();
			boolean role = req.isUserInRole("ROLE_USER");
			System.out.println(role);
			System.out.println(user_id);
			
			session.setAttribute("role", role);
			session.setAttribute("user_id", user_id);
		}
		// 1-2Authentication 객체를 통한 아이디 반환
		
		
		
		/***************** #1 메인 슬라이더 : 지분경매 최신순 *****************/
		//파라미터 저장을 위한 DTO객체 생성
		ParameterDTO parameterDTO = new ParameterDTO();
		
		//슬라이더에 보여줄 게시물 개수 설정
		int start = 1;
		int end = 4;
		
		//위의 시작/종료 범위를 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		//슬라이더에 출력할 게시물 가져오기
		ArrayList<MainDTO> mainlist = sqlSession.getMapper(MainImpl.class).mainList(parameterDTO);
		
		
		double competition = 0;
		
		for(MainDTO dto : mainlist) {
			//전체 경매조각 수 대비 입찰자의 경쟁률 구하기
			competition =  ((double)dto.getCountTrans() / (double)dto.getAuctionTotal()) * 100.0;
			//소수점 자리수 처리
			competition = Math.round(competition*10)/10.0;
			  if(!dto.getImageUrl().startsWith("http")) {
		            dto.setImageUrl("/alouer/" + dto.getImageUrl());
		      }
			
			dto.setCompetition(competition);
		}
		
		//모델 객체에 저장
		model.addAttribute("mainlist", mainlist);
		
		
		/***************** #2 Coming Soon 영역: 경매준비중 최신순 *****************/
	      //슬라이더에 보여줄 게시물 개수 설정
	      start = 1;
	      end = 3;
	      
	      //파라미터 저장을 위한 DTO객체 생성
	      ParameterDTO parameterDTO2 = new ParameterDTO();
	            
	      //위의 시작/종료 범위를 DTO에 저장
	      parameterDTO2.setStart(start);
	      parameterDTO2.setEnd(end);
	      
	      //슬라이더에 출력할 게시물 가져오기
	      ArrayList<MainDTO> Cominglist = sqlSession.getMapper(MainImpl.class).mainListComing(parameterDTO2);
	      
	      
	      //크롤링한 이미지 URL경로가 아닌, 업로드한 이미지일 경우 아래와 같이 경로 처리 필수.
	      for(MainDTO dto : Cominglist) {
	         if(!dto.getImageUrl().startsWith("http")) {
	            dto.setImageUrl("/alouer/" + dto.getImageUrl());
	         }
	      }
	      
	      
	      //모델 객체에 저장
	      model.addAttribute("cominglist", Cominglist);
	      

	      
	      
	      /***************** #3 롤링 배너 영역 *****************/
	      //슬라이더에 보여줄 게시물 개수 설정
	      start = 1;
	      end = 37;
	      
	      //파라미터 저장을 위한 DTO객체 생성
	      ParameterDTO parameterDTO3 = new ParameterDTO();
	            
	      //위의 시작/종료 범위를 DTO에 저장
	      parameterDTO3.setStart(start);
	      parameterDTO3.setEnd(end);
	      
	      //출력할 게시물 가져오기
//	      ArrayList<MainDTO> Rollinglist = sqlSession.getMapper(MainImpl.class).mainListRolling(parameterDTO3);
	      final ArrayList<MainDTO> Rollinglist = sqlSession.getMapper(MainImpl.class).mainList(parameterDTO3);
	     
	      ArrayList<String> auctionCodeList = new ArrayList<String>();
	      //크롤링한 이미지 URL경로가 아닌, 업로드한 이미지일 경우 아래와 같이 경로 처리 필수.
	      for(MainDTO dto : Rollinglist) {
	    	  
	    	  System.out.println("code:"+dto.getCode());
	         if(!dto.getImageUrl().startsWith("http")) {
	            dto.setImageUrl("/alouer/" + dto.getImageUrl());
	         }
	         
	         //for문을 돌리면서 각 해당작품 코드 파라미터에 저장
	         parameterDTO3.setCode(dto.getCode());
	         
	         
	         auctionCodeList.add(dto.getCode());
	         
	      }
	      
	      
	      
	      
	      
	      try {
				//검색된 작품리스트를 가져옴
				System.out.println("리스트의 작품코드:"+auctionCodeList);
				final ArrayList<AuctionInfoDTO> auctionInfoList = 
						sqlSession.getMapper(AuctionDAOImpl.class).getTotalAuctionInfo(auctionCodeList);
				System.out.println("getTotalAuctionInfo결과 옥션갯수:"+auctionInfoList.size());
				
				//한작품에 여러개의 경매등록이 있을 경우 중복제거및 최근의 경매 정보만 저장한다.
				final HashMap<String, AuctionInfoDTO> au_map = new HashMap<String, AuctionInfoDTO>();
				auctionInfoList.forEach( new Consumer<AuctionInfoDTO>(){
					@Override
					public void accept(AuctionInfoDTO t) {
						System.out.println("변경전"+t.toString());
						au_map.put(t.getCode(), t);
					}
				});
				
				System.out.println("au_map:"+au_map.keySet());
				auctionInfoList.clear();//중복제거된 데이터를 넣기위해 clear
				//빈 list 객체에 다시 삽입
				au_map.values().forEach(new Consumer<AuctionInfoDTO>() {
					@Override
					public void accept(AuctionInfoDTO t) {
						System.out.println("변경후:"+t.toString());
						auctionInfoList.add(au_map.get(t.getCode()));
						
						
					}
				});
				System.out.println("auctionInfoList:"+auctionInfoList);
		
			
				//각각 경매물건의 최소 낙찰 가능 값을 저장함
				auctionInfoList.forEach(new Consumer<AuctionInfoDTO>() {
					@Override
					public void accept(AuctionInfoDTO dto) {
						int minPrice = 0;
						try {
							minPrice = sqlSession.getMapper(AuctionDAOImpl.class)
									.getMinPrice(dto.getAuctionId());
							dto.setMinPrice(minPrice);
							
							
						} catch (Exception e) {
							System.out.println("예외:최소낙찰가를 구하지 못함>시작가로 셋팅");
							dto.setMinPrice(Integer.parseInt(dto.getStartBids()));
							
							//e.printStackTrace();
						}
						System.out.println("최소낙찰가:"+dto.getMinPrice());
					}
				});	
			
			
				 for(MainDTO mainDTO : Rollinglist) {
					 for(AuctionInfoDTO auList : auctionInfoList) {
						 if(mainDTO.getCode().equals(auList.getCode())) {
							 mainDTO.setMinPrice(auList.getMinPrice());
							 System.out.println("mainDTO.MinPrice:"+mainDTO.getMinPrice());
						 }
						 
					 }
					 
				 }
				
				 
				 
				System.out.println(auctionInfoList.toString());
				//model.addAttribute("auctionInfoList", auctionInfoList);
			} catch (Exception e) {
				e.printStackTrace();
			}	
	      
	      //모델 객체에 저장
	      model.addAttribute("rollinglist", Rollinglist);
	      
	      
		/***************** #4 렌탈 작품 영역 *****************/
		//슬라이더에 보여줄 게시물 개수 설정
		start = 1;
		end = 19;
		
		//위의 시작/종료 범위를 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		//출력할 게시물 가져오기
		ArrayList<MainDTO> mainlistrental = sqlSession.getMapper(MainImpl.class).mainListRental(parameterDTO);
		
		//모델 객체에 저장
		model.addAttribute("mainlistrental", mainlistrental);
		
		
		return "/main";
	}

	
	// 경매가 끝나고 작품상세보기시 낙찰현황을 보여줌
	public ArrayList<AuTransDTO> showThisAuctionResult(String auctionId) {
		System.out.println(
				"[AutionController]:showThisAuctionResult()=======================");
		System.out.println("auctionId:" + auctionId);

		ArrayList<AuTransDTO> auctionResult = null;
		try {
			// 해당 작품의 auctionid를 통해 경매 입찰내역중 낙찰된 레코드들을 반환
			auctionResult = sqlSession.getMapper(AuctionDAOImpl.class)
					.getThisAuctionResult(auctionId);

			for (AuTransDTO dto : auctionResult) {
				// DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경
				dto.setFmtAuctionTime(dateFormat.format(dto.getAuctionTime()));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return auctionResult;
		
	}

	
	@RequestMapping(value="/about", method = RequestMethod.GET)
	public String about(Model model, HttpServletRequest req) {
		
		
		//폼값받기(반경, 위도, 경도)
		int distance = (req.getParameter("distance")==null) ? 
				0 : Integer.parseInt(req.getParameter("distance"));
		double latTxt = (req.getParameter("latTxt")==null) ?
				0 : Double.parseDouble(req.getParameter("latTxt"));
		double lngTxt = (req.getParameter("lngTxt")==null) ?
				0 : Double.parseDouble(req.getParameter("lngTxt"));
		
		System.out.println("distance:"+distance+"latTxt:"+latTxt+"lngTxt:"+lngTxt);
		ArrayList<ArtistDTO> searchLists = null;		
		if(distance!=0) {
			searchLists = sqlSession.getMapper(ArtMapImpl.class)
								.searchRadius(distance, latTxt, lngTxt);
			
			for(ArtistDTO dto : searchLists) {
				
				while(dto.getTitle().contains("\"")||dto.getTitle().contains("'")) {
					dto.setTitle(dto.getTitle().replaceAll("\"", " "));
					dto.setTitle(dto.getTitle().replaceAll("'", " "));
				}
				
			}
			
			System.out.println("searchLists"+searchLists.size());
			System.out.println("searchLists"+searchLists.toString());
			
			model.addAttribute("searchLists", searchLists);
		}

		return "about/about";
	}

	@RequestMapping("")
	public String showRoomList() {

		return "";
	}



	
	
}









