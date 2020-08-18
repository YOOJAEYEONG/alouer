package com.official.alouer;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.gargoylesoftware.htmlunit.javascript.host.Console;

import login.kakao_restapi;
import mybatis.AuctionDAOImpl;
import mybatis.MemberImpl;
import mybatis.MemberVO;
import mybatis.MybatisDAOImpl;
import mybatis.ParameterDTO;
import service.MemberService;


@Controller
public class MemberController {

	@Autowired
	SqlSession sqlSession;

	@RequestMapping("/member")
	public String mypage() {

		return "member/list";
	}

	/*
	 * @RequestMapping("/member/loginAction") public String
	 * loginAction(HttpServletRequest req) {
	 * System.out.println("[컨트롤러]loginAction"); return "/main"; }
	 */

	@RequestMapping("/member/signUp")
	public String memberSignUp() {
		return "/member/signUp";
	}

	@RequestMapping("/member/findAccount")
	public String memberFindAccount() {

		return "/member/findAccount";
	}

	@RequestMapping("/member/accessDenied.do")
	public String accessDenied() {

		return "member/accessDenied";
	}
	@RequestMapping("/member/D")
	public String accessD() {
		
		return "member/accessDenied";
	}

	///////////////////////////////////////////////////////////
	// 위에는 기존에 있었던 내용 아래부터 작업 - 박성일
	///////////////////////////////////////////////////////////

	// 내비바(navijsp)에서 login버튼을 눌렀을 때 실행 - view/login.jsp로 이동
	@RequestMapping("/member/login")
	public String memberLogin(Authentication authentication, ParameterDTO parameterDTO, HttpServletRequest req) {
		System.out.println("memberLogin컨트롤러호출됨");			
		
		if (authentication != null) {
			System.out.println(authentication.getName());// 아이디
			System.out.println(authentication.getAuthorities().toString());// ROLE_ADMIN
		}
		if (parameterDTO.getBackURL() != null) {
			
			return "redirect:" + parameterDTO.getBackURL();
		}
		return "member/login";
	}



	
	// 내비바(navijsp)에서 join버튼을 눌렀을 때 실행 - view/member/register.jsp로 이동
	@RequestMapping("/member/join")
	public String join() {

		return "member/register";
	}

	// login 페이지에서 비밀번호찾기 버튼을 눌렀을 때 실행 - view/member/find.jsp로 이동
	@RequestMapping("/member/find")
	public String find() {

		return "member/find";
	}

	// 회원가입 (View/member/register.jsp에서 가입하기 눌렀을 때 실행)
	@RequestMapping("/member/register/join.do")
	public String memberJoin(HttpServletRequest req, Model model) {

		System.out.println("join.do 들어옴");
		MemberVO dto = new MemberVO();
		String userId = req.getParameter("email1") + "@" + req.getParameter("email2");
		dto.setMemberId(userId);
		dto.setPass(req.getParameter("password1"));
		sqlSession.getMapper(MemberImpl.class).memberJoinMethod(dto);
		
		//신규회원 가입시 예치금 계좌 신설 잔고 0원 적용
		//처음 입금시 예치금 테이블이 null 이므로  
		try {
			int checkBalance = sqlSession.getMapper(AuctionDAOImpl.class).getBalance(userId);
			System.out.println("예치금 입력전 테이블에 존재유무 검사(checkBalance):"+checkBalance);
			
		} catch (Exception e) {
			//그러면 예외가 발생하는대 이때 0값을 입력함.
			int ret = sqlSession.getMapper(AuctionDAOImpl.class).newBalance(userId);
			System.out.println("신규계좌 "+( ret==1? "생성됨":"생성실패"));
			e.printStackTrace();
		}
		
		
		return "redirect:/";
	}

	//이메일 중복체크(View/member/register.jsp에서 중복체크 눌렀을 때 실행 ajax)
	@RequestMapping(value = "/member/register/idCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdCheck(HttpServletRequest req, Model model) {

		System.out.println("idCheck.do 들어옴");
		MemberVO dto = new MemberVO();
		String userId = req.getParameter("userId");
		dto.setMemberId(userId);
		int memExist = sqlSession.getMapper(MemberImpl.class).memExist(dto);

		// 아무것도 입력하지 않을 경우에도 0을 반환하기 때문에 if문 추가
		if (userId.equals("@")) {
			System.out.println("입력 안 됨");
			return "11";
		}
		return Integer.toString(memExist);
	}

	
	
	
	@RequestMapping(value="/member/memInfo.do", method=RequestMethod.GET)
	@ResponseBody
	public HashMap<String, MemberVO> memInfo(MemberVO memberVO) {
		
		HashMap<String, MemberVO> map = new HashMap<String, MemberVO>();
		
		System.out.println("중복체크");
				
		MemberVO mVO = new MemberVO();
		
		try {
			
			mVO = sqlSession.getMapper(MemberImpl.class).MemberInfoMethod(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		 
		map.put("memberVO", mVO);
		return map;
	}

	
	
	
	
	   //카카오톡 관련 로그아웃 메소드
	    @RequestMapping("kakao_logout.do")
	    public String kakao_logout(HttpSession session, HttpServletRequest request) {
	        
	        //세션에 담긴값 초기화
	        session.invalidate();
	        
	        return "/";
	    }   



}
