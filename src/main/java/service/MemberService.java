 

package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.MemberVO;


public interface MemberService {
	
	
	//아이디 중복 체크
	public int idCheck(String userId);
	
	
}




