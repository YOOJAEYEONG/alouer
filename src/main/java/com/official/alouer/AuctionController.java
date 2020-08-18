package com.official.alouer;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.function.Consumer;
import java.util.function.Predicate;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.xpath.operations.Mod;
import org.openqa.selenium.json.JsonOutput;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import mybatis.ArtDAOImpl;
import mybatis.ArtsDTO;
import mybatis.AuTransDTO;
import mybatis.AuctionDAOImpl;
import mybatis.AuctionInfoDTO;
import mybatis.DepositTbDTO;
import mybatis.MemberVO;
import mybatis.ParameterDTO;
import util.ArtList;
import util.EnvFileReader;

@Controller
public class AuctionController {

	@Autowired
	private SqlSession sqlSession;
	LocalDateTime currentTime = LocalDateTime.now();
	// 1] DB저장값: 2020/08/23 15:23:01.123
	// 2] new Date("2020-07-27 18:23:01:000")); //JS에서 파싱할수있는 포맷
	SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss:SSS");
	//SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm");

	// 경매리스트페이지
	@RequestMapping("/auction")
	public String auctionList(Model model, HttpServletRequest req,
			ParameterDTO parameterDTO) {
		System.out.println("[AutionController]:auction()===============");

		// 1.작품들을 가져옴
		new ArtList().getArtList(sqlSession, model, req, parameterDTO);

		try {
			//검색된 작품리스트를 가져옴
			ArrayList<String> auctionCodeList = (ArrayList<String>) req.getAttribute("list");
			System.out.println("리스트의 작품코드:"+auctionCodeList);
			final ArrayList<AuctionInfoDTO> auctionInfoList = 
					sqlSession.getMapper(AuctionDAOImpl.class).getTotalAuctionInfo(auctionCodeList);
			System.out.println("getTotalAuctionInfo결과 옥션갯수:"+auctionInfoList.size());
			
			//한작품에 여러개의 경매등록이 있을 경우 중복제거및 최근의 경매 정보만 저장한다.
			final HashMap<String, AuctionInfoDTO> au_map = new HashMap<String, AuctionInfoDTO>();
			auctionInfoList.forEach( new Consumer<AuctionInfoDTO>(){
				@Override
				public void accept(AuctionInfoDTO t) {
					System.out.println("변경전"+t.toString());
					au_map.put(t.getCode(), t);
				}
			});
			
			System.out.println("au_map:"+au_map.keySet());
			auctionInfoList.clear();//중복제거된 데이터를 넣기위해 clear
			//빈 list 객체에 다시 삽입
			au_map.values().forEach(new Consumer<AuctionInfoDTO>() {
				@Override
				public void accept(AuctionInfoDTO t) {
					System.out.println("변경후:"+t.toString());
					auctionInfoList.add(au_map.get(t.getCode()));
				}
			});
			System.out.println("auctionInfoList:"+auctionInfoList);
	
		
			//각각 경매물건의 최소 낙찰 가능 값을 저장함
			auctionInfoList.forEach(new Consumer<AuctionInfoDTO>() {
				@Override
				public void accept(AuctionInfoDTO dto) {
					int minPrice = 0;
					try {
						minPrice = sqlSession.getMapper(AuctionDAOImpl.class)
								.getMinPrice(dto.getAuctionId());
						dto.setMinPrice(minPrice);
					} catch (Exception e) {
						System.out.println("예외:최소낙찰가를 구하지 못함>시작가로 셋팅");
						dto.setMinPrice(Integer.parseInt(dto.getStartBids()));
						//e.printStackTrace();
					}
					System.out.println("최소낙찰가:"+dto.getMinPrice());
				}
			});	
		
		
			
			System.out.println(auctionInfoList.toString());
			model.addAttribute("auctionInfoList", auctionInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return "auction/list";
	}

	// 상세보기
	@RequestMapping("/auction/view.do")
	public String auctionView(Model model, ParameterDTO parameterDTO,
			HttpServletRequest req, Principal principal) {
		System.out.println(	"[AutionController]:auctionView()=====================");
		System.out.println("parameterDTO.toString:" + parameterDTO.toString());

		int balance = 0;
		// 로그인 안 해도 게시물을 볼 수 있도록 처리
		try {
			if (principal != null) {
				model.addAttribute("memberId", principal.getName());
				System.out.println("로그인중인아이디:" + principal.getName());
				// 현재 접속한 회원의 예치금을 가져옴
				balance = sqlSession.getMapper(AuctionDAOImpl.class)
						.getBalance(principal.getName());
				System.out.println("balance:" + balance);
				model.addAttribute("balance", balance);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 작품정보 가져오기
		ArtsDTO artsDTO = sqlSession.getMapper(AuctionDAOImpl.class)
				.getAuctionView(parameterDTO);
		System.out.println("artsDTO:" + artsDTO);

		
		//작품이미지 경로 처리
		//크롤링한 이미지 URL경로가 아닌, 업로드한 이미지일 경우 아래와 같이 경로 처리 필수.
	  	if(!artsDTO.getImageUrl().startsWith("http")) {
	  		artsDTO.setImageUrl("/alouer/" + artsDTO.getImageUrl());
	    }
	  	

		// 내용에 대해 줄바꿈 처리
		String temp1 = artsDTO.getNote1().replace("\r\n", "<br>");
		artsDTO.setNote1(temp1);
		String temp2 = artsDTO.getNote2().replace("\r\n", "<br>");
		artsDTO.setNote2(temp2);

		String edu = sqlSession.getMapper(ArtDAOImpl.class)
				.eduinfo(parameterDTO);

		// 해당 물건의 경매 정보 가져오기
		AuctionInfoDTO auctionInfoDTO = sqlSession
				.getMapper(AuctionDAOImpl.class).getAuctionInfo(parameterDTO);
		System.out.println("auctionInfoDTO:" + auctionInfoDTO);

		if(auctionInfoDTO!=null) {
			// 옥션수량보다 입찰횟수가 적은경우 낙찰최저가 계산에 예외가 떨어져서 시작가로 초가화.
			int minPrice = 0;
			try {
				if(!auctionInfoDTO.getStartBids().equals("")){
					System.out.println("낙찰 가능한 최소 금액을 조회");
					minPrice = sqlSession.getMapper(AuctionDAOImpl.class)
							.getMinPrice(auctionInfoDTO.getAuctionId());
					System.out.println("낙찰 가능한 최소 금액:" + minPrice);
					auctionInfoDTO.setMinPrice(minPrice);// 입찰가 중 가장 낮은 낙찰가
				}
			
			} catch (Exception e) {
				System.out.println("[예외발생]:옥션수량보다 입찰수가 적은경우, 낙찰최저가 계산에 예외가 떨어져서 시작가로 적용함");
				System.out.println(e.getMessage());
				auctionInfoDTO.setMinPrice(Integer.parseInt(auctionInfoDTO.getStartBids()));
			}
			// 입찰내역이 하나도 없을경우 가져올게 없기때문에 에러방지
			try {
				// 경매종료시간이 현재보다 과거일때 : 경매가 이미끝났을때
				if (auctionInfoDTO.getEndTime().toLocalDateTime()
						.isBefore(currentTime)) {
					System.out.println("경매아이디:" + auctionInfoDTO.getAuctionId());
					// 이 경매물의 낙찰자들을 가져온다................................
					ArrayList<AuTransDTO> auctionResult = showThisAuctionResult(
							auctionInfoDTO.getAuctionId());
					System.out.println("가져온낙찰리스트:" + auctionResult.toString());
					model.addAttribute("auctionResult", auctionResult);
				}

			} catch (Exception e) {
				System.out.println("예외:입찰내역이 하나도 없을 경우 가져올 게 없기 때문에 에러방지");
				e.printStackTrace();
			}
			
			System.out.println(
					"포맷변경됨:" + dateFormat.format(auctionInfoDTO.getEndTime()));
			// DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경
			auctionInfoDTO
					.setFmtEndTime(dateFormat.format(auctionInfoDTO.getEndTime()));
		}

		model.addAttribute("artsDTO", artsDTO);
		model.addAttribute("edu", edu);
		model.addAttribute("auctionInfoDTO", auctionInfoDTO);

		return "auction/view";
	}

	// 입찰 처리
	@RequestMapping("/auction/view/bid")
	@ResponseBody
	public Map<Integer, String> biddingLogic(Model model,
			DepositTbDTO depositTbDTO, AuTransDTO auTransDTO,
			HttpServletRequest req) {
		System.out.println(
				"[AutionController]:biddingLogic()=======================");

		Map<Integer, String> map = new HashMap<Integer, String>();
		String totalPrice = req.getParameter("totalPrice");// 입찰수량 * 입찰가격
		System.out.println("totalPrice:" + totalPrice);
		String title = req.getParameter("title");
		System.out.println("title" + title);
		try {
			// 회원의 예치금 잔고를 가져온다
			int valance = sqlSession.getMapper(AuctionDAOImpl.class)
					.getBalance(req.getParameter("memberId"));
			// 회원의 예치금 정보를 불러와서 예치금보다 입찰금이 적은지 검사
			if (valance < Integer.parseInt(totalPrice)) {
				map.put(0, "예치금이 부족합니다.");
			} else {
				System.out.println("auTransDTO:" + auTransDTO.toString());
				int affected = sqlSession.getMapper(AuctionDAOImpl.class)
						.putBid(auTransDTO);
				System.out.println("입찰처리결과:" + affected); // 성공후 -1 반환됨

				if (affected == -1) {
					System.out
							.println("depositTbDTO:" + depositTbDTO.toString());
					// 입찰했던 지분수 * 1주당가격을 셋팅
					depositTbDTO.setWithdraw(
							auTransDTO.getLot() * auTransDTO.getBidsPrice());

					depositTbDTO.setHistory(title + " 경매 입찰");
					// 입찰에 성공하면 사용자의 예치금을 차감
					affected = sqlSession.getMapper(AuctionDAOImpl.class)
							.setBalance(depositTbDTO);
					System.out.println("예치금처리결과:" + affected);
					if (affected == 1) {
						map.put(1, "입찰 되었습니다.");
						// 예치금 잔고를 가져옴
						int newBalance = sqlSession
								.getMapper(AuctionDAOImpl.class)
								.getBalance(depositTbDTO.getMemberId());
						map.put(2, Integer.toString(newBalance));
					} else
						map.put(1, "입찰 실패했습니다.");

				} else {
					System.out.println("입찰실패:" + affected);
					map.put(0, "실패 하였습니다.");
				}
			}
		} catch (Exception e) {
			System.out.println("시스템예외발생");
			e.printStackTrace();
		}
		return map;
	}

	// 상세보기페이지에서 실시간 입찰현황
	@RequestMapping("/auction/view/bidListing")
	@ResponseBody
	public ArrayList<AuTransDTO> bidListing(HttpServletRequest req,
			ParameterDTO parameterDTO) {
		// System.out.println("[AutionController]:bidListing()=======================");
		// System.out.println("auctionId:"+req.getParameter("auctionId"));


		// 실시간 입찰현황판
		ArrayList<AuTransDTO> bidlist = null;
		try {
			parameterDTO.setTableName("au_trans");

			// ArtListMapper 참고
			int totalRecordCount = sqlSession.getMapper(AuctionDAOImpl.class)
					.getTotalCount(parameterDTO);
			// System.out.println("totalRecordCount: "+totalRecordCount);

			// 페이지 처리를 위한 설정값
			int pageSize = Integer.parseInt(EnvFileReader
					.getValue("Inits.properties", "auctionList.pageSize"));
			int blockPage = Integer.parseInt(EnvFileReader
					.getValue("Inits.properties", "auctionList.blockPage"));

			// 전체페이지수 계산
			int totalPage = (int) Math
					.ceil((double) totalRecordCount / pageSize);
			// 현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
			int nowPage = req.getParameter("nowPage") == null
					? 1
					: Integer.parseInt(req.getParameter("nowPage"));

			int start = (nowPage - 1) * pageSize + 1;
			int end = nowPage * pageSize;
			parameterDTO.setTableName("au_trans");
			parameterDTO.setNowPage(Integer.toString(nowPage));
			parameterDTO.setStart(start);
			parameterDTO.setEnd(end);

			String auctionId = req.getParameter("auctionId");
			// System.out.println(parameterDTO.toString());
			bidlist = sqlSession.getMapper(AuctionDAOImpl.class)
					.bidList(parameterDTO);
			// System.out.println("입찰현황수:"+bidlist.size());

			for (AuTransDTO dto : bidlist) {
				dto.setFmtAuctionTime(dateFormat.format(dto.getAuctionTime()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bidlist;
	}

	// 상세보기페이지에서 실시간 낙찰현황
	@RequestMapping("/auction/view/currentAuction")
	@ResponseBody
	public ArrayList<AuTransDTO> currentAuction(HttpServletRequest req,
			ParameterDTO parameterDTO) {
		System.out.println("[AutionController]:currentAuction()=======================");
		//System.out.println("auctionId:"+req.getParameter("auctionId"));

		// 실시간 입찰현황판
		ArrayList<AuTransDTO> bidlist = null;
		try {
			parameterDTO.setTableName("au_trans");
				
			// ArtListMapper 참고
			int totalRecordCount = sqlSession.getMapper(AuctionDAOImpl.class)
					.getTotalCount(parameterDTO);
			// System.out.println("totalRecordCount: "+totalRecordCount);

			// 페이지 처리를 위한 설정값
			int pageSize = Integer.parseInt(EnvFileReader
					.getValue("Inits.properties", "auctionList.pageSize"));
			int blockPage = Integer.parseInt(EnvFileReader
					.getValue("Inits.properties", "auctionList.blockPage"));

			// 전체페이지수 계산
			int totalPage = (int) Math
					.ceil((double) totalRecordCount / pageSize);
			// 현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
			int nowPage = req.getParameter("nowPage") == null
					? 1
					: Integer.parseInt(req.getParameter("nowPage"));

			int start = (nowPage - 1) * pageSize + 1;
			int end = nowPage * pageSize;
			parameterDTO.setTableName("au_trans");
			parameterDTO.setNowPage(Integer.toString(nowPage));
			parameterDTO.setStart(start);
			parameterDTO.setEnd(end);

			// System.out.println(parameterDTO.toString());
			bidlist = sqlSession.getMapper(AuctionDAOImpl.class)
					.currentAuction(parameterDTO);
			//System.out.println("경매현황:" + bidlist.size());

			/*
			int sum = 0;
			int auctionTotal = Integer.parseInt(req.getParameter("auctionTotal"));
			System.out.println("auctionTotal:"+req.getParameter("auctionTotal"));
			for(AuTransDTO dto : bidlist) {
				if(sum < auctionTotal)
					sum += dto.getLot();
				else
					dto.setLot(0);
			}
			*/
			 
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bidlist;
	}

	// 경매가 끝나고 [마이페이지]에서 낙찰현황을 조회하는 경우
	public ArrayList<AuTransDTO> showMyAuctionResult(Model model,
			ParameterDTO parameterDTO) {
		System.out.println(
				"[AutionController]:showMyAuctionResult()=======================");

		ArrayList<AuTransDTO> auctionResult = null;
		try {

			// 접속 아이디를 통해 회원이 갖고있는 경매 입찰내역중 낙찰된 레코드들을 반환
			auctionResult = sqlSession.getMapper(AuctionDAOImpl.class)
					.getMyAuctionResult(parameterDTO);

			for (AuTransDTO dto : auctionResult) {
				// DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경
				dto.setFmtAuctionTime(dateFormat.format(dto.getAuctionTime()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("auctionResult", auctionResult);
		return auctionResult;
	}

	// 경매가 끝나고 작품상세보기시 낙찰현황을 보여줌
	public ArrayList<AuTransDTO> showThisAuctionResult(String auctionId) {
		System.out.println(
				"[AutionController]:showThisAuctionResult()=======================");
		System.out.println("auctionId:" + auctionId);

		ArrayList<AuTransDTO> auctionResult = null;
		try {
			// 해당 작품의 auctionid를 통해 경매 입찰내역중 낙찰된 레코드들을 반환
			auctionResult = sqlSession.getMapper(AuctionDAOImpl.class)
					.getThisAuctionResult(auctionId);

			for (AuTransDTO dto : auctionResult) {
				// DB 시간 포맷을 JS에서 인식 가능한 포맷으로 변경
				dto.setFmtAuctionTime(dateFormat.format(dto.getAuctionTime()));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return auctionResult;
	}

	// 예치금충전할때 로그인된 사용자의 정보를 가져옴
	@RequestMapping("/auction/view/getMemberInfo")
	@ResponseBody
	public MemberVO getMemberInfo(Principal principal, MemberVO memberVO) {
		System.out.println("getMemberInfo()=====================");

		try {
			System.out.println("memberId:" + principal.getName());
			memberVO = sqlSession.getMapper(AuctionDAOImpl.class)
					.getMemberInfo(principal.getName());
			System.out.println("memberVO:" + memberVO.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberVO;
	}

	// 결제api 결제 성공 후 예치금 충전처리
	@RequestMapping("/auction/view/deposit")
	@ResponseBody
	public Map<Integer, String> depositOrWithDraw(DepositTbDTO depositTbDTO,
			Model model) {
		System.out.println("depositOrWithDraw()===================");
		// 결과코드,내용
		Map<Integer, String> map = new HashMap<Integer, String>();
		/*
		 * depositTbDTO에전달된 값:DepositTbDTO(idx=null, memberId=test@alouer.com,
		 * withdraw=0, deposit=500, balance=0, history=null)
		 */
		System.out.println("depositTbDTO에전달된 값:" + depositTbDTO.toString());

		// 처음 입금시 예치금 테이블이 null일경우가 있다
		try {
			int checkBalance = sqlSession.getMapper(AuctionDAOImpl.class)
					.getBalance(depositTbDTO.getMemberId());
			System.out.println(
					"예치금 입력전 테이블에 존재유무 검사(checkBalance):" + checkBalance);

		} catch (Exception e) {
			// 그러면 예외가 발생하는대 이때 0값을 입력함.
			int ret = sqlSession.getMapper(AuctionDAOImpl.class)
					.newBalance(depositTbDTO.getMemberId());
			System.out.println("신규계좌 " + (ret == 1 ? "생성됨" : "생성실패"));
			e.printStackTrace();
		}

		try {

			depositTbDTO.setHistory("예치금입금");
			int affected = sqlSession.getMapper(AuctionDAOImpl.class)
					.setBalance(depositTbDTO);
			System.out.println("setBalance결과:" + affected);
			if (affected == 1 && depositTbDTO.getDeposit() > 0) {
				map.put(1, "입금처리 완료되었습니다.");
				int newBalance = sqlSession.getMapper(AuctionDAOImpl.class)
						.getBalance(depositTbDTO.getMemberId());
				model.addAttribute("newBalance", newBalance);
				map.put(2, Integer.toString(newBalance));
				System.out.println("newBalance:" + newBalance);
			}
			if (affected == 1 && depositTbDTO.getWithdraw() > 0) {
				map.put(1, "출금처리 완료되었습니다.");
			}
			if (affected == 0) {
				map.put(0, "서버내 에러발생");
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put(0, e.getMessage());
		}
		return map;
	}

	
}























