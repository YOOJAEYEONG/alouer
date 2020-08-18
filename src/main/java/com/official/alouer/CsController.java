package com.official.alouer;


import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mybatis.MemberVO;
import mybatis.MyBoardDTO;
import mybatis.MybatisDAOImpl;
import mybatis.BoardImpl;
import mybatis.ParameterDTO;
import mybatis.BoardParameterDTO;
import smtp.SMTPAuth;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class CsController {
	
	@Autowired
	private SqlSession sqlSession;
	

	//FAQ는 아코디언을 쓰므로 뷰 페이지가 별도로 있지 않다
	//리스트 요청명
	@RequestMapping(value="/cs/board.do", method=RequestMethod.GET)
	public String faqlist(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {
		
		//boardparameterDTO.setSearchField(req.getParameter("searchField"));
		//boardparameterDTO.setSearchTxt(req.getParameter("searchTxt"));
		System.out.println("검색어: " + parameterDTO.getSearchTxt());
		
		//게시판 타입 지정
		String bname = req.getParameter("bname");
		parameterDTO.setBname(bname);//bname을 "faq"로 설정한다		
		
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
		
		
		
		//리스트 페이지에 출력할 게시물 가져오기
		ArrayList<MyBoardDTO> lists = sqlSession.getMapper(BoardImpl.class).listPage(parameterDTO);
		System.out.println("lists"+ lists);
		
		//레코드에 대한 가공 - for문으로 반복
		for(MyBoardDTO dto : lists) {
			String temp = dto.getContents().replace("\r\n", "<br>");//줄바꿈처리
			dto.setContents(temp);
		}
		
		//가상번호 virtualNum 적용
		int virtualNum = 0;
		int countNum=0;
		
		for(MyBoardDTO dto : lists) {
			//페이지 번호 적용하여 가상번호 계산
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
		}				
		
		//페이지 번호 처리(검색어 타입과 검색어도 url에 추가한다) 
		//검색어가 있을 때 다음 페이지에 가도 검색어 파라미터가 사라지지 않는다 
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath() 
												+ "/cs/board.do?bname=" + bname 
												+ "&searchField="+parameterDTO.getSearchField()
												+ "&searchTxt=" + parameterDTO.getSearchTxt() + "&");
		
		//검색어 없을때의 페이징 처리
		String pagingImg2 =  PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath()
												+ "/cs/board.do?bname=" + bname + "&"); 
		
		
		
		//모델 객체에 저장
		model.addAttribute("lists", lists);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("pagingImg2", pagingImg2);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("params", parameterDTO);
		
		//print in console
		System.out.println("totalPage=" + totalPage);
		System.out.println("bname="+ parameterDTO.getBname());
		System.out.println("memberid="+parameterDTO.getMemberId());
		System.out.println("idx=" + parameterDTO.getIdx());
		System.out.println("search field:" + parameterDTO.getSearchField());
		System.out.println("search text:" + parameterDTO.getSearchTxt());
		System.out.println("\n");
		
		if(bname.equals("faq")) {
			return "cs/faqlist";
			
		}else if(bname.equals("notice")) {
			return "cs/notice";
			
		}else {
			//1:1은 리스트 id가 세션에 있는 id랑 같은 게시물만 호출해야하는데, 
			//이부분은 myPage에 떠야할 것 같음
				
			return "redirect:mypage";
		}
		
	}

	// 게시물 상세보기
	@RequestMapping(value="/cs/boardView.do", method=RequestMethod.GET)
	public String view(Principal principal, Model model, HttpSession session, HttpServletRequest req, 
											ParameterDTO parameterDTO, BoardParameterDTO boardparameterDTO) {				
//		String bname = req.getParameter("bname");
		String bname = boardparameterDTO.getBname();
		
		String nowPage = req.getParameter("nowPage");
		
		model.addAttribute("nowPage", nowPage);		

		
		//가상번호 적용		
		sqlSession.getMapper(BoardImpl.class).hits((boardparameterDTO.getIdx()));		
		

		MyBoardDTO lists = sqlSession.getMapper(BoardImpl.class).view(parameterDTO);
				
		
		//1:1은 리스트를 id = sessionid로 매퍼 따로 만들어서 작업해야 할 것(매퍼에 if문 쓰던지?)
		
		lists.setContents(lists.getContents().replaceAll("\r\n", "<br/>"));
			
		
		//내용 줄바꿈 처리
		
		//model에 저장
		model.addAttribute("list", lists);
		model.addAttribute("params", boardparameterDTO);
		
		//console
		System.out.println("idx:" + boardparameterDTO.getIdx());
		
		System.out.println("nowpage:" + nowPage);
		System.out.println("memberid:" + lists.getMemberId());
		System.out.println("contents: " + lists.getContents());
		
		if(bname.equals("notice")) {
			return "cs/boardView";
		}else {
			return "redirect:login.do";
		}
	}

	//글쓰기 폼 로딩
	@RequestMapping(value="/cs/write.do", method=RequestMethod.GET)
	public String write(Model model, HttpSession session, HttpServletRequest req, BoardParameterDTO boardparameterDTO) {
		
		//글쓰기 페이지로 진입시 세션영역에 데이터가 없다면 로그인 페이지로 이동
		//관리자만 작성 가능
		//if(session.getAttribute("siteUserInfo")==null) {
			
		//	return "redirect:login.do";
		//}

		String bname = boardparameterDTO.getBname();//작성할 보드의 bname 가져오기
		
		model.addAttribute("params", boardparameterDTO);
		
		//작성자의 아이디 콘솔에서 확인하기	
		System.out.println("memberid:" + boardparameterDTO.getMemberId());

				
		return "cs/WritingForm";
	}
	
	//게시물 쓰기처리(action)	
	@RequestMapping(value = "/cs/writeAction.do", method = RequestMethod.POST)
	public String writeAction(Model model, HttpServletRequest req, HttpSession session, BoardParameterDTO boardparameterDTO) {
		
		//String bname = boardparameterDTO.getBname();
		
		//세션영역에 사용자정보가 있는지 확인
		/*
		if(session.getAttribute("siteUserInfo")==null) {
			//로그인이 해제된 상태라면 로그인 페이지로 이동한다
			return "redirect:login.do";
		}

		sqlSession.getMapper(BoardImpl.class).write(

				req.getParameter("title"),
				req.getParameter("contents"),
				req.getParameter("memberId"),
				boardparameterDTO.getBname()
				);
		*/


		

		//글작성이 완료되면 리스트로 이동한다
		return "redirect:board.do?bname="+boardparameterDTO.getBname();
	}
	
	//FAQ게시판 수정(수정폼 로드하기)
	
	/*
	 * @RequestMapping("/CS/modify.do") public String modify(Model model,
	 * HttpServletRequest req, HttpSession session, BoardParameterDTO
	 * boardparameterDTO) {
	 * 
	 * //글쓰기 페이지로 진입시 세션영역에 데이터가 없다면 로그인 페이지로 이동 //관리자만 작성 가능
	 * //if(session.getAttribute("siteUserInfo")==null) {
	 * 
	 * // return "redirect:login.do"; //} String bname =
	 * boardparameterDTO.getBname();//게시판 타입가져오기
	 * boardparameterDTO.setIdx(boardparameterDTO.getIdx());//일련번호
	 * boardparameterDTO.setMemberId(((MemberVO)session.getAttribute("siteUserInfo")
	 * ).getMemberId());
	 * 
	 * //내용 불러오기 MyBoardDTO lists =
	 * sqlSession.getMapper(BoardImpl.class).view(boardparameterDTO);
	 * 
	 * //model에 저장 model.addAttribute("list", lists); model.addAttribute("params",
	 * boardparameterDTO);
	 * 
	 * //console System.out.println("idx:" + boardparameterDTO.getIdx());
	 * System.out.println("memberid:" + lists.getMemberId());
	 * 
	 * //수정폼 로딩 return "cs/modifyForm"; }
	 */
	
	//FA수정ㅊ
	@RequestMapping("/cs/modifyAction.do")
	public String modifyAction(HttpSession session, MyBoardDTO myBoardDTO) {
		
		/*
		 * if(session.getAttribute("siteUserInfo")==null) {
		 * 
		 * return "redirect:login.do"; }
		 */
		//커맨드객체로 폼값을 한번에 받아서 Mapper로 전달함
		int applyRow = sqlSession.getMapper(BoardImpl.class).modify(myBoardDTO);
		System.out.println("수정처리 된 레코드 수: " + applyRow);
		
		return "redirect:board.do";
	}
	//FAQ 게시판 삭제처리
	@RequestMapping("/cs/delete.do")
	public String delete(HttpServletRequest req, HttpSession session) {
		
		/*
		if(session.getAttribute("siteUserInfo")==null) { return "redirect:login.do";
		}
		sqlSession.getMapper(BoardImpl.class).delete(
				req.getParameter("idx"),
				((MemberVO)session.getAttribute("siteUserInfo")).getMemberId());
		
		
		*/
		
		String bname = req.getParameter("bname");
		
		sqlSession.getMapper(BoardImpl.class).delete(
				req.getParameter("idx"));
		
		if(bname.equals("faq")) {
			return "cs/faqlist";
			
		}else if(bname.equals("notice")) {
			return "cs/notice";
			
		}else {
			//1:1은 리스트 
			return "redirect:mypage";
		}
	}
		
	
	//쓰기처리 폼 보기
	@RequestMapping("/cs/writeformView")
	public String seeform(Model model) {
		return "cs/writeForm";
	}
	
	
	//이메일 보내기 빈 가져오기
	@Autowired 
    JavaMailSenderImpl mailSender;
  
    //이메일 폼 로드
    @RequestMapping(value = "/cs/mailSending.do", method=RequestMethod.GET)
    public String mailFormGet() {
	    return "cs/emailSend";
    }  
  
	//회원에게 답변 이메일 보내기
  
  	@RequestMapping(value = "/cs/mailSending.do", method=RequestMethod.POST) 
  	public String mailSending(HttpServletRequest req) {
  		String from = "jjeong1992@naver.com";//보내는 이 
		String to = "jjeongjackie@gmail.com";//받는이
		String title = req.getParameter("mailtitle");//제목
		String contents = req.getParameter("mailcontents"); //내용
  
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
	  		System.out.println("title: "+ title);
	  		System.out.println("contents: " + contents);
		} 
		catch (Exception e) { 
  				System.out.println(e); 
		}  
		return "redirect:inquiry.do;";//이메일 보낸 후에는 1:1 문의 홈으로 간다 	
  	}
	
	

//////////////////////////////////////////////아래는 쓰이지 않는 컨트롤러임///////////////////////////////////////////////	

}//컨트롤러의 끝