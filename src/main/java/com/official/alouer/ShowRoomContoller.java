package com.official.alouer;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.ListIterator;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.RequestWrapper;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import mybatis.ArtDAOImpl;
import mybatis.ArtistDTO;
import util.ArtList;
import util.EnvFileReader;
import util.PagingUtil;
import mybatis.ArtsDTO;
import mybatis.AuctionDAOImpl;
import mybatis.AuctionInfoDTO;
import mybatis.MainDTO;
import mybatis.MemberVO;
import mybatis.MybatisDAOImpl;
import mybatis.ParameterDTO;


@Controller
public class ShowRoomContoller {

	@Autowired
	private SqlSession sqlSession;
	

	@RequestMapping("/showroom/art")
	public String showroomArt(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		System.out.println("[컨트롤러]ShowRoomContoller============================");
		
		
		
		/*
		 리스트페이지는 모듈화 했으므로 경매,쇼룸,지분거래에서도 리스트페이지를 사용할수있다.
		 1. new ArtList().getArtList(sqlSession, model,req, parameterDTO); 
		 2. public void getArtList(HttpServletRequest req) 메소드에서 작품
		 	dto를 담은 arraylist를 리퀘스트영역에 저장한다. 이를 받으면된다
		 	-> req.getAttribute("list")
		 */		
		
				
		new ArtList().getArtList(sqlSession, model,req, parameterDTO);
		
		try {
			//검색된 작품리스트를 가져옴
			ArrayList<String> auctionCodeList = (ArrayList<String>) req.getAttribute("list");
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
		
		
			
			System.out.println(auctionInfoList.toString());
			model.addAttribute("auctionInfoList", auctionInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//return "showroom/list";
		/*
		redirect를 쓸경우 model에 저장된 기본 타입은 자동으로 
		파라미터로 주소줄에 조립해준다. 단 return 값은 요청명을 써야한다
		return "showroom/list"; => 해당 파일위치
		return "redirect:/list"; => 요청명이됨. 
		 */
		return "showroom/art/list";

	}
	
	//작품상세 페이지

	@RequestMapping("/showroom/art/view.do")
	public String showroomView(Model model, HttpServletRequest req) {
		
		//파라미터 저장을 위한 DTO 생성
		ParameterDTO parameterDTO = new ParameterDTO();
		
		parameterDTO.setCode(req.getParameter("code")); //작품코드
		System.out.println(parameterDTO.getCode());
				
		ArtsDTO dto = 
				sqlSession.getMapper(ArtDAOImpl.class).viewinfo(parameterDTO);
		String edu = sqlSession.getMapper(ArtDAOImpl.class).eduinfo(parameterDTO);
		System.out.println("info:"+dto.getCode());
		
		double width = dto.getWidth()*0.5;
		double height = dto.getHeight()*0.5;
		
		double ratio = height/width;
		System.out.println(ratio);
		
		model.addAttribute("ratio", ratio);
		
		//작품이미지 경로 처리
		//크롤링한 이미지 URL경로가 아닌, 업로드한 이미지일 경우 아래와 같이 경로 처리 필수.
	  	if(!dto.getImageUrl().startsWith("http")) {
	  		dto.setImageUrl("/alouer/" + dto.getImageUrl());
	    }
	    
		
		//내용에 대해 줄바꿈 처리
		
	  	if(dto.getNote1()!= null && dto.getNote1().equals("")) {
	  		
	  		String temp1 = dto.getNote1().replace("\r\n", "<br>");
	  		dto.setNote1(temp1);
	  	}
		if(dto.getNote2()!= null && dto.getNote2().equals("")) {
		String temp2 = dto.getNote2().replace("\r\n", "<br>");
		dto.setNote2(temp2);
		}
		
		//추천작품 게시물 가져오기 1
		parameterDTO.setFltColor(dto.getColor());
		parameterDTO.setFltTheme(dto.getTheme());
		
		//추천작품 게시물 가져오기 2
		ArrayList<ArtsDTO> recommList = 
				sqlSession.getMapper(ArtDAOImpl.class).recommList(parameterDTO);
		
		for(ArtsDTO adto : recommList) {
			if(!adto.getImageUrl().startsWith("http")) {
				adto.setImageUrl("/alouer/" + adto.getImageUrl());
			}
		}
		
		
		model.addAttribute("info", dto);
		model.addAttribute("edu", edu);
		model.addAttribute("recommList", recommList);
		return "showroom/art/view";
	}

	
	
	
	//작가 전체 리스트 페이지
	@RequestMapping(value="/showroom/art/artists", method = RequestMethod.GET)
	public String artistview(Model model, HttpServletRequest req, ParameterDTO parameterDTO,
			ArtistDTO artistDTO) {
		
		//검색어
		System.out.println("searched: "+ parameterDTO.getSearchTxt());
		
		String searchField =  parameterDTO.getSearchField();
		String searchTxt = parameterDTO.getSearchTxt();
		System.out.println(searchField);
		
		if(searchTxt==null || searchTxt.equals("")) {
			searchField = "";
			searchTxt = "";
			System.out.println(searchField);
		}
		
		
		//전체 작가 인원수
		int totalArtists = sqlSession.getMapper(ArtDAOImpl.class).getTotalArtists(artistDTO);
		System.out.println("totalArtists: " + totalArtists);
		
		//페이징 처리
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Inits.properties", "showRoom_ArtList.pageSize"));
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Inits.properties", "showRoom_ArtList.blockPage"));
		
		int totalPage = (int)Math.ceil((double)totalArtists/pageSize);
		
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		
		artistDTO.setStart(start);
		artistDTO.setEnd(end);
		System.out.println("name:"+artistDTO.getName());
		
		//작가 리스트 
		ArrayList<ArtistDTO> artists = sqlSession.getMapper(ArtDAOImpl.class).artistList(artistDTO);//start와 end값 저장
		
		
		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;
		
		for(ArtistDTO dto : artists) {
			virtualNum = totalArtists - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
		}
		
		System.out.println("our artists: "+ artists);
		
		String pagingImg = 
				PagingUtil.pagingImg(totalArtists, pageSize, blockPage, nowPage, 
						req.getContextPath() +"/showroom/art/artists?searchField=" 
						+ searchField + "&searchTxt=" 
						+ searchTxt + "&");
		
		model.addAttribute("totalArtists", totalArtists);//총 작가 인원
		model.addAttribute("artists", artists);//작가명단
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("params", parameterDTO);
		
		return "showroom/artist/artists";
	}
	
	
	//작가 상세 페이지
	@RequestMapping("showroom/art/artistview.do")
	public String artistView(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {

		
		int totalArts = sqlSession.getMapper(ArtDAOImpl.class).getTotalArtsCount(parameterDTO);
		System.out.println("totalArts: " + totalArts);
		
		//페이징 처리
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Inits.properties", "showRoom_ArtList.pageSize"));
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Inits.properties", "showRoom_ArtList.blockPage"));
		
		int totalPage = (int)Math.ceil((double)totalArts/pageSize);
		
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		System.out.println("name:"+parameterDTO.getName());
		
		//작가 리스트 
		ArrayList<ArtsDTO> artists = sqlSession.getMapper(ArtDAOImpl.class).artistsWork(parameterDTO);
		
		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;
		
		for(ArtsDTO dto : artists) {
			virtualNum = totalArts - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
		}
		
		System.out.println("our artists: "+ artists);
		
		String pagingImg = 
				PagingUtil.pagingImg(totalArts, pageSize, blockPage, nowPage, 
						req.getContextPath() +"/showroom/art/artists?");
		
		MemberVO memberVO = sqlSession.getMapper(ArtDAOImpl.class).getArtistInfo(parameterDTO);
		
		model.addAttribute("totalArtists", totalArts);//총 작가 인원
		model.addAttribute("artists", artists);//작가명단
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("params", parameterDTO);
		model.addAttribute("memberInfo", memberVO);
		
		return "showroom/artist/viewArtist";
	}
	
}
















