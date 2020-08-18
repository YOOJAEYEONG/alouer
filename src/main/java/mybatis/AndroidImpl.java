package mybatis;

import org.springframework.stereotype.Service;

@Service
public interface AndroidImpl {

	//로그인
	MemberVO memberLoginCheckMethod(MemberVO memberVO);

	
}
