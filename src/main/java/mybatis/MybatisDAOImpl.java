package mybatis;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
//게시판 전용이다 인터페이스

@Service
public interface MybatisDAOImpl {

	/*
	방명록 리스트에서 사용할 추상메소드를 정의함
	아래 추상메소드를 통해 컨트롤러는 Mapper의 각 엘리먼트를 호출하게 된다.
	 */
	//검색기능 추가전
//	public int getTotalCount();
//	public ArrayList<MyBoardDTO> listPage(int s, int e);
	
	//검색기능 추가후 : 파라미터를 저장한 DTO를 매개변수로 받음
	public int getTotalCount(BoardParameterDTO boardparameterDTO);
	public ArrayList<MyBoardDTO> listPage(BoardParameterDTO boardparameterDTO);
	
	//뷰카운트(hits) 증가
	public void hits(int idx);
	
	
	/*
	방명록 글쓰기
	파라미터 전달시 Mapper에서 즉시 사용할 이름을 지정하고 싶을 때 @Param
	어노테이션을 사용한다. 아래와 같이 지정하면 Mapper에서 
	#{_name}과 같이 사용할 수 있다.
	*/
	public int write(String title, String contents, String memberId, String bname);
	
	//상세보기 로딩하기
	public MyBoardDTO view(BoardParameterDTO boardparameterDTO);
	
	//수정폼 로딩하기
	public MyBoardDTO modifyform(BoardParameterDTO boardParameterDTO);
	
	 
	//수정처리하기
	public int modify(MyBoardDTO myBoardDTO);

	//삭제처리
	public int delete(String idx, String memberId);

	
	
	
	
}



















