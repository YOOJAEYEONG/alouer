package com.official.alouer;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Member;
import java.security.Principal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;

import login.kakao_restapi;
import mybatis.AdminImpl;
import mybatis.ArtDAOImpl;
import mybatis.ArtsDTO;
import mybatis.AuTransDTO;
import mybatis.AuctionDAOImpl;
import mybatis.AuctionInfoDTO;
import mybatis.DepositTbDTO;
import mybatis.BoardImpl;
import mybatis.BoardParameterDTO;
import mybatis.MemberImpl;
import mybatis.MemberVO;
import mybatis.MyBoardDTO;
import mybatis.ParameterDTO;
import mybatis.RentalTransDTO;
import mybatis.RevenueDTO;
import mybatis.RevenueImpl;
import mybatis.rentalImpl;
import util.EnvFileReader;
import util.PagingUtil;


@Controller
public class MyPageController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	@Autowired
	SqlSession sqlSession;
	//내비바에서 마이페이지를 눌렀을 때 
	@RequestMapping("/mypage")
	public String mypage(Principal principal, Model model, MemberVO memberVO) {
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		return "mypage/list2";
	}

	//마이페이지에서 나의 수익 클릭했을 때 이동 
	@RequestMapping("/mypage/revenue")
	public String revenue(Principal principal, Model model, MemberVO memberVO, HttpServletRequest req) {
		String memberId = principal.getName();
		memberVO.setMemberId(memberId);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ParameterDTO parameterDTO = new ParameterDTO();
		parameterDTO.setMemberId(memberId);		

		//전체 게시물 세기
		int totalRecordCount = sqlSession.getMapper(RevenueImpl.class).getTotalRevenueCount(parameterDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력

		//페이지 처리 설정값
		//Inits.properties에 설정한 값을 가져옴
		int pageSize = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "myPage_rentalList.pageSize"));
		int blockPage = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties","myPage_rentalList.blockPage"));

		//전체 페이지 수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		System.out.println("totalPage:"+totalPage);

		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		System.out.println("nowPage:"+ nowPage);
 
		//위에서 계산한 start,end를 DTO에 저장

		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		System.out.println("start:"+parameterDTO.getStart());
		System.out.println("end:"+parameterDTO.getEnd());      
		model.addAttribute("nowPage", nowPage);
		

		//렌탈 수익금 내역 가지고 오기
		ArrayList<RevenueDTO> revenueInfo = sqlSession.getMapper(RevenueImpl.class).viewRevenueInfo(parameterDTO);
		System.out.println("가져온 게시물 수:"+revenueInfo.size());

		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;
		double totalSales = 0;
		double auctionTotal = 0;
		double stockCnt = 0;
		double myProfitMoney = 0;
		double purchase = 0;
		double myProfitPercent = 0;
		

		for(RevenueDTO dto : revenueInfo) {
			//페이지 번호 적용하여 가상번호 계산(56 / 56-1-1*5+1= 
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
			
			totalSales = dto.getTotalSales();
			auctionTotal = dto.getAuctionTotal();
			stockCnt = dto.getStockCnt();
			System.out.println(totalSales);
			System.out.println(auctionTotal);
			
			myProfitMoney = (((totalSales / auctionTotal)*stockCnt)*0.2);
			dto.setMyProfitMoney((int)myProfitMoney);
			
			purchase = dto.getPurchase();
			myProfitPercent = (double)(myProfitMoney / purchase);
			System.out.println(myProfitPercent);
			dto.setMyProfitPercent(myProfitPercent);
			if(!dto.getImageUrl().startsWith("http")) {
				dto.setImageUrl("/alouer/" + dto.getImageUrl());
	        }
		}      

		//페이지 번호
		String pagingBtn = PagingUtil.pagingArtListForFilter(
				totalRecordCount, pageSize, blockPage, nowPage, req.getRequestURI() +"?");
		model.addAttribute("pagingBtn", pagingBtn);//페이지 버튼
		System.out.println("totalRecordCount+ pageSize+blockPage+nowPage"+totalRecordCount+ pageSize+blockPage+nowPage);
		

		//모델 객체에 저장
		model.addAttribute("pagingBtn", pagingBtn); //페이징처리
		model.addAttribute("mVO", memberVO);//회원정보
		model.addAttribute("revenueInfo", revenueInfo);//렌탈정보
		
		return "mypage/revenue";
	}


	//마이페이지에서 예치금관리를 눌렀을 때 view/mypage/deposit.jsp로 이동
	@RequestMapping("/mypage/deposit")
	public String deposit(Principal principal, Model model, Locale locale,HttpServletRequest req, ParameterDTO parameterDTO, MemberVO memberVO) {
		logger.info("[deposit컨트롤러]================", locale);
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		//사용자의 예치금을 가져온다
		try {
			int balance = 0;
			//현재 접속한 회원의 예치금을 가져옴
			balance = sqlSession.getMapper(AuctionDAOImpl.class).getBalance(principal.getName());
			System.out.println("balance:"+balance);
			model.addAttribute("balance", balance);
		} catch (Exception e) {
			e.printStackTrace();
		}

		//예치금 충전 / 사용내역을 가져옴
		try {
			if(principal!=null) {
				model.addAttribute("memberId", principal.getName());
				parameterDTO.setMemberId(principal.getName());

				//1
				int totalDepositCnt = 
						sqlSession.getMapper(AuctionDAOImpl.class).getTotalDepositCnt(parameterDTO);
				System.out.println("totalDepositCnt: "+totalDepositCnt);

				//2 페이지 처리를 위한 설정값
				int pageSize = Integer.parseInt(
						EnvFileReader.getValue("Inits.properties","myPage_depositList.pageSize"));
				int blockPage = Integer.parseInt(
						EnvFileReader.getValue("Inits.properties","myPage_depositList.blockPage"));

				//3 전체페이지수 계산
				int totalPage = (int)Math.ceil((double)totalDepositCnt/pageSize);
				//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
				int nowPage = req.getParameter("nowPage")==null ? 1 :
					Integer.parseInt(req.getParameter("nowPage"));

				//4
				int start = (nowPage-1) * pageSize +1;
				int end = nowPage * pageSize;
				//5
				parameterDTO.setStart(start);
				parameterDTO.setEnd(end);

				//현재 접속한 회원의 예치금 입출금 리스트를 가져옴
				ArrayList<DepositTbDTO> balanceHistory = 
						sqlSession.getMapper(AuctionDAOImpl.class).getBalanceHistory(parameterDTO);
				System.out.println("가져온 balanceHistory:"+balanceHistory);
				SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
				for(DepositTbDTO dto : balanceHistory) {

					//DB timestamp 포맷을 JS에서 인식 가능한 포맷으로 변경
					dto.setFmtTransTime(dateFormat.format( dto.getTranstime() ));
				}
				model.addAttribute("balanceHistory", balanceHistory);

				//페이지 번호
				String pagingBtn = PagingUtil.pagingArtListForFilter(
						totalDepositCnt,pageSize,blockPage,nowPage,req.getRequestURI() +"?");
				model.addAttribute("pagingBtn", pagingBtn);//페이지 버튼
			}				
		} catch (Exception e) {
			e.printStackTrace();
		}


		return "mypage/deposit";
	}

	//마이페이지에서 회원정보 눌렀을 때 view/mypage/modify.jsp로 이동
	@RequestMapping("/mypage/modify")
	public String modify(Principal principal, Model model, MemberVO memberVO) {
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		return "mypage/modify";
	}




	@RequestMapping("/mypage/art")
	public String art() {

		return "mypage/art";
	}


	//마이페이지 > 옥션 : 입찰내역,낙찰내역을 가져옴
	@RequestMapping("/mypage/auction")
	public String auction(Model model, Principal principal, MemberVO memberVO) {
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		
		ArrayList<AuTransDTO> totalSuccessfulBid = null;
		System.out.println("/mypage/auction]컨트롤러================================");
		System.out.println("memberId:"+principal.getName());
		
		try {
			totalSuccessfulBid = 
					sqlSession.getMapper(AuctionDAOImpl.class).getTotalSuccessfulBid(principal.getName());
					System.out.println(totalSuccessfulBid.get(0).getImageurl());
		} catch (Exception e) {
			e.printStackTrace();
		}
		

		//1] DB저장값:	2020/08/23 15:23:01.123
		//2] new Date("2020-07-27 18:23:01:000")); //JS에서 파싱할수있는 포맷
		SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd");
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("YYYYMMddHHmmss");
		

		for(AuTransDTO dto : totalSuccessfulBid) {
			//DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경
	        if(!dto.getImageurl().startsWith("http")) {
	        	dto.setImageurl("/alouer/" + dto.getImageurl());
	        }
			/*
			 * dto.setFmtAuctionTime(dateFormat.format( dto.getAuctionTime()) );
			 * dto.setFmtEndTime(dateFormat.format( dto.getEndTime()));
			 */
			System.out.println("dto:"+dto.toString());
		}
		
		model.addAttribute("totalSuccessfulBid", totalSuccessfulBid);

		ArrayList<AuTransDTO> getTotalBidding = 
				sqlSession.getMapper(AuctionDAOImpl.class).getTotalBidding(principal.getName());
		//1] DB저장값:	2020/08/23 15:23:01.123
		//2] new Date("2020-07-27 18:23:01:000")); //JS에서 파싱할수있는 포맷
		for(AuTransDTO dto : getTotalBidding) {
	        if(!dto.getImageurl().startsWith("http")) {
	        	dto.setImageurl("/alouer/" + dto.getImageurl());
	        }
			//DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경
			dto.setFmtAuctionTime(dateFormat.format( dto.getAuctionTime()));
			dto.setFmtEndTime(dateFormat.format( dto.getEndTime()));
			model.addAttribute("lastTime", dateFormat2.format( dto.getEndTime()));

			System.out.println("dto:"+dto.toString());
		}
		model.addAttribute("getTotalBidding", getTotalBidding);
		return "mypage/auction";
	}


	@RequestMapping("/mypage/auction/view.do")
	public String auctionView() {

		return "mypage/auction/view.do";
	}


	@RequestMapping("/mypage/stock")
	public String stock() {

		return "mypage/stock";
	}



	@RequestMapping("/mypage/stock/view.do")
	public String stockView() {

		return "mypage/stock/view.do";
	}


	//마이페이지 - 나의 렌탈페이지 로드
	@RequestMapping("/mypage/rental")
	public String rental(HttpServletRequest req, Principal principal, MemberVO memberVO, Model model) {
		String memberId = principal.getName();
		memberVO.setMemberId(memberId);
		System.out.println("memberId:"+ memberId);

		//회원아이디로 회원의 모든 정보 가지고 오기
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		ParameterDTO parameterDTO = new ParameterDTO();
		parameterDTO.setMemberId(memberId);		

		//전체 게시물 세기
		int totalRecordCount = sqlSession.getMapper(rentalImpl.class).getTotalRentCount(parameterDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력

		//페이지 처리 설정값
		//Inits.properties에 설정한 값을 가져옴
		int pageSize = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "myPage_rentalList.pageSize"));
		int blockPage = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties","myPage_rentalList.blockPage"));

		//전체 페이지 수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		System.out.println("totalPage:"+totalPage);

		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		System.out.println("nowPage:"+ nowPage);
 
		//위에서 계산한 start,end를 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		
		System.out.println("start:"+parameterDTO.getStart());
		System.out.println("end:"+parameterDTO.getEnd());      
		model.addAttribute("nowPage", nowPage);
		

		//회원아이디로 렌탈 주문내역 가지고 오기
		ArrayList<RentalTransDTO> rentalInfo = sqlSession.getMapper(rentalImpl.class).rentalTransInfo(parameterDTO);

		System.out.println("가져온 게시물 수:"+rentalInfo.size());

		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;

		for(RentalTransDTO dto : rentalInfo) {
			//페이지 번호 적용하여 가상번호 계산(56 / 56-1-1*5+1= 
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
			if(!dto.getImageUrl().startsWith("http")) {
				dto.setImageUrl("/alouer/" + dto.getImageUrl());
	        }
		}      

		//페이지 번호
		String pagingBtn = PagingUtil.pagingArtListForFilter(
				totalRecordCount, pageSize, blockPage, nowPage, req.getRequestURI() +"?");
		model.addAttribute("pagingBtn", pagingBtn);//페이지 버튼
		System.out.println("totalRecordCount+ pageSize+blockPage+nowPage"+totalRecordCount+ pageSize+blockPage+nowPage);
		

		//모델 객체에 저장
		model.addAttribute("pagingBtn", pagingBtn); //페이징처리
		model.addAttribute("mVO", memberVO);//회원정보
		model.addAttribute("rentalinfo", rentalInfo);//렌탈정보

		return "mypage/rental";
	}

	//회원정보 수정 페이지에서 이메일, 기존 비밀번호 체크
	//(View/mypage/modify.jsp에서 기존 비밀번호 입력후 포커스 잃었을 때 실행 ajax)
	@RequestMapping(value = "/mypage/modify/idPwdCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String mypageModifyIdPwdCheck(HttpServletRequest req, Model model) {

		System.out.println("/mypage/modify/idPwdCheck.do 들어옴");
		MemberVO dto = new MemberVO();
		String userId = req.getParameter("userId");
		System.out.println("userId값"+userId);
		String userPass = req.getParameter("userPass");
		System.out.println("userPass값"+userPass);
		dto.setMemberId(userId);
		dto.setPass(userPass);
		int mypageIdPwdCheckMethod = sqlSession.getMapper(MemberImpl.class).mypageIdPwdCheckMethod(dto);


		return Integer.toString(mypageIdPwdCheckMethod);
	}



	//회원정보 수정 페이지에서 비밀번호 변경 
	//(View/mypage/modify.jsp에서 비밀번호 변경 눌렀을 때 실행되는 함수ajax)
	@RequestMapping(value = "/mypage/modify/pwdChange.do", method = RequestMethod.POST)
	@ResponseBody
	public String mypageModifyPwdChange(HttpServletRequest req, Model model) {
		System.out.println("/mypage/modify/pwdChange.do 들어옴" );
		MemberVO dto = new MemberVO();
		String userId = req.getParameter("userId");
		String userPass = req.getParameter("userPass");
		dto.setMemberId(userId);
		dto.setPass(userPass);
		int mypageModifyPwdChangeMethod = sqlSession.getMapper(MemberImpl.class).mypageModifyPwdChangeMethod(dto);
		System.out.println(Integer.toString(mypageModifyPwdChangeMethod));
		return Integer.toString(mypageModifyPwdChangeMethod);
	}



	//회원정보 수정 페이지에서 회원정보 업데이트
	//(View/mypage/modify.jsp에서 회원정보수정 버튼을 눌렀을 때 실행되는 함수)
	//		@RequestMapping(value = "mypage/modify/MemberInfoUpdate.do", method = RequestMethod.POST)
	//		@ResponseBody

	@RequestMapping("mypage/modify/MemberInfoUpdate.do")
	public String MemberInfoUpdate(HttpServletRequest req, Model model, MemberVO memberVO) {
		System.out.println("/mypage/modify/MemberInfoUpdate.do 들어옴" );
		String userAddress = 
				req.getParameter("sample4_postcode") + "||"+
						req.getParameter("sample4_roadAddress") + "||"+
						req.getParameter("sample4_jibunAddress") + "||"+
						req.getParameter("sample4_detailAddress") + "||"+
						req.getParameter("sample4_extraAddress");


		memberVO.setAddress(userAddress);
		//			int MemberInfoUpdateMethod = sqlSession.getMapper(MemberImpl.class).MemberInfoUpdateMethod(dto);
		//			System.out.println(Integer.toString(MemberInfoUpdateMethod));

		sqlSession.getMapper(MemberImpl.class).MemberInfoUpdateMethod(memberVO);
		return "mypage/list2";
	}



	//카카오톡 로그인
	private kakao_restapi kakao_restapi = new kakao_restapi();

	@RequestMapping(value = "/kakaologin.do", produces = "application/json")
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session, 
			HttpServletRequest req, RedirectAttributes red) {
		System.out.println("로그인 할때 임시 코드값");
		//카카오 홈페이지에서 받은 결과 코드
		System.out.println(code);
		System.out.println("로그인 후 결과값");

		//카카오 rest api 객체 선언
		kakao_restapi kr = new kakao_restapi();
		//결과값을 node에 담아줌
		JsonNode node = kr.getAccessToken(code);
		//결과값 출력
		System.out.println(node);
		//노드 안에 있는 access_token값을 꺼내 문자열로 변환
		String token = node.get("access_token").toString();
		//세션에 담아준다.
		session.setAttribute("token", token);

		return "main.do";
	}

	//카카오톡 로그아웃
	@RequestMapping(value = "/logout", produces = "application/json")
	public String Logout(HttpSession session) {
		//kakao restapi 객체 선언
		kakao_restapi kr = new kakao_restapi();
		//노드에 로그아웃한 결과값을 담아줌 매개변수는 세션에 있는 token을 가져와 문자열로 변환
		JsonNode node = kr.Logout(session.getAttribute("token").toString());
		//결과 값 출력
		System.out.println("로그인 후 반환되는 아이디 : " + node.get("id"));
		return "redirect:/";
	}    




	//마이페이지에서 1:1문의하기 눌렀을 때/고객지원에서 문의하기 눌렀을 때 실행
	@RequestMapping("/mypage/inquiry/inquiryList")
	public String inquiryList(HttpServletRequest req, Model model, ParameterDTO parameterDTO, Principal principal, MemberVO memberVO) {
		String memberId = principal.getName();
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		parameterDTO.setMemberId(memberId);
		parameterDTO.setBname("inquiry");
		System.out.println("Bname"+parameterDTO.getBname());

		parameterDTO.setSearchField(req.getParameter("searchField"));
		parameterDTO.setSearchTxt(req.getParameter("searchTxt"));
		System.out.println("검색어: " + parameterDTO.getSearchTxt());

		//게시판 타입 지정
		model.addAttribute("bname", parameterDTO.getBname());//게시판 타입 저장

		//전체 게시물 세기
		int totalRecordCount = sqlSession.getMapper(BoardImpl.class)
				.inquiryTotalCount(parameterDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력

		//페이지 처리 설정값
		int pageSize = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "csBoard.pageSize"));
		int blockPage = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "csBoard.blockPage"));

		//전체 페이지 수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;

		//위에서 계산한 start,end를 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		model.addAttribute("nowPage", nowPage);


		//리스트 페이지에 출력할 게시물 가져오기
		ArrayList<MyBoardDTO> lists = sqlSession.getMapper(BoardImpl.class).inquiryListPage(parameterDTO);

		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;

		for(MyBoardDTO dto : lists) {
			//페이지 번호 적용하여 가상번호 계산
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
		}		

		//페이지 번호 처리(Ajax 사용아님)
		String pagingImg = 
				PagingUtil.pagingImg
				(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath() + "/mypage/inquiry/inquiryList?bname=" + parameterDTO.getBname() + "&");

		//모델 객체에 저장
		model.addAttribute("params", parameterDTO);
		model.addAttribute("lists", lists);
		model.addAttribute("pagingImg", pagingImg);

		System.out.println("lists: " + lists);		

		return "mypage/inquiry/inquiryList";
	}

	//1:1 문의게시판 글 상세보기
	@RequestMapping("/mypage/inquiry/inquiryView.do")
	public String inquiryView(HttpServletRequest req, ParameterDTO parameterDTO,
			MyBoardDTO myBoardDTO, Model model, Principal principal, MemberVO memberVO) {
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		myBoardDTO = sqlSession.getMapper(BoardImpl.class).view(parameterDTO);

		String temp = myBoardDTO.getContents().replace("\r\n", "<br>");//줄바꿈처리

		myBoardDTO.setContents(temp);
		model.addAttribute("params", parameterDTO);
		model.addAttribute("nowPage", req.getParameter("nowPage"));
		model.addAttribute("list", myBoardDTO);


		return "mypage/inquiry/inquiryView";
	}


	//1:1 문의게시판 글쓰기 창으로 이동
	@RequestMapping("/mypage/inquiry/inquiryWrite.do")
	public String inquiryWrite(HttpServletRequest req, Model model, Principal principal, MemberVO memberVO) {
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		String bname = req.getParameter("bname");

		model.addAttribute("bname",bname);

		return "mypage/inquiry/inquiryWrite";
	}

	//1:1 문의게시판 글쓰기
	@RequestMapping(value="/mypage/inquiry/inquiryWriteAction.do", method=RequestMethod.POST)
	public String inquiryWriteAction(MyBoardDTO myBoardDTO, HttpServletRequest req,
			ParameterDTO parameterDTO, Principal principal, MemberVO memberVO, Model model) {
		String userid = principal.getName();
		memberVO.setMemberId(userid);
		try {
			memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mVO", memberVO);
		System.out.println("WriteAction.do 들어옴");
		int aff = sqlSession.getMapper(BoardImpl.class).write(myBoardDTO);
		System.out.println(aff);


		return "redirect:./inquiryList";
	}


	//1:1 문의게시판 수정 창으로 이동 /글 정보 가져오기
	@RequestMapping("/mypage/inquiry/inquiryEdit.do")
	public String inquiryEdit(HttpServletRequest req, ParameterDTO parameterDTO,
			MyBoardDTO myBoardDTO, Model model, MemberVO memberVO, Principal principal) {
		
			String userid = principal.getName();
			memberVO.setMemberId(userid);
			try {
				memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addAttribute("mVO", memberVO);
			myBoardDTO = sqlSession.getMapper(BoardImpl.class).view(parameterDTO);
			System.out.println(myBoardDTO.getContents());
			String temp = myBoardDTO.getContents().replace("<br>", "\r\n");//줄바꿈처리
			System.out.println("temp:"+temp);
			model.addAttribute("params", parameterDTO);
			model.addAttribute("nowPage", req.getParameter("nowPage"));
			model.addAttribute("list", myBoardDTO);
			
			
			
			return "mypage/inquiry/inquiryEdit";
		}
		
		
		
		//1:1 문의게시판 글쓰기
		@RequestMapping(value="/mypage/inquiry/inquiryEditAction.do", method=RequestMethod.POST)
		public String inquiryEditAction(MyBoardDTO myBoardDTO, HttpServletRequest req,
				ParameterDTO parameterDTO, Principal principal, MemberVO memberVO, Model model) {
			String userid = principal.getName();
			memberVO.setMemberId(userid);
			try {
				memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addAttribute("mVO", memberVO);
			String memberId = principal.getName();
			parameterDTO.setMemberId(memberId);
			System.out.println("inquiryEditAction.do 들어옴");
			int aff = sqlSession.getMapper(BoardImpl.class).inquiryEdit(myBoardDTO);
			System.out.println(aff);
			
			
			return "redirect:./inquiryList";
		}

		
		
		
		//마이페이지에서 작가가 작품등록하기 눌렀을 때 등록창으로 이동
		@RequestMapping("/mypage/artist/artistWrite")
		public String artistWrite(Principal principal, Model model, MemberVO memberVO) {
			String userid = principal.getName();
			memberVO.setMemberId(userid);
			try {
				memberVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
			model.addAttribute("mVO", memberVO);
			return "mypage/artist/artistWrite";
		}
		
	   public static String getUuid() {
		      String uuid = UUID.randomUUID().toString();
		      System.out.println("생성된UUID:"+ uuid);
		      uuid = uuid.replaceAll("-", "");
		      System.out.println("생성된UUID:"+ uuid);
		      
		      return uuid;
		   }
	   
	   
		//마이페이지 작가가 작품 등록 처리
	   @RequestMapping(method=RequestMethod.POST, value="/mypage/artist/artistWrite/artistWriteAction.do")
	   public String artistWriteAction(HttpSession session, ArtsDTO artsDTO,
	         MultipartHttpServletRequest req, Principal principal) {
		   String userid = principal.getName();
	      //서버의 물리적경로 가져오기
	      String path = req.getSession().getServletContext().getRealPath("/resources/upload");
	      System.out.println("서버의 물리적경로:"+path);
	      try {
	         //업로드폼의 file속성의 필드를 가져온다.(아래 코드는 다중 파일일 때도 가능한 코드)
	         Iterator itr = req.getFileNames();
	         MultipartFile mfile = null;
	         String fileName = "";
	         List resultList = new ArrayList();
	         
	         //파일외의 폼값 받음(여기서는 제목만 있음)
//		         String title = req.getParameter("title");
//		         System.out.println("title="+title);
	         /*

	         물리적경로를 기반으로 File 객체를 생성한 후 지정되 디렉토리가 존재하는지 확인함. 
	         만약 없다면 생성함.
	          */
	         File directory = new File(path);
	         if(!directory.isDirectory()) {
	            directory.mkdirs();
	         }
	         //업로드폼의 file속성의 필드개수만큼 반복
	         while(itr.hasNext()) {
	            //전송된 파일의 이름을 읽어온다.
	            fileName = (String)itr.next();
	            mfile = req.getFile(fileName);
	            System.out.println("mfile="+ mfile);
	            
	            //한글깨짐방지 처리 후 전송된 파일명을 가져옴.
	            String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
	            
	            //서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
	            if("".equals(originalName)) {
	               continue;
	            }
	            
	            //파일명에서 확장자 부분을 가져옴
	            String ext = originalName.substring(originalName.lastIndexOf('.'));
	            //UUID를 통해 생성된 문자열과 확장자를 합침
	            String saveFileName = getUuid() + ext;
	            //물리적경로에 새롭게 생성된 파일명으로 파일저장
	            File serverFullName = new File(path + File.separator + saveFileName);
	            //
//		            String serverFullName2 = new String(path + saveFileName);
	            
	            System.out.println(serverFullName.toString());
	            //upload 요청명
	            String imageUrl = "upload/" + saveFileName;
	            System.out.println(imageUrl);
	            mfile.transferTo(serverFullName);
	            artsDTO.setImageUrl(imageUrl);
	         }
	         
	      } 
	      catch (IOException e) {
	         e.printStackTrace();
	      }
	      catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      sqlSession.getMapper(MemberImpl.class).artistWriteAction(artsDTO);
	      
	      return "redirect:/showroom/art/artistview.do?memberId="+userid;
	   }



	}


















