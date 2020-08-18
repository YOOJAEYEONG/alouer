package util;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestScope;

import mybatis.ArtDAOImpl;
import mybatis.ArtsDTO;
import mybatis.ParameterDTO;

public class ArtList {

	


	//필터들을 저장함
	private static String staticThemeFlt = ""; 
	private static String staticColorFlt = "";
	private static String staticSizeFlt = "셋팅전:호";
	private static String staticShapeFlt = "";
	private static String staticPriceFlt = "셋팅전:만";		
	private static String staticStatusFlt = "";
	private static String staticOrderByPrice = "";
	private String page="";
	
	final Map<String,String> SHAPE_FILTER = new HashMap<String, String>();
	
	/* artlists 에 담긴 ArtsDTO 갯수 만큼 지분경매 페이지에서
	 * 해당 code의 경매정보를 가져오기 위해 전역변수로 설정함,
	 * 이 함수내에서는 경매,거래관련 로직을 추가하지 않기위함,
	 * 해당로직은 경매 컨트롤러에서 별도으로 기술, 이를 위해 
	 * 외부에서 반환받을 수 있는    
	*/
	ArrayList<ArtsDTO> artlists;
	
	//선택한 값을 임시 저장변수
	private static String selectFilter = "";
	

 	final String priceFilterResolver= " AND rentalprice ";
 	final Map<String,String> SIZE_FILTER = new HashMap<String,String>();
 	final List<String> PRICE_FILTER = new ArrayList<String>();
	
	//어느 페이지에서든 이 메소드를 호출하면 model객체에 페이지 번호와 작품리스팅을 반환한다
	public Model getArtList(
			SqlSession sqlSession, 
			Model model,
			HttpServletRequest req, 
			ParameterDTO parameterDTO){
		

		System.out.println("요청명:" + req.getRequestURI());
		
		if(((String)req.getRequestURI()).contains("rental")) {
			page = "렌탈";
		}else if(((String)req.getRequestURI()).contains("auction")) {
			page = "경매";
		}else {
			page = "쇼룸";
		}
		parameterDTO.setPage(page);

		PRICE_FILTER.add(" 0 AND 30000 ");
		PRICE_FILTER.add(" 30000 AND 50000 ");
		PRICE_FILTER.add(" 50000 AND 100000 ");
		PRICE_FILTER.add(" 100000 AND 200000 ");
		PRICE_FILTER.add(" 200000 AND 300000 ");
		PRICE_FILTER.add(" 300000 AND 500000 ");
		PRICE_FILTER.add(" 500000 AND 1000000 ");
		PRICE_FILTER.add(" >= 1000000 ");
		
		SIZE_FILTER.put("5",  " OR sizeHo BETWEEN 0 AND 5 ");
		SIZE_FILTER.put("10", " OR sizeHo BETWEEN 6 AND 10 ");
		SIZE_FILTER.put("20", " OR sizeHo BETWEEN 11 AND 20 ");
		SIZE_FILTER.put("30", " OR sizeHo BETWEEN 21 AND 30 ");
		SIZE_FILTER.put("40", " OR sizeHo BETWEEN 31 AND 40 ");
		SIZE_FILTER.put("60", " OR sizeHo BETWEEN 41 AND 60 ");
		SIZE_FILTER.put("80", " OR sizeHo BETWEEN 61 AND 80 ");
		SIZE_FILTER.put("120"," OR sizeHo BETWEEN 81 AND 120 ");
		SIZE_FILTER.put("150"," OR sizeHo > 150 ");
		
		SHAPE_FILTER.put("정사각형", 	" OR width = height ");
		SHAPE_FILTER.put("가로형", 		" OR width > height ");
		SHAPE_FILTER.put("세로형", 		" OR height > width ");
		
		
		//서버에 저장된 필터값 출력해봄
		showInfoServerFlters();
		
		/*
		필터 한개를 클릭하면 여기로 넘어오기때문에 
		나머지 선택하지 않은 값은 null이 된다.
		 */
		System.out.println("선택한값:"+parameterDTO.getSelectedVal());
		showInfoDTOFlters(parameterDTO);
		
		//아래에서 연속적으로 사용하기때문에  초기화
		selectFilter = "";
		
		
		
		//필터링
		if(parameterDTO.getSelectedVal() != null) {
			selectFilter = parameterDTO.getSelectedVal();
			
			System.out.println("필터링시작");
	
			String theme = "인물,풍경,정물,동물,상상,추상";
			String color = "빨강,파랑,초록,노랑,파스텔,흑백,기타";
			String size = "5호,10호,20호,30호,40호,60호,80호,120호,150호";
			String shape = "정사각형,가로형,세로형,세트";
			if(theme.contains(selectFilter)) {
				System.out.println("테마필터실행");
				staticThemeFlt = saveOrDelete(staticThemeFlt,selectFilter);
				parameterDTO.setFltTheme(staticThemeFlt); 
			}
			else if(color.contains(selectFilter)) {
				System.out.println("컬러필터실행");
				staticColorFlt = saveOrDelete(staticColorFlt,selectFilter);
				parameterDTO.setFltColor(staticColorFlt); 
			}
			//검색 가능한 별도 로직필요
			else if(size.contains(selectFilter)) {
				System.out.println("크기필터실행");
				staticSizeFlt = saveOrDelete_Size(staticSizeFlt,selectFilter);
				parameterDTO.setFltSize(staticSizeFlt); 
			}
			//검색 가능한 별도 로직필요
			else if(shape.contains(selectFilter)) {
				System.out.println("형태필터실행");
				staticShapeFlt = saveOrDelete_Shape(staticShapeFlt,selectFilter);
				parameterDTO.setFltShape(staticShapeFlt); 
			}
			else if(PRICE_FILTER.contains(selectFilter)) {
				System.out.println("가격필터실행");
				System.out.println("staticPriceFlt:"+staticPriceFlt);
				staticPriceFlt = saveOrDelete_Price(staticPriceFlt,selectFilter);
				parameterDTO.setFltPrice(staticPriceFlt); 
				System.out.println("가격필터 출력:"+staticPriceFlt);
			}else {
				System.out.println("해당필터가 없음");
			}
		}
		
		
		
		//렌탈가능/낮은가격순/경매가능만 보기
		if(parameterDTO.getQuickChk()!=null) {
			selectFilter = parameterDTO.getQuickChk();
			
			//체크박스 체크여부에따라  true/false 값이 들어온다. 
			if(selectFilter.equals("fltRentalfalse")) {
				System.out.println("렌탈가능:OFF");
				staticStatusFlt = "";
			}else if(selectFilter.equals("fltRentaltrue")){
				System.out.println("렌탈가능:ON");
				staticStatusFlt = "렌탈가능";
			}
			
			if(selectFilter.equals("fltOrderByPricefalse")) {
				System.out.println("낮은가격순:OFF");
				staticOrderByPrice = "";
			}else if(selectFilter.equals("fltOrderByPricetrue")) {
				System.out.println("낮은가격순:ON");
				staticOrderByPrice = "fltOrderByPrice";
			}
			
			if(selectFilter.equals("fltShowAuctiontrue")) {
				System.out.println("지분경매가능만보기ON");
				staticStatusFlt = "지분경매";
			}else if(selectFilter.equals("fltShowAuctionfalse")) {
				System.out.println("지분경매가능만보기OFF");
				staticStatusFlt = "";
			}
			
			if(selectFilter.equals("fltShowStocktrue")) {
				System.out.println("지분거래가능만보기ON");
				staticStatusFlt = "지분거래";
			}else if(selectFilter.equals("fltShowStockfalse")) {
				System.out.println("지분거래가능만보기OFF");
				staticStatusFlt = "";
			}
			
		}

	
		
		//[필터제거시]
		if(parameterDTO.getFltDelete()!=null) {
			selectFilter = parameterDTO.getFltDelete();
			removeFilterALL();
		}
	
		//쿼리 전 최종 필터링 값을 입력함
		parameterDTO.setFltTheme(staticThemeFlt);
		parameterDTO.setFltColor(staticColorFlt);
		parameterDTO.setFltShape(staticShapeFlt);
		if(!staticPriceFlt.contains("셋팅전")) 
			parameterDTO.setFltPrice(staticPriceFlt);
		else
			parameterDTO.setFltPrice("");
		if(!staticSizeFlt.contains("셋팅전")) 
			parameterDTO.setFltSize(staticSizeFlt);
		else
			parameterDTO.setFltSize("");
		parameterDTO.setFltOrderByPrice(staticOrderByPrice);
		parameterDTO.setFltStatus(staticStatusFlt);
		if(parameterDTO.getSearchTxt()==null)
			parameterDTO.setSearchTxt("");
		
		//쿼리 전 저장된 필터값 출력해봄
		showInfoDTOFlters(parameterDTO);
		
		//ArtListMapper 참고
		int totalRecordCount = 
				sqlSession.getMapper(ArtDAOImpl.class)
				.getTotalCount(parameterDTO);
		System.out.println("totalRecordCount: "+totalRecordCount);
		
		
		//페이지 처리를 위한 설정값
		int pageSize = Integer.parseInt(
				EnvFileReader.getValue("Inits.properties","showRoom_ArtList.pageSize"));
		int blockPage = Integer.parseInt(
				EnvFileReader.getValue("Inits.properties","showRoom_ArtList.blockPage"));
		
		//전체페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 1 :
			Integer.parseInt(req.getParameter("nowPage"));
		
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		//위에서 계산한 start,end를 DTO에 저장
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		System.out.println("start:"+parameterDTO.getStart());
		System.out.println("end:"+parameterDTO.getEnd());
		
		//리스트 페이지에 출력할 게시물 가져오기
		artlists = sqlSession.getMapper(ArtDAOImpl.class).listPage(parameterDTO);
		System.out.println("가져온 계시물 수:"+artlists.size());
		System.out.println("게시물의 정보:"+artlists.toString());
	
		//가져온 작품들을 ArrayList<ArtsDTO> req영역에 저장
		getArtList(req);
		
		//페이지 번호에 대한 처리 
		/*
		 * req.getRequestURI() => /alouer/showroom/art
		/showroom/art.do? 하드코딩 되어있는것을 
		여러 페이지에 맞게 리스트 띄우려면 변수처리해야함
		 */
		String pagingBtn = PagingUtil.pagingArtListForFilter(
				totalRecordCount,pageSize,blockPage,nowPage, 

				req.getRequestURI() +"?&searchTxt="+parameterDTO.getSearchTxt()+"&");

		DecimalFormat format = new DecimalFormat("###,###,###,###");
		//레코드에 대한 가공을 위해 for문으로 반복
		for(ArtsDTO dto : artlists) {
			if(dto.getNote1()!=null && !dto.getNote1().equals("")) {
				String note1 = dto.getNote1().replace("\r\n", "<br>");
				dto.setNote1(note1);
			}
			if(dto.getNote2()!=null && !dto.getNote2().equals("")) {
			String note2 = dto.getNote2().replace("\r\n", "<br>");
			dto.setNote2(note2);			
			}
			//5500000 => 5,500,000
			String artValueFormat = format.format(dto.getArtValue());
			String rentalPriceFormat = format.format(dto.getRentalPrice());
				
			//System.out.println("이미지 URL"+dto.getImageUrl());//정상출력됨
			dto.setArtValueFormat(artValueFormat);
			dto.setRentalPriceFormat(rentalPriceFormat);
		}
		
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("pagingBtn", pagingBtn);//페이지 버튼
		model.addAttribute("artlists", artlists);//작품리스트
		model.addAttribute("theme_Flt",staticThemeFlt);
		model.addAttribute("color_Flt",staticColorFlt);
		model.addAttribute("price_Flt",changeValPrice(staticPriceFlt));
		model.addAttribute("shape_Flt",changeValShape(staticShapeFlt));
		model.addAttribute("size_Flt",changeValSize(staticSizeFlt));
		model.addAttribute("fltOrderByPrice",staticOrderByPrice);
		model.addAttribute("fltStatus",staticStatusFlt);
		return model;
	}

	// n번째 페이지에서 가져온 작품들의 code를  조립해서 경매 컨트롤러등 외부로 리턴함
	public void getArtList(HttpServletRequest req) {
		final ArrayList<String> list = new ArrayList<String>();
		
		artlists.forEach( new Consumer<ArtsDTO>() {
			@Override
			public void accept(ArtsDTO dto) {
				list.add(dto.getCode());
			}
		});	
		req.setAttribute("list", list);
	}



	private String changeValPrice(String _staticPriceFlt) {
		System.out.println("changeValPrice()==========");
		System.out.println("_staticPriceFlt:"+_staticPriceFlt);
		/*
		서버에 저장한 값을 뷰에서 판단할 수 있도록 
		뷰의 각 엘리먼트의 value 값으로 변환해줌
		 */
		String s = _staticPriceFlt;
		s = s.replace(priceFilterResolver, "");
		
		System.out.println("changeValPrice()처리결과:"+s);
		return s;
	}
	

	// " AND width = height " => "정사각형"
	private Object changeValShape(String _staticShapeFlt) {

		System.out.println("changeValShape===========");
		System.out.println("_staticShapeFlt:"+_staticShapeFlt);
	
		Iterator<Map.Entry<String,String>> itrEntry = 
				(Iterator<Entry<String, String>>) SHAPE_FILTER.entrySet().iterator();
		while(itrEntry.hasNext()) {
			Map.Entry<String, String> entry = (Map.Entry<String, String>) itrEntry.next();
			
			_staticShapeFlt = _staticShapeFlt.replace(entry.getValue(), entry.getKey());
			
		}
		
		return _staticShapeFlt;
	}
	
	
	/*
	해당필터를 뷰에서 사용할 value속성값으로 치환하는 함수
	 AND sizeHo BETWEEN 81 AND 120 = > 120
	 */
	public String changeValSize(String _staticSizeFlt) {
		System.out.println("changeValSize()진입==========");
		System.out.println("_staticSizeFlt:"+_staticSizeFlt);
		
		//기존에 서버에 저장된 필터중에서 현재 선택된 필터가 있으면..제거
		Iterator<Map.Entry<String,String>> itrEntry = 
				(Iterator<Entry<String, String>>) SIZE_FILTER.entrySet().iterator();
		while(itrEntry.hasNext()) {
			Map.Entry<String, String> entry = (Map.Entry<String, String>) itrEntry.next();
			
			_staticSizeFlt = _staticSizeFlt.replace(entry.getValue(), entry.getKey()+"호");
			
		}
		
		System.out.println("changeValSize()결과:"+_staticSizeFlt);
		return _staticSizeFlt;
	}

	private void removeFilterALL() {
		System.out.println("필터리셋버튼클릭됨");
		staticThemeFlt 	= ""; 
		staticColorFlt 	= "";
		staticSizeFlt 	= "셋팅전:호";
		staticShapeFlt 	= "";
		staticPriceFlt 	= "셋팅전:만";
		staticOrderByPrice ="";		
		staticStatusFlt ="";
	}


	private String saveOrDelete_Shape(String filter,String _selectFilter) {
		
		System.out.println("saveOrDelete_Shape():진입===========");
		System.out.println("filter:"+filter+"\n_selectFilter:"+_selectFilter);
		
		
		if(filter.contains(SHAPE_FILTER.get(_selectFilter))) {
			System.out.println("기존필터내역이 있음(filter):"+filter);
			filter = filter.replace(SHAPE_FILTER.get(_selectFilter), "");
			System.out.println("처리결과:"+filter);
		}else {
			filter += SHAPE_FILTER.get(_selectFilter);
			System.out.println("필터 추가됨(filter):"+filter);
		}
		return filter;
	}
	
	private String saveOrDelete_Price(String filter,String _selectFilter) {
		System.out.println("saveOrDelete_Price():진입===========");
		
		//delete
		if(filter.contains(_selectFilter)) {
			System.out.println("체크된 항목 제거:"+_selectFilter);
			
			filter = filter.replace(" OR rentalprice BETWEEN "+_selectFilter, "");
			filter = filter.replace(" OR rentalprice "+_selectFilter, "");
			System.out.println("기존에 존재한 필터이므로 제거함, 처리결과:"+filter);
			return filter;
		//save
		}else {
			System.out.println("가격필터추가진입");
			System.out.println("추가할 필터값:"+_selectFilter);
			System.out.println("서버에 저장되어있는 필터:"+filter);
			if(filter.indexOf("만")!= -1) {
				//처음저장하는 경우 filter 값이 '셋팅전:만' 
				//이기때문에 값을 비우고 시작함
				filter = "";
				System.out.println("filter비움");
			}
			if(_selectFilter.contains(" >= 1000000 ")) {
				filter += " OR rentalprice "+_selectFilter;		
			}else {
				filter += " OR rentalprice BETWEEN "+_selectFilter;				
			}
			System.out.println("필터에 저장된 값:"+filter);
			return filter;
		}
	}
	
	private String saveOrDelete_Size(String filter, String _selectFilter) {
		System.out.println("saveOrDelete_Size():진입=====");
		
		System.out.println("filter:"+filter+"\n_selectFilter:"+_selectFilter);
		//20호 => 20
		_selectFilter = _selectFilter.replace("호", "");
		//만약 저장하려고 하는데 기존에 이미 있는 경우는 해당 값을 제거한다
		if(filter.contains(_selectFilter)) {
			System.out.println("체크된 항목 제거:"+_selectFilter);
			return filter.replace(SIZE_FILTER.get(_selectFilter), "");
		}else {
			return addSizeFilter(filter,_selectFilter);				
		}
	}
	
	private String saveOrDelete(String filter, String _selectFilter) {
		System.out.println("saveOrDelete():진입=====");
		
		System.out.println("filter:"+filter+"\n_selectFilter:"+_selectFilter);
		//만약 저장하려고 하는데 기존에 이미 있는 경우는 해당 값을 제거한다
		if(filter.contains(_selectFilter)) {
			System.out.println("체크된 항목 제거:"+_selectFilter);
			return removeFilter(filter, _selectFilter);
		}else {
			return addFilter(filter, _selectFilter);
		}
	}


	// 필터를 선택한경우 필터 변수에 추가
	private String addFilter(String filter, String _selectFilter) {
		System.out.println("addFilter() 진입=======");
		System.out.println("저장대상필터:"+filter);
		System.out.println("저장할 필터값:"+_selectFilter);
		
		//기존에 저장된 없이 ""이면 지금 저장하는 값이 처음저장하는값이다
		if(filter.equals("")) {
			filter += ("'"+_selectFilter+"'");
			System.out.println("필터에 처음 저장된 값:"+filter);
		}else {
			filter += (",'"+_selectFilter+"'");
			System.out.println("기존필터에 추가함:"+filter);
		}
		return filter;
	}
	
	
	private String addSizeFilter(String filter, String _selectFilter) {
		System.out.println("addSizeFilter() 진입=======");
		System.out.println("저장대상(filter):"+filter);
		System.out.println("저장할 필터값(_selectFilter):"+_selectFilter);
		
		
		if(filter.contains("셋팅전")) {
			filter = "";
			System.out.println("필터에 처음 저장하는 경우이므로 필터를 비움 filter:"+filter);
		}
		if(_selectFilter.contains("호")){
			//예)30호 => 30
			_selectFilter = _selectFilter.replace("호", "");
		}
		filter += SIZE_FILTER.get(_selectFilter);
		System.out.println("기존필터에 추가함:"+filter);
		
		return filter;
	}
	
	
	public void showInfoServerFlters() {
		System.out.println("showInfoFlters():실행========");
		System.out.println("staticThemeFlt:"+staticThemeFlt);
		System.out.println("staticColorFlt:"+staticColorFlt);
		System.out.println("staticSizeFlt:"+staticSizeFlt);
		System.out.println("staticShapeFlt:"+staticShapeFlt);
		System.out.println("staticPriceFlt:"+staticPriceFlt);
		System.out.println("staticStatusFlt:"+staticStatusFlt);
		System.out.println("staticOrderByPrice:"+staticOrderByPrice);
	}
	
	public void showInfoDTOFlters(ParameterDTO parameterDTO) {
		System.out.println("showInfoDTOFlters():실행===========");
		/*
		 * System.out.println("getFltTheme:"+parameterDTO.getFltTheme());
		 * System.out.println("getFltColor:"+parameterDTO.getFltColor());
		 * System.out.println("getFltPrice:"+parameterDTO.getFltPrice());
		 * System.out.println("getFltShape:"+parameterDTO.getFltShape());
		 * System.out.println("getFltSize:"+parameterDTO.getFltSize());
		 * System.out.println("getFltDelete:"+parameterDTO.getFltDelete());
		 * System.out.println("getFltStatus:"+parameterDTO.getFltStatus());
		 * System.out.println("getFltOrderByPrice:"+parameterDTO.
		 * getFltOrderByPrice());
		 * System.out.println("getSearchField:"+parameterDTO.getSearchField());
		 * System.out.println("getSearchTxt:"+parameterDTO.getSearchTxt());
		 */
		System.out.println(parameterDTO.toString());
		
	}
	
	
	//필터를 제거하는 함수
	private String removeFilter(String filter, String _selectFilter) {
		System.out.println("removeFilter()진입=====");
		System.out.println("themeFlt 필터의 제거 요청값은:"+_selectFilter);
		
		int index = filter.indexOf("'"+_selectFilter+"'");
		//저장된 문자열 중 첫번째값인경우
		if(index == 0) {
			System.out.println("저장된 문자열 중 첫번째값임");
			filter = filter.replace("'"+_selectFilter+"',", "");				
			filter = filter.replace("'"+_selectFilter+"'", "");				
		}else {
			filter = filter.replace(",'"+_selectFilter+"'", "");
		}
		System.out.println("처리결과:"+filter);				
		return filter;
		
	}
	
}
