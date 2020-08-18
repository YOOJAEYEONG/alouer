package com.official.alouer;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mybatis.ArtDAOImpl;
import mybatis.ArtsDTO;
import mybatis.MemberVO;
import mybatis.ParameterDTO;
import mybatis.RentalTransDTO;
import mybatis.rentalImpl;
import util.ArtList;

@Controller
public class RentalController {
	
	
	@Autowired
	private SqlSession sqlSession;

	

	//작품상세 페이지
	@RequestMapping("/rental/view.do")
	public String rentalView(Model model, HttpServletRequest req) {
		
		//파라미터 저장을 위한 DTO 생성
		ParameterDTO parameterDTO = new ParameterDTO();
		
		parameterDTO.setCode(req.getParameter("code")); //작품코드
		System.out.println(parameterDTO.getCode());
				
		ArtsDTO dto = 
				sqlSession.getMapper(ArtDAOImpl.class).viewinfo(parameterDTO);
		String edu = sqlSession.getMapper(ArtDAOImpl.class).eduinfo(parameterDTO);
		if(!dto.getImageUrl().startsWith("http")) {
        	dto.setImageUrl("/alouer/" + dto.getImageUrl());
        }
		System.out.println("info:"+dto.getCode());

		double width = dto.getWidth()*0.5;
		double height = dto.getHeight()*0.5;

  
		double ratio = height/width;
		System.out.println(ratio);
		
		model.addAttribute("ratio", ratio);
		//내용에 대해 줄바꿈 처리
		String temp1 = dto.getNote1().replace("\r\n", "<br>");
		dto.setNote1(temp1);
		String temp2 = dto.getNote2().replace("\r\n", "<br>");
		dto.setNote2(temp2);
		
		//추천작품 게시물 가져오기 1
		parameterDTO.setFltColor(dto.getColor());
		parameterDTO.setFltTheme(dto.getTheme());
		
		//추천작품 게시물 가져오기 2
		ArrayList<ArtsDTO> recommList = 
				sqlSession.getMapper(ArtDAOImpl.class).recommList(parameterDTO);
		
		model.addAttribute("info", dto);
		model.addAttribute("edu", edu);
		model.addAttribute("recommList", recommList);
		return "showroom/art/view";
	}	
	
	
	
	@RequestMapping("/rental")
	public String rental(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		
		new ArtList().getArtList(sqlSession, model,req, parameterDTO);
		
		return "showroom/art/list";
	}
	
	@RequestMapping("/artlocation")
	public String artlocation() {
		
		return "artlocation/artlocation";
	}
		
	@RequestMapping(value="/rental/reserve")
	@ResponseBody
	public int reserve(ParameterDTO parameterDTO, HttpServletRequest req) {
		
		System.out.println("컨트롤러"+parameterDTO.getCode());
		int aff = sqlSession.getMapper(rentalImpl.class).rentalBook(parameterDTO);
		
		int cnt = -1;
		
		if(aff==1) {
			cnt = sqlSession.getMapper(rentalImpl.class).selectBook(parameterDTO);
		}
		
		
		return cnt;
	}
	
	@RequestMapping(value="/rental/rentalAction.do", method=RequestMethod.GET)
	@ResponseBody
	public int rentalAction(HttpServletRequest req, RentalTransDTO rentalTransDTO) {		
		
		int aff = sqlSession.getMapper(rentalImpl.class).rentalInsert(rentalTransDTO);		
		int aff2 = sqlSession.getMapper(rentalImpl.class).updateStatus(rentalTransDTO);
		
		return aff;
	}
	
	
	////////////////////////////////////////////////////////////

	///////////체크아웃 주문결제 페이지

	////////////////////////////////////////////////////////////
	
	//체크아웃 페이지 로드
	@RequestMapping("/rental/checkout")
	public String checkout(Model model, HttpServletRequest req, HttpSession session) {
		
		ParameterDTO parameterDTO = new ParameterDTO();
		RentalTransDTO rentalTransDTO = new RentalTransDTO();
		
		
		//작품코드로 작품정보 가져오기
		parameterDTO.setCode(req.getParameter("code"));
		ArtsDTO artinfo = sqlSession.getMapper(rentalImpl.class).viewinfo(parameterDTO);
		if(!artinfo.getImageUrl().startsWith("http")) {
			artinfo.setImageUrl("/alouer/" + artinfo.getImageUrl());
        }
		
		//회원아이디로 회원정보 가져오기
		parameterDTO.setMemberId(req.getParameter("memberId"));
		MemberVO memberinfo = sqlSession.getMapper(rentalImpl.class).memberinfo(parameterDTO);
		
		//렌탈기간(일수) 가져오기
		int rentalPeriMonth = Integer.parseInt(req.getParameter("rentalPeri"));
		int rentalPeriDays = rentalPeriMonth * 30;
		
		String rentalBeginStr = req.getParameter("rentalBegin");
		String rentalEndStr = req.getParameter("rentalEnd");
		
		Date rentalBegin = Date.valueOf(rentalBeginStr); //날짜 포맷으로 변환
		Date rentalEnd = Date.valueOf(rentalEndStr); //날짜 포맷으로 변환
		
		int rentalPrice = artinfo.getRentalPrice();
		int totalAmount = rentalPeriMonth * rentalPrice;
		
		//렌탈트랜스DTO에 렌탈주문 정보 저장
		rentalTransDTO.setRentalPeriMonth(rentalPeriMonth); //개월수
		rentalTransDTO.setRentalPeriDays(rentalPeriDays);	//일수
		rentalTransDTO.setRentalBegin(rentalBegin);			//시작일
		rentalTransDTO.setRentalEnd(rentalEnd);				//종료일
		rentalTransDTO.setRentalPrice(rentalPrice);			//1개월의 렌탈가격
		rentalTransDTO.setTotalAmount(totalAmount);			//총 합계액
		
		
		//모델객체에 저장 후 view페이지에 전달
		model.addAttribute("artinfo", artinfo);
		model.addAttribute("memberinfo", memberinfo);
		model.addAttribute("transinfo", rentalTransDTO);
		
				
		return "rental/checkout";
	}
	
	
	//체크아웃 처리
	@RequestMapping(value="/rental/checkoutAction.do", method=RequestMethod.GET)
	@ResponseBody
	public String checkoutAction(RentalTransDTO rentalTransDTO, 
			HttpServletRequest req,	Model model) {
		
		System.out.println("checkoutAction 컨트롤러 진입==================");
		
		int inserted1 = sqlSession.getMapper(rentalImpl.class).rentalTrans(rentalTransDTO);
		int inserted2 = sqlSession.getMapper(rentalImpl.class).updateStatus(rentalTransDTO);
		
		System.out.println("렌탈트랜스 테이블 입력 성공!:"+ inserted1);
		System.out.println("아트 테이블 상태변경 성공!:"+ inserted2);
		
		
		return "1";
	}
	

}
