package mybatis;

import java.sql.Date;

import lombok.Data;

@Data 
public class MemberVO {

    private String memberId;	//회원아이디 이메일
    private String authority;	//권한 ROLE_ADMIN : 관리자, ROLE_USER : 일반회원
    private int enabled;		//계정 활성화 여부
    private String pass;		//비밀번호
    private String name;		//이름
    private String hp;			//핸드폰 번호
    private String address;		//주소
    private Date birth;			//생년월일
    private String subscribe;	//문자수신여부
    private String edu;			//교육사항1(작가)
    private String history;		//이력(작가)
    private String commentory;	//
    

}

