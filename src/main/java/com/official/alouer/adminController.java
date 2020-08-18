package com.official.alouer;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mybatis.AdminImpl;
import mybatis.ArtDAOImpl;
import mybatis.ArtsDTO;
import mybatis.AuTransDTO;
import mybatis.AuctionDAOImpl;
import mybatis.AuctionInfoDTO;
import mybatis.BoardImpl;
import mybatis.BoardParameterDTO;
import mybatis.BookingDTO;
import mybatis.MemberImpl;
import mybatis.MemberVO;
import mybatis.MyBoardDTO;
import mybatis.MybatisDAOImpl;
import mybatis.ParameterDTO;
import mybatis.RentalTransDTO;
import util.ArtList;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class adminController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	
	////////////////////////////////////////////////////////////////////////////
	
	//////////////관리자 메인 페이지 대시보드
	
	////////////////////////////////////////////////////////////////////////////
	
	
	
	
	@Autowired
	private SqlSession sqlSession;
	//메인 대시보드 작업
	@RequestMapping("/admin")
	public String admin(Model model){


		System.out.println("관리자 페이지 요청");
		
		//////////////////선형 그래프////////////////////
		
//		ArrayList<Integer> RentalSalesArr =sqlSession.getMapper(AdminImpl.class).getRentalSales();
//		ArrayList<Integer> dailyAuctionSales = sqlSession.getMapper(AdminImpl.class).dailyAuctionSales();
//		System.out.println(RentalSalesArr);
//		System.out.println(dailyAuctionSales);
		ArrayList<String> day = sqlSession.getMapper(AdminImpl.class).getday();
		System.out.println(day);
		
		ArrayList<Integer> dailySales = sqlSession.getMapper(AdminImpl.class).totalSales();
		
//		System.out.println("size:"+RentalSalesArr.size());
//		for(int i=0; i< RentalSalesArr.size(); i++) {
//			for(int j=0; j< dailyAuctionSales.size(); j++) {
//				if(i==j) {					
//					System.out.println("i"+i + "j"+ j);
//					dailySales.add(i, RentalSalesArr.get(i) + dailyAuctionSales.get(j));
//				}
//			}
//		}
		
		System.out.println(dailySales);
		
		model.addAttribute("dailySales", dailySales);
		model.addAttribute("day", day);
		
		
		
		/////////////////금일 주문건수 시작////////////////////////
		int todayRentalCount = sqlSession.getMapper(AdminImpl.class)
				.todayRentalCount();
		System.out.println(todayRentalCount);
		model.addAttribute("todayRentalCount", todayRentalCount);
		
		////////금일 주문건수 끝////////진행중인 경매 시작///////////
		
		int AuctionCount = sqlSession.getMapper(AdminImpl.class)
				.AuctionCount();
		System.out.println(AuctionCount);
		model.addAttribute("AuctionCount", AuctionCount);
		
		////진행중인 경매 종료//////금일 신규 작품 수 시작////////////
		
		int todayUploadArts = sqlSession.getMapper(AdminImpl.class)
				.todayUploadArts();
		System.out.println(todayUploadArts);
		model.addAttribute("todayUploadArts", todayUploadArts);
		
		
		
		/////////////////금일 신규 작품 수 종료////////////////////////
		/////////////////금일 주문건수 종료////////////////////////
		/////////////////금일 주문건수 종료////////////////////////	
		
		///오늘 총 매출
		
		int todaySales = sqlSession.getMapper(AdminImpl.class).todaySales();
		
		model.addAttribute("todaySales", todaySales);				

			
		//입찰마감 임박한 경매 리스트 5개 조회
		try {
			ArrayList<AuctionInfoDTO> terminatingAuctionList
				= sqlSession.getMapper(AdminImpl.class).terminatingAuctionList();
			System.out.println(terminatingAuctionList.toString());
			model.addAttribute("terminatingAuctionList", terminatingAuctionList);
		} catch (Exception e) {
			System.out.println("terminatingAuctionList:예외");
			e.printStackTrace();
		}

		try {
			System.out.println("관리자>작품현황조회 (원형그래프)");
			ArrayList<ArtsDTO> countStatus =
					sqlSession.getMapper(AdminImpl.class).countStatusGroup();
			System.out.println("countStatus:"+countStatus.toString());
			
			model.addAttribute("countStatus", countStatus);
		} catch (Exception e) {
			e.printStackTrace();
		}


		return "admin/index";
	}




	@RequestMapping("/admin/crawler")
	public String crawler() {
		return "admin/crawler";
	}

	public String letsCrawl(Model model, HttpServletRequest req) {

		CrawlerController crawler = new CrawlerController();

		int startNum = Integer.parseInt(req.getParameter("startNum"));
		int endNum = Integer.parseInt(req.getParameter("endNum"));

		crawler.crawl(startNum, endNum);

		return "";
	}

	////////////////////////////////////////////////////

	/////////////////게시판 관리

	////////////////////////////////////////////////////
	@RequestMapping("/admin/board")
	public String admin1(HttpServletRequest req, Model model, ParameterDTO parameterDTO) {		

		System.out.println(parameterDTO.getBname());

		parameterDTO.setSearchField(req.getParameter("searchField"));
		parameterDTO.setSearchTxt(req.getParameter("searchTxt"));
		System.out.println("검색어: " + parameterDTO.getSearchTxt());

		//게시판 타입 지정
		model.addAttribute("bname", parameterDTO.getBname());//게시판 타입 저장
		System.out.println("bname="+ parameterDTO.getBname());
		//전체 게시물 세기
		int totalRecordCount = sqlSession.getMapper(BoardImpl.class)
				.getTotalCount(parameterDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력

		//페이지 처리 설정값
		
		int pageSize = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "csBoard.pageSize"));
		int blockPage = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties","csBoard.blockPage"));
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
		ArrayList<MyBoardDTO> lists = sqlSession.getMapper(BoardImpl.class).listPage(parameterDTO);
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
				(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath() + "/admin/board?bname=" + parameterDTO.getBname() + "&");
		//모델 객체에 저장
		model.addAttribute("params", parameterDTO);
		model.addAttribute("lists", lists);
		model.addAttribute("pagingImg", pagingImg);
		System.out.println("lists: " + lists);		

		if(parameterDTO.getBname().equals("notice")) {
			return "admin/board/notice";

		}else if(parameterDTO.getBname().equals("faq")) {
			return "admin/board/faqlist";
			
		}else if(parameterDTO.getBname().equals("inquiry")) {
			return "admin/board/adminInquiry";
		}

		return "admin/board/notice";
	}


	@RequestMapping("/admin/boardView.do")
	public String boardview(HttpServletRequest req, ParameterDTO parameterDTO,
			MyBoardDTO myBoardDTO, Model model) {


		myBoardDTO = sqlSession.getMapper(BoardImpl.class).view(parameterDTO);

		String temp = myBoardDTO.getContents().replace("\r\n", "<br>");//줄바꿈처리
		myBoardDTO.setContents(temp);
		
		if (myBoardDTO.getReply()!=null) {
		String temp2 = myBoardDTO.getReply().replace("\r\n", "<br>");//줄바꿈처리
		myBoardDTO.setReply(temp2); 
		}
		
		model.addAttribute("params", parameterDTO);
		model.addAttribute("nowPage", req.getParameter("nowPage"));
		model.addAttribute("list", myBoardDTO);


		return "admin/board/boardView";

	}	
	
	@RequestMapping("/admin/boardWrite.do")
	public String boardWrite(HttpServletRequest req, Model model) {

		String bname = req.getParameter("bname");
		
		model.addAttribute("bname", bname);
		
		return "admin/board/boardWrite";
	}


	@RequestMapping(value="/admin/boardWriteAction.do", method=RequestMethod.POST)
	public String boardWriteAction(MyBoardDTO myBoardDTO, HttpServletRequest req,
											Principal principal) {
		
		String memberId = principal.getName();

		String bname = req.getParameter("bname");
		myBoardDTO.setBname(bname);
		myBoardDTO.setMemberId(memberId);
		
		int aff = sqlSession.getMapper(BoardImpl.class).write(myBoardDTO);
		System.out.println(aff);
		
		
		return "redirect:board?bname="+bname;
	}
	

	@RequestMapping("/admin/boardEdit.do")
	public String modifyBoard(HttpServletRequest req, Model model,ParameterDTO parameterDTO, 
							MyBoardDTO myBoardDTO) {

		String idx = req.getParameter("idx");
		
		parameterDTO.setIdx(idx);
		
		myBoardDTO = sqlSession.getMapper(BoardImpl.class).view(parameterDTO);
		
		/* String temp = myBoardDTO.getContents().replace("\r\n", "<br>"); */
		
		/* myBoardDTO.setContents(temp); */
		
				
		model.addAttribute("params", parameterDTO);
		model.addAttribute("nowPage", req.getParameter("nowPage"));
		model.addAttribute("list", myBoardDTO);
		
		return "admin/board/boardEdit";
	}
	
	   @Autowired 
	    JavaMailSenderImpl mailSender;
	   @RequestMapping(value = "/admin/boardEditAction.do", method = RequestMethod.POST)
	   public String boardEditAction(HttpServletRequest req, MyBoardDTO myBoardDTO, Principal principal,
	                           Model model) {
	      
	      String memberId = principal.getName();
	      
	      String bname = req.getParameter("bname");
	      myBoardDTO.setBname(bname);      
	      String from = req.getParameter("from");//보내는 이(관리자) 
	      String to = req.getParameter("to");//받는이(문의한 회원)
	      String title = req.getParameter("title");//제목
	      String contents = "내 문의내용: \n"+ req.getParameter("contents") + "\n 관리자 답변: \n" +req.getParameter("reply"); //내용
	      
	      try { 
	         MimeMessage email = mailSender.createMimeMessage(); 
	         MimeMessageHelper emailHelper = new MimeMessageHelper(email, "UTF-8");
	         
	         emailHelper.setFrom(from); //보내는사람 셋팅
	         emailHelper.setTo(to); // 받는사람 셋팅 
	         emailHelper.setSubject(title); //제목 세팅 
	         emailHelper.setText(contents); //메일 내용 셋팅     
	         
	         mailSender.send(email);//이메일 전송 
	         System.out.println("from:" + from);
	         System.out.println("to: "+ to);
	         System.out.println("mail title: "+ title);
	         System.out.println("mail contents: " + contents);
	      } 
	      catch (Exception e) { 
	         System.out.println(e); 
	      }
	      
	      int edited = sqlSession.getMapper(BoardImpl.class).modify(myBoardDTO);
	      System.out.println("edited post: " + edited);
	      
	      return "redirect:board?bname="+bname;
	   }
		
	@RequestMapping("/admin/delete.do")
	public String delete(HttpServletRequest req, MyBoardDTO myBoardDTO) {
		
		String bname = req.getParameter("bname");
		myBoardDTO.setBname(bname);
		
		sqlSession.getMapper(BoardImpl.class).delete(req.getParameter("idx"));
		

		return "redirect:board?bname=notice";
	}
	
	
	////////////////////////////////////////////////////////////

	///////////렌탈거래리스트

	////////////////////////////////////////////////////////////


	@RequestMapping("admin/rental")
	public String rentaltrans(HttpServletRequest req, Model model,
			ParameterDTO parameterDTO) {


		String paramField = req.getParameter("searchField");
		String searchTxt = req.getParameter("searchTxt");

		//모든 컬럼을 참조해서 전체검색을 하기 위한 where절의 조건
		if(paramField == null || paramField.equals("") ) {
			paramField = 
					" (C.code||C.title||C.memberid||C.name||D.transtype)"; 
		}
		parameterDTO.setSearchField(paramField);
		parameterDTO.setSearchTxt(req.getParameter("searchTxt"));

		//전체 게시물 세기
		int totalRecordCount = sqlSession.getMapper(AdminImpl.class)
				.getTotalCount(parameterDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력		

		//페이지 처리 설정값
		int pageSize = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "csBoard.pageSize"));
		int blockPage = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties","csBoard.blockPage"));

		//전체 페이지 수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		System.out.println(totalPage);
		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println(nowPage);
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		System.out.println("start:"+start);
		System.out.println("end:"+end);
		//위에서 계산한 start,end를 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		model.addAttribute("nowPage", nowPage);

		ArrayList<RentalTransDTO> lists = sqlSession.getMapper(AdminImpl.class).listPage(parameterDTO);
		System.out.println(lists);
		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;

		for(RentalTransDTO dto : lists) {
			//페이지 번호 적용하여 가상번호 계산
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
			System.out.println("상태 :"+dto.getTransType());
		}		

		//페이지 번호 처리(Ajax 사용아님)
		String pagingImg = 
				PagingUtil.pagingArtListForAdmin
				(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath() + "/admin/rental?");
		System.out.println(pagingImg);
		//모델 객체에 저장
		model.addAttribute("lists", lists);
		model.addAttribute("pagingImg", pagingImg);

		return "admin/arts/rentalTrans";
	}
	
	//작품 거래내역(모달창)
	
	@RequestMapping("admin/rental/transList")
	@ResponseBody
	public HashMap<String, Object> transList(HttpServletRequest req, ParameterDTO parameterDTO, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println("transList 진입:"+parameterDTO.getCode());
		
		String paramField = req.getParameter("searchField");
		String searchTxt = req.getParameter("searchTxt");

		//모든 컬럼을 참조해서 전체검색을 하기 위한 where절의 조건
		if(paramField == null || paramField.equals("") ) {
			paramField = 
					" (C.code||C.title||C.memberid||C.name||D.transtype)"; 
		}
		parameterDTO.setSearchField(paramField);
		parameterDTO.setSearchTxt(req.getParameter("searchTxt"));


		//전체 게시물 세기
		int totalRecordCount = sqlSession.getMapper(AdminImpl.class)
				.rentalTransCount(parameterDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력		

		//페이지 처리 설정값
		int pageSize = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "csBoard.pageSize"));
		int blockPage = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties","csBoard.blockPage"));

		//전체 페이지 수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		System.out.println(totalPage);
		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println(nowPage);
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		System.out.println("start:"+start);
		System.out.println("end:"+end);
		//위에서 계산한 start,end를 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);		

		ArrayList<RentalTransDTO> lists = sqlSession.getMapper(AdminImpl.class).rentalList(parameterDTO);
		System.out.println(lists);
		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;

		for(RentalTransDTO dto : lists) {
			//페이지 번호 적용하여 가상번호 계산
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
			
		}		
		
		//페이지 번호 처리(Ajax)
		String pagingImg =
				PagingUtil.pagingAjaxFortransList(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath());
		//모델 객체에 저장
		System.out.println(pagingImg);
		map.put("lists", lists);
		map.put("pagingImg", pagingImg);
		
		
		return map;
	}
	
	//관리자에서 상태 변경시 수행되는 프로세스
	@RequestMapping("admin/rental/insertRT")
	public String insertRT(HttpServletRequest req, RentalTransDTO rentalTransDTO) {
		System.out.println("변경할 상태 :" + rentalTransDTO.getTransType());
		System.out.println("returnDate" + rentalTransDTO.getReturnDate());
		
			
		String status = req.getParameter("transType");
		
		if(req.getParameter("returnD")!=null && !req.getParameter("returnD").equals("")) {
			String date = req.getParameter("returnD");
			System.out.println("date:"+date);

			Date returnDate = Date.valueOf(date);
			rentalTransDTO.setReturnDate(returnDate);		
		}

		
		//rentalTrans테이블에 삽입
		int aff = sqlSession.getMapper(AdminImpl.class).insertRT(rentalTransDTO);
		
		//렌탈가능 -> 렌탈가능으로 수정
		//반납/취소 -> 렌탈준비중
		//렌탈중 -> 렌탈중으로 수정하고 예약내역 삭제
		
		if(status.equals("반납")||status.equals("취소")) {
			status = "렌탈준비중";
			
		}else if(status.equals("렌탈중")) {
			sqlSession.getMapper(AdminImpl.class).deleteBook(rentalTransDTO.getCode());
			
		}
		rentalTransDTO.setTransType(status);
		
		System.out.println("반영될 상태:"+status);
		sqlSession.getMapper(AdminImpl.class).updateStatus(rentalTransDTO);
		System.out.println("arts테이블 상태반영완료");
		

		return "redirect:/admin/rental";
	}

	
	/*
	 * @RequestMapping(value = "admin/rental/modifity", method=RequestMethod.POST)
	 * public String modifyRT(Model model, HttpServletRequest req, RentalTransDTO
	 * rentalTransDTO) {
	 * 
	 * if((req.getParameter("returnD")!=null) &&
	 * !(req.getParameter("returnD").equals(""))) {
	 * 
	 * String date = req.getParameter("returnD"); System.out.println(date);
	 * 
	 * Date returnDate = Date.valueOf(date);
	 * rentalTransDTO.setReturnDate(returnDate); }
	 * 
	 * int aff = sqlSession.getMapper(AdminImpl.class).modifyRT(rentalTransDTO);
	 * System.out.println("렌탈내역 수정된 열 : " + aff);
	 * 
	 * return "redirect:/admin/rental"; }
	 */

	//아이디 중복체크

	@RequestMapping("admin/rental/idCheck")
	@ResponseBody
	public String idCheck(HttpServletRequest req) {

		String memberId = req.getParameter("memberId");
		System.out.println(memberId);
		//http://localhost:8282/alouer/admin/rental/idCheck?memberId=testuser1 

		int aff = sqlSession.getMapper(AdminImpl.class).idCheck(memberId);

		System.out.println(aff);

		String affStr = Integer.toString(aff); 

		return affStr;
	}


	//예약관리
	@RequestMapping("admin/rental/bookingList")
	@ResponseBody
	public Map<String, Object> bookingList(Model model, BookingDTO bookingDTO, HttpServletRequest req) {


		HashMap<String, Object> map = new HashMap<String, Object>();


		String searchTxt = req.getParameter("searchTxt");
		String searchField = req.getParameter("Field");


		String code = req.getParameter("code");
		System.out.println(code);

		bookingDTO.setCode(code);		



		int totalRecordCount = sqlSession.getMapper(AdminImpl.class)
				.getBookCount(bookingDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력		

		//페이지 처리 설정값
		int pageSize = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties", "csBoard.pageSize"));
		int blockPage = Integer.parseInt
				(EnvFileReader.getValue("Inits.properties","csBoard.blockPage"));

		//전체 페이지 수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 
				1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println("nowPage:" + nowPage);
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		System.out.println("start:"+ start);
		System.out.println("end:"+ end);

		//위에서 계산한 start,end를 DTO에 저장
		bookingDTO.setStart(start);
		bookingDTO.setEnd(end);				

		ArrayList<BookingDTO> lists = sqlSession.getMapper(AdminImpl.class).bookListPage(bookingDTO);

		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;

		for(BookingDTO dto : lists) {
			//페이지 번호 적용하여 가상번호 계산
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);

			Timestamp time = dto.getWaitingTime();
			SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

			String to = (String)dateFormat.format(time);

			//DB timestamp 포맷을 JS에서 인식 가능한 포맷으로 변경
			dto.setJsTime(to);		            
		}


		String pagingImg =
				PagingUtil.pagingAjax(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath());

		//모델 객체에 저장
		map.put("lists", lists);				
		map.put("pagingImg", pagingImg);

		return map;
	}
	
	@RequestMapping("admin/rental/bookingModify")
	@ResponseBody
	public String bookingModify(Model model, BookingDTO bookingDTO) {




		return "";
	}


	   //////////////////////////////////////////////////////////////////////
	   
	   //////////////////////////////작품관리////////////////////////////////
	   //작품 관리 리스트
	   @RequestMapping("/admin/arts")
	   public String arts(HttpServletRequest req, Model model) {
	      
	      //파라미터 저장을 위한 DTO객체 생성
	      ParameterDTO parameterDTO = new ParameterDTO();
	      //전체검색용 searchField
	      String paramField = req.getParameter("searchField");
	      
	      //모든 컬럼을 참조해서 전체검색을 하기 위한 where절의 조건
	      if(paramField == null || paramField.equals("") ) {
	         paramField = " (title||name) ";
	      }
	      
	      parameterDTO.setSearchField(paramField);
	      parameterDTO.setSearchTxt(req.getParameter("searchTxt"));
	      
	      
	      //전체 게시물 세기
	      int totalRecordCount = sqlSession.getMapper(AdminImpl.class).getTotalArtsCount(parameterDTO);
	      System.out.println("totalRecordCount: "+totalRecordCount);//콘솔에 출력
	      
	      //페이지 처리 설정값
	      //Inits.properties에 설정한 값을 가져옴
	         int pageSize = Integer.parseInt
	                     (EnvFileReader.getValue("Inits.properties", "admin_ArtList.pageSize"));
	         int blockPage = Integer.parseInt
	                     (EnvFileReader.getValue("Inits.properties","admin_ArtList.blockPage"));
	               
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
	      System.out.println("start:"+parameterDTO.getStart());
	      System.out.println("end:"+parameterDTO.getEnd());      
	      model.addAttribute("nowPage", nowPage);
	      
	      
	      //리스트 페이지에 출력할 게시물 가져오기
	      ArrayList<ArtsDTO> artlist = sqlSession.getMapper(AdminImpl.class).artListPage(parameterDTO);
	      System.out.println("가져온 게시물 수:"+artlist.size());
	      
	      //레코드에 대한 가공 - for문으로 반복
		/*
		 * for(ArtsDTO dto : artlist) { String temp1 = dto.getNote1().replace("\r\n",
		 * "<br>");//줄바꿈처리 String temp2 = dto.getNote2().replace("\r\n", "<br>");//줄바꿈처리
		 * dto.setNote1(temp1); dto.setNote2(temp2); }
		 */
	      
	      //가상번호 virtualNum 적용
	      int virtualNum = 0;
	      int countNum=0;
	
	      for(ArtsDTO dto : artlist) {
	         //페이지 번호 적용하여 가상번호 계산
	         virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
	         dto.setVirtualNum(virtualNum);
	      }      
	      //검색어가 있는경우 파라미터 전달
	      String searchTxt = "";
	      if(req.getParameter("searchTxt")!=null)
	    	  searchTxt = req.getParameter("searchTxt");
	      else
	    	  searchTxt = "";
	    	  
	      
	      //페이지 번호 처리(Ajax 사용아님)
	      String pagingStr = 
	            PagingUtil.pagingArtListForAdmin
	            (totalRecordCount, pageSize, blockPage, nowPage,req.getContextPath() + "/admin/arts?searchTxt="+searchTxt+"&");
	      
	      //모델 객체에 저장
	      model.addAttribute("artlist", artlist);
	      model.addAttribute("pagingStr", pagingStr);
	      
	      
	      return "admin/arts/arts";
	   }     
	
	
	   //작품 등록 처리
	   @RequestMapping(method=RequestMethod.POST, value="/admin/arts/registerAction.do")
	   public String writeAction(HttpSession session, ArtsDTO artsDTO,
	         MultipartHttpServletRequest req) {
	      
	      System.out.println("출력해라 오바");
	      System.out.println("작품가치 : "+artsDTO.getArtValue());
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
//	         String title = req.getParameter("title");
//	         System.out.println("title="+title);
	         
	         /*
	         물리적경로를 기반으로 File 객체를 생성한 후 지정되 디렉토리가 존재하는지 확인함. 
	         만약 없다면 생성함.
	          */
	         File directory = new File(path);
	         if(!directory.isDirectory()) {
	            directory.mkdirs();
	         }
	         
	         //업로드폼의 file속성의 필드갯수만큼 반복
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
//	            String serverFullName2 = new String(path + saveFileName);
	            
	            System.out.println(serverFullName.toString());
	            System.out.println("과정1");
	            //upload 요청명
	            String imageUrl = "upload/" + saveFileName;
	            System.out.println(imageUrl);
	            System.out.println("과정21");
	            mfile.transferTo(serverFullName);
	            System.out.println("과정31");
	            artsDTO.setImageUrl(imageUrl);
	            System.out.println("과정41");
	         }
	         
	      } 
	      catch (IOException e) {
	         e.printStackTrace();
	      }
	      catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      //파일데이터를 모델객체에 저장후 전달
//	      model.addAttribute("returnObj", returnObj);   
	      //입력폼의 정보를 artsDTO에 저장후 전달
	      sqlSession.getMapper(AdminImpl.class).writeAction(artsDTO);
	      System.out.println("과정51");
	      
	      return "redirect:/admin/arts";
	   }

	   
	   

	   //작품 신규 등록 페이지
	   @RequestMapping("/admin/arts/register")
	   public String write(Model model, HttpSession session, HttpServletRequest req) {
	      
	      return "admin/arts/artsRegister";
	   }

	   
	   /*
	   UUID(Universally Unique Identifier)
	      : 범용 고유 식별자. randomUUID() 메소드를 통해 문자열을 생성하면
	      하이픈이 4개 포함된 32자의 랜덤하고 유니크한 문자열이 생성된다.
	      ※ JDK에서 기본적으로 제공되는 클래스임
	    */
	   public static String getUuid() {
	      String uuid = UUID.randomUUID().toString();
	      System.out.println("생성된UUID:"+ uuid);
	      uuid = uuid.replaceAll("-", "");
	      System.out.println("생성된UUID:"+ uuid);
	      
	      return uuid;
	   }
	   
	   
	   
	   //작품 수정 페이지 로드
	   @RequestMapping("/admin/arts/modify")
	   public String modify(Model model, HttpServletRequest req, HttpSession session) {
	      
	      /*
	      여러개의 폼값을 한번에 Mapper쪽으로 전달하기 위해 DTO 객체를 사용한다. 
	      해당 객체는 Mapper에서 즉시 사용할 수 있다.
	       */
	      ParameterDTO parameterDTO = new ParameterDTO();
	      parameterDTO.setCode(req.getParameter("code"));//작품코드
	      
	      //Mybatis 호출시 DTO객체를 파라미터로 전달
	      ArtsDTO artlist = sqlSession.getMapper(AdminImpl.class).modifyAT(parameterDTO);
	      
	      if(artlist.getNote1()!=null && !artlist.getNote1().equals("")) {
	    	  String temp1 = artlist.getNote1().replace("\r\n", "<br>");//줄바꿈처리
	    	  artlist.setNote1(temp1);
	      }
	      
	      if(artlist.getNote2()!=null && !artlist.getNote2().equals("")) {
		      String temp2 = artlist.getNote2().replace("\r\n", "<br>");//줄바꿈처리
		      artlist.setNote2(temp2);	    	  
	      }
	      model.addAttribute("artEdit", artlist);
	      
	      return "admin/arts/artsModify";
	   }
	   
	   
	 //작품 수정 처리
      @RequestMapping(method=RequestMethod.POST, value="/admin/arts/modifyAction.do")
      public String modifyAction(HttpSession session, ArtsDTO artsDTO,
            MultipartHttpServletRequest req) {
         
         System.out.println("출력해라 오바");
         
         //서버의 물리적경로 가져오기
         String path = req.getSession().getServletContext().getRealPath("/resources/upload");
         System.out.println("서버의 물리적경로:"+path);
         
         try {
            //업로드폼의 file속성의 필드를 가져온다.(아래 코드는 다중 파일일 때도 가능한 코드)
            Iterator itr = req.getFileNames();
            String artValueStr = req.getParameter("artValueStr");
            String rentalPriceStr = req.getParameter("rentalPriceStr");
            
            MultipartFile mfile = null;
            String fileName = "";
            List resultList = new ArrayList();
            
            /*
            물리적경로를 기반으로 File 객체를 생성한 후 지정되 디렉토리가 존재하는지 확인함. 
            만약 없다면 생성함.
             */
            File directory = new File(path);
            if(!directory.isDirectory()) {
               directory.mkdirs();
            }
            
            //업로드폼의 file속성의 필드갯수만큼 반복
            while(itr.hasNext()) {
               //전송된 파일의 이름을 읽어온다.
               fileName = (String)itr.next();
               mfile = req.getFile(fileName);
               System.out.println("mfile="+ mfile);
               
               //한글깨짐방지 처리 후 전송된 파일명을 가져옴.
               String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
               
               //서버로 전송된 파일이 없다면 while문을 벗어난다.
               if("".equals(originalName)) { 
                  
                  
                  break; 
               }
             
               
               //파일명에서 확장자 부분을 가져옴
               String ext = originalName.substring(originalName.lastIndexOf('.'));
               //UUID를 통해 생성된 문자열과 확장자를 합침
               String saveFileName = getUuid() + ext;
               //물리적경로에 새롭게 생성된 파일명으로 파일저장
               File serverFullName = new File(path + File.separator + saveFileName);
               
               System.out.println(serverFullName.toString());
               
               //upload 요청명
               String imageUrl = "upload/" + saveFileName;
               System.out.println(imageUrl);
               mfile.transferTo(serverFullName);
                  
               artsDTO.setImageUrl(imageUrl);
            }
            
            System.out.println("여기 출력되나요");
            
            //천단위 콤마 제거 후 int로 형변환         
           int artValue = Integer.parseInt((artValueStr).replaceAll(",", "")); 
           int rentalPrice = Integer.parseInt((rentalPriceStr).replaceAll(",", ""));
         /*
          * int artValue =
          * Integer.parseInt((req.getParameter("artValue")).replaceAll(",", "")); int
          * rentalPrice =
          * Integer.parseInt((req.getParameter("rentalPrice")).replaceAll(",", ""));
          */                      
            System.out.println("artValue:"+artValue);
            System.out.println("rentalPrice:"+rentalPrice);
            
            artsDTO.setArtValue(artValue);
            artsDTO.setRentalPrice(rentalPrice);
            
         } 
         catch (IOException e) {
            e.printStackTrace();
         }
         catch (Exception e) {
            e.printStackTrace();
         }
         
         sqlSession.getMapper(AdminImpl.class).modifyAction(artsDTO);
         
         
         return "redirect:/admin/arts";
      }
	   
	//삭제처리
	@RequestMapping("/admin/arts/deleteAction.do")
	public String deleteAction(HttpServletRequest req, HttpSession session) {
		
		//파라미터 받기
		String imageUrl = req.getParameter("imageUrl");
		String code = req.getParameter("code");
		
		
		
		//서버의 물리적경로 가져오기
		String path = req.getSession().getServletContext().getRealPath("/resources/");
		System.out.println("서버의 물리적경로:"+path);
  
		//파일의 경로 지정
		File file = new File(path + imageUrl); 
		
		//파일이 존재한다면 삭제 처리
		if( file.exists() ) {
			if(file.delete()) { 
				System.out.println("파일삭제 성공"); 
			}
			else{ 
				System.out.println("파일삭제 실패");  
			}
		}
		else { 
			System.out.println("파일이 존재하지 않습니다."); 
		}
		
		//레코드 삭제 처리
		sqlSession.getMapper(AdminImpl.class).deleteAction(code);
		
		return "redirect:/admin/arts";
	}
	   


	//////////////////////////////경매관리////////////////////////////////
	//경매등록리스트
	@RequestMapping("/admin/auction")
	public String auction(Locale locale, Model model, 
			ParameterDTO parameterDTO, HttpServletRequest req) {
		
		logger.info("옥션관리자페이지요청됨. ", locale);

		try {
			
			System.out.println("서치필드:"+parameterDTO.getSearchField());
			System.out.println("검색어:"+parameterDTO.getSearchTxt());
			//1] DB저장값:	2020/08/23 15:23:01.123
			//2] new Date("2020-07-27 18:23:01:000")); //JS에서 파싱할수있는 포맷
			SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
	
			
			int totalAuctionCount = 
					sqlSession.getMapper(AdminImpl.class)
					.getAuctionTotalCount(parameterDTO);
			System.out.println("totalAuctionCount: "+totalAuctionCount);
			
			//페이지 처리를 위한 설정값
			int pageSize = Integer.parseInt(
					EnvFileReader.getValue("Inits.properties","auctionList.pageSize"));
			int blockPage = Integer.parseInt(
					EnvFileReader.getValue("Inits.properties","auctionList.blockPage"));
	
			//전체페이지수 계산
			int totalPage = (int)Math.ceil((double)totalAuctionCount/pageSize);
			//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
			String paramNowPage = req.getParameter("nowPage");
			int nowPage = (paramNowPage==null||paramNowPage.equals("")) ? 
					1 : Integer.parseInt(paramNowPage);
			
			int start = (nowPage-1) * pageSize +1;
			int end = nowPage * pageSize;
			
			//위에서 계산한 start,end를 DTO에 저장
			parameterDTO.setStart(start);
			parameterDTO.setEnd(end);
			System.out.println("start:"+parameterDTO.getStart());
			System.out.println("end:"+parameterDTO.getEnd());
			
			//검색어가 없는경우
			//파라미터 : searchTxt=null => searchTxt=
			if(parameterDTO.getSearchTxt()==null)
				parameterDTO.setSearchTxt("");			

			System.out.println(parameterDTO.toString());

			ArrayList<AuctionInfoDTO> auctionLists = 
					sqlSession.getMapper(AdminImpl.class).auctionListPage(parameterDTO);
			System.out.println("가져온 경매등록정보 수:"+auctionLists.size());
			
			System.out.println("변경된시간출력:");
			for(AuctionInfoDTO dto : auctionLists) {
				//DB timestamp 포맷을 JS에서 인식 가능한 포맷으로 변경
				dto.setFmtStartTime(dateFormat.format( dto.getStartTime()) );
				dto.setFmtEndTime(dateFormat.format( dto.getEndTime()) );
				//System.out.println(dateFormat.format(dto.getEndTime()));
			}
			
			//쿼리 전 저장된 필터값 출력해봄
			System.out.println("parameterDTO.toString():"+parameterDTO.toString());
			//페이지처리부분
			String pagingBtn = PagingUtil.pagingArtListForFilter(
					totalAuctionCount,pageSize,blockPage,nowPage, 
					req.getRequestURI() +"?&searchTxt="+parameterDTO.getSearchTxt()+"&");
			
			
			////////////////////신규작품///////////////////
						
			
			totalAuctionCount = 
					sqlSession.getMapper(AdminImpl.class)
					.getAuctionNewTotalCount(parameterDTO);
			System.out.println("totalAuctionCount: "+totalAuctionCount);
			
			//페이지 처리를 위한 설정값
			/*pageSize = Integer.parseInt(
					EnvFileReader.getValue("Inits.properties","auctionList.pageSize"));*/
			pageSize = 5;
			blockPage = Integer.parseInt(
					EnvFileReader.getValue("Inits.properties","auctionList.blockPage"));
			
			//전체페이지수 계산
			totalPage = (int)Math.ceil((double)totalAuctionCount/pageSize);
			//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
			nowPage = req.getParameter("nowPage")==null ? 1 :
				Integer.parseInt(req.getParameter("nowPage"));
			
			start = (nowPage-1) * pageSize +1;
			end = nowPage * pageSize;
			
			//위에서 계산한 start,end를 DTO에 저장
			parameterDTO.setStart(start);
			parameterDTO.setEnd(end);
			System.out.println("start:"+parameterDTO.getStart());
			System.out.println("end:"+parameterDTO.getEnd());
			
			//검색어가 없는경우
			//파라미터 : searchTxt=null => searchTxt=
			if(parameterDTO.getSearchTxt()==null)
				parameterDTO.setSearchTxt("");
			
			
			//신규작품
			ArrayList<ArtsDTO> newList = 
					sqlSession.getMapper(AdminImpl.class).aucReadyList(parameterDTO);
			
			String pagingBtn2 = PagingUtil.pagingArtListForFilter(
					totalAuctionCount,pageSize,blockPage,nowPage, 
					req.getRequestURI() +"?&searchTxt="+parameterDTO.getSearchTxt()+"&");
			model.addAttribute("newList", newList);
			model.addAttribute("pagingBtn2", pagingBtn2);
			model.addAttribute("pagingBtn", pagingBtn);
			model.addAttribute("lists", auctionLists);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "admin/arts/auction";
	}


	//경매 신규등록
	@RequestMapping("/admin/auction/add")
	public String addAuction(HttpServletRequest req, Locale locale) {
		logger.info("신규경매등록요청됨", locale);
		try {

			//폼값 확인
			Enumeration em = req.getParameterNames();
			while(em.hasMoreElements()) {
				System.out.println(em.nextElement());
			}

			String auctionId = req.getParameter("auctionId");
			String code = req.getParameter("code");
			String startBids = req.getParameter("startBids");
			String startTime = req.getParameter("fmtStartTime");
			String endTime = req.getParameter("fmtEndTime");
			String auctionTotal = req.getParameter("auctionTotal");

			//받은 파라미터 :2020-07-27

			//받은 파라미터 :2020-08-06T21:15
			//DB에 저장할 값 to_timestamp('202008141523 01123', 'YYYYMMDDHH24MISSFF'),


			System.out.println("변경전startTime:"+startTime);
			startTime = (startTime.replace("-", "").replace("T", "").replace(":", ""))+"00000";
			System.out.println("변경후startTime:"+startTime);

			endTime = (endTime.replace("-", "").replace("T", "").replace(":", ""))+"00000";


			AuctionInfoDTO auctionInfoDTO = new AuctionInfoDTO();
			auctionInfoDTO.setAuctionId(auctionId);
			auctionInfoDTO.setCode(code);
			auctionInfoDTO.setStartBids(startBids);
			auctionInfoDTO.setFmtStartTime(startTime);
			auctionInfoDTO.setFmtEndTime(endTime);
			auctionInfoDTO.setAuctionTotal(auctionTotal);

			int affected = sqlSession.getMapper(AuctionDAOImpl.class).addAuction(auctionInfoDTO);
			System.out.println("지분경매등록 결과:"+affected);
			affected = sqlSession.getMapper(AuctionDAOImpl.class).updateArtAuction(auctionInfoDTO);
			System.out.println("작품의status를 지분경매로 변경결과:"+affected);


		} catch (Exception e) {
			e.printStackTrace();
		}
		/*
			System.out.println("URI:"+req.getRequestURI());// /alouer/admin/auction/addAuction
			System.out.println("URL:"+req.getRequestURL());// http://localhost:8080/alouer/admin/auction/addAuction
			System.out.println("getContextPath:"+req.getContextPath());// /alouer
			System.out.println("getServletPath:"+req.getServletPath());// /admin/auction/addAuction
		 */
		//return "redirect:../";
		return "redirect:/admin/auction";//요청명을 보냄 



	}


	//경매 등록정보 조회
	@RequestMapping("/admin/auction/edit")
	public String getAuctionInfo(HttpServletRequest req, 
			Locale locale, ParameterDTO parameterDTO, Model model) {
		logger.info("경매등록정보요청됨", locale);

		//2018-06-14T00:00
		SimpleDateFormat dateFormat = 
				new SimpleDateFormat("YYYY-MM-dd HH:mm");
		String params = "";

		System.out.println("nowPage:"+req.getParameter("nowPage"));
		if(req.getParameter("nowPage")==null)
			params += "&nowPage=1";
		else
			params += "&nowPage="+req.getParameter("nowPage");
		
		
		try {
			System.out.println("auctionId:"+req.getParameter("auctionId"));
			AuctionInfoDTO auctionInfoDTO = 
					sqlSession.getMapper(AuctionDAOImpl.class).getAuctionCodeInfo(req.getParameter("auctionId"));
			System.out.println(auctionInfoDTO.toString());

			//redirect 되면서 저장 사라짐
			req.setAttribute("auctionInfoDTO", auctionInfoDTO);// 
			model.addAttribute("auctionInfoDTO", auctionInfoDTO);//

			//DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경

			// 2020-08-06 04:26 => 2018-06-14T00:00
			String fmtStartTime = dateFormat.format( auctionInfoDTO.getStartTime());
			String fmtEndTime = dateFormat.format( auctionInfoDTO.getEndTime());
			fmtStartTime = fmtStartTime.replace(" ", "T");
			fmtEndTime = fmtEndTime.replace(" ", "T");
			
			auctionInfoDTO.setFmtStartTime(fmtStartTime );
			auctionInfoDTO.setFmtEndTime(fmtEndTime );

			params += "&code="+auctionInfoDTO.getCode();
			params += "&auctionId="+auctionInfoDTO.getAuctionId();
			params += "&startBids="+auctionInfoDTO.getStartBids();
			params += "&fmtStartTime="+auctionInfoDTO.getFmtStartTime();
			params += "&fmtEndTime="+auctionInfoDTO.getFmtEndTime();
			params += "&auctionTotal="+auctionInfoDTO.getAuctionTotal();
			System.out.println("저장한 파라미터정보:"+params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/auction?"+params;//요청명을 보냄 
	}


	//종료된 경매에 대해 입찰내역중 낙찰되지 못한 입찰건에 대해 환불처리 
	//낙찰건 은 경매 등록
	@RequestMapping("/admin/auction/finish")
	public String doFinish(Locale locale, HttpServletRequest req) {
		logger.info("경매완료처리 요청됨", locale);
		/*
		 * 할일 : 
		 * 1. 낙찰외 입찰건 조회 
		 * 2. 해당입찰건의 유저의 depositTb > 환불처리(for문) 1,2번을 PL/SQL로 묶음 처리
		 * 3. stockinfo > 종료된 경매 건의 지분거래 등록
		 * 4. auctioninfo > isfinish : 1 (완료표기)
		 * 5. arts > 해당 작품의 status : 주식거래 로 변경
		 */

		System.out.println("auctionId:"+req.getParameter("auctionId"));

		//환불처리
		int resultOfRefund = 0;
		try {
			//PL/SQL 의 경우 정상처리되면 -1이 반환됨
			resultOfRefund = sqlSession.getMapper(AuctionDAOImpl.class).bidRefund(req.getParameter("auctionId"));

		} catch (Exception e) {
			e.printStackTrace();
		}

		//경매 등록
		if(resultOfRefund==-1)
			try {
				resultOfRefund = 0;
				resultOfRefund = sqlSession.getMapper(AuctionDAOImpl.class).addStock(req.getParameter("auctionId"));

			} catch (Exception e) {
				e.printStackTrace();
			}

		

		return "redirect:/admin/auction?resultOfRefund="+resultOfRefund;//요청명을 보냄 
	}	

	//경매정보 수정
	@RequestMapping("/admin/auction/upDate")
	public String editAuction(Locale locale, AuctionInfoDTO auctionInfoDTO, HttpServletRequest req){
		logger.info("경매수정 요청됨", locale);

		System.out.println("nowPage:"+req.getParameter("nowPage"));
		String params ="";
		if(req.getParameter("nowPage")==null)
			params += "&nowPage=1";
		else
			params += "&nowPage="+req.getParameter("nowPage");
		
		System.out.println(auctionInfoDTO.toString());
		int result = 0;
		try {
			String startTime = auctionInfoDTO.getFmtStartTime();
			String endTime = auctionInfoDTO.getFmtEndTime();

			System.out.println("변경전startTime:"+startTime);
			startTime = (startTime.replace("-", "").replace("T", "").replace(":", ""))+"00000";
			System.out.println("변경후startTime:"+startTime);
			endTime = (endTime.replace("-", "").replace("T", "").replace(":", ""))+"00000";

			auctionInfoDTO.setFmtStartTime(startTime);
			auctionInfoDTO.setFmtEndTime(endTime);
			result = sqlSession.getMapper(AuctionDAOImpl.class).upDateAuction(auctionInfoDTO);


		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return "redirect:/admin/auction?"+params;

	}
	
	@RequestMapping("/admin/auctionView")
	public String auctionView(Locale locale, Model model,HttpServletRequest req, ParameterDTO parameterDTO) {
		logger.info("경매상세보기 요청됨", locale);
		//2020-08-11T04:20
		SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm");
		String auctionId = req.getParameter("auctionId");
		String params = "";
		AuctionInfoDTO auctionInfoDTO = new AuctionInfoDTO();
		
		//경매 등록 정보
		try {
			System.out.println("auctionId:"+req.getParameter("auctionId"));
			
			auctionInfoDTO = 
					sqlSession.getMapper(AuctionDAOImpl.class).getAuctionCodeInfo(auctionId);
			System.out.println(auctionInfoDTO.toString());
			
			//DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경
			auctionInfoDTO.setFmtStartTime(dateFormat.format( auctionInfoDTO.getStartTime()) );
			auctionInfoDTO.setFmtEndTime(dateFormat.format( auctionInfoDTO.getEndTime()) );
			
			model.addAttribute("auctionInfoDTO", auctionInfoDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		
		//페이징 처리
		try {
			parameterDTO.setTableName("au_trans");
			System.out.println("페이지 처리>"+parameterDTO.toString());
			
			int totalRecordCount = 
					sqlSession.getMapper(AuctionDAOImpl.class)
					.getTotalCount(parameterDTO);
			System.out.println("총 입찰수: "+totalRecordCount);
			
			//페이지 처리를 위한 설정값
			int pageSize = Integer.parseInt(
					EnvFileReader.getValue("Inits.properties","auctionList.pageSize"));
			int blockPage = Integer.parseInt(
					EnvFileReader.getValue("Inits.properties","auctionList.blockPage"));
			System.out.println("pageSize:"+pageSize+" blockPage:"+blockPage);
			//전체페이지수 계산
			int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
			//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
			int nowPage = req.getParameter("nowPage")==null ? 1 :
				Integer.parseInt(req.getParameter("nowPage"));
			
			int start = (nowPage-1) * pageSize +1;
			int end = nowPage * pageSize;
			
			
			//입찰 리스트
			try {
				
				
				parameterDTO.setStart(start);
				parameterDTO.setEnd(end);
				
				ArrayList<AuTransDTO> bidlist = 
						sqlSession.getMapper(AuctionDAOImpl.class).bidList(parameterDTO );
				
				for(AuTransDTO dto : bidlist) {
					dto.setFmtAuctionTime(dateFormat.format( dto.getAuctionTime()) );
					
				}
				System.out.println("입찰정보:"+bidlist.toString());
				model.addAttribute("bidlist", bidlist);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//페이지 번호에 대한 처리 
			String pagingBtn = PagingUtil.pagingArtListForAdmin(
					totalRecordCount,pageSize,blockPage,nowPage, 
					req.getRequestURI() +"?auctionId="+auctionId+"&");
			model.addAttribute("pagingBtn", pagingBtn);//페이지 버튼
			
		} catch (Exception e) {
			System.out.println("페이징처리예외발생");
			e.printStackTrace();
		}
		
		
		return "admin/arts/auctionView";	

	}
	
	///////////////////////경매관리 끝///////////////////////////////
	

	
	////////////////////////////////////////////////////////////////////////////
	
	//////////////매출관리
	
	////////////////////////////////////////////////////////////////////////////
	
	//입찰마감 임박한 경매 현황
	public Model terminatingAuctionList(Model model) {
		System.out.println("[관리자컨트롤러]입찰마감 임박한 경매 현황 조회");
		try {
			
			ArrayList<AuctionInfoDTO> terminatingAuctionList
				= sqlSession.getMapper(AdminImpl.class).terminatingAuctionList();
			
			model.addAttribute("terminatingAuctionList", terminatingAuctionList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
		
	}
}

