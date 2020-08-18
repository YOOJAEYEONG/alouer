package com.official.alouer;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mybatis.AndroidImpl;
import mybatis.MemberVO;

@Controller
public class AndroidController {

	@Autowired
	private SqlSession sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@ResponseBody
	@RequestMapping("/android/memberSign")
	public Map<String, Object> signInUp(HttpServletRequest req, MemberVO memberVO, Locale locale) {
		logger.info("로그인요청됨", locale);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		System.out.println("memberId:"+memberVO.getMemberId()+"\npass:"+memberVO.getPass());
		MemberVO memberInfo = 
				sqlSession.getMapper(AndroidImpl.class).memberLoginCheckMethod(memberVO);
		
		if(memberInfo==null) {
			returnMap.put("resultCode", false);
		}else {			
			returnMap.put("resultCode", true);
			returnMap.put("memberInfo", memberInfo);
		}
		return returnMap;
	}
}
