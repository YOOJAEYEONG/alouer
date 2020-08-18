<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!doctype html>
<html lang="en">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypagelist2.css">

<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>마이 페이지</title>

</head>
<style>
th {
	text-align: center;
}

.inquiry-Button {
	float: right;
	display: block;
	width: 200px;
	height: 40px;
	border: 0;
	outline: 0;
	margin: 16px;
	background-color: #222;
	font-size: 14px;
	color: #fff;
	transition: opacity 0.1s ease-in-out mar
}

.myModify-inner:before {
	content: '';
	position: absolute;
	width: 54px;
	height: 54px;
	top: 50%;
	left: 0;
	-webkit-transform: translateY(-50%);
	-ms-transform: translateY(-50%);
	transform: translateY(-50%);
	background:
		url('${pageContext.request.contextPath}/resources/img/member/alouer.png')
		no-repeat;
	background-size: 54px 54px
}

#my_account_body.orders table.order_list td {
	border-bottom: 1px solid #eee;
	border-right: 1px solid #eee;
	text-align: center;
	background-color: #fff;
	padding: 0 5px;
}

#countdown, #HourCountdown, #countExpire {
	display: inline;
	color: blue;
	font-weight: bold;
}
</style>
<script>
window.onload = function() {  
	var text1 = $('#lastTime').val();
	console.log(${lastTime });
	console.log(text1);
	
}
</script>
<body>

	<div id="contents" data-login_required="true">
		<section class="pageHead" id="my_account_head">
			<div class="pageHead-bar"></div>
			<h2 class="pageHead-title">마이페이지</h2>
			<div class="pageHead-description">고객님과 관련된 정보입니다.</div>
		</section>
		<section id="myModify">
			<div class="myModify-inner">
				<h3 id="myModify-name">
					<sec:authentication property="principal.username" />
					<span>님, 반갑습니다.</span>
				</h3>
				<a href="${pageContext.request.contextPath}/mypage/modify/"
					onclick="ga_clk_account('account_modify');">
					<div class="myModify-btn">
						<p>회원정보수정</p>
					</div>
				</a>
			</div>
		</section>
		        <nav id="myAccountNav" class="cf">
            <a href="${pageContext.request.contextPath}/mypage/rental" class="myAccountNav-btn" onclick="ga_clk_account('account_orders');">나의 렌탈</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/art" class="myAccountNav-btn" onclick="ga_clk_account('account_gifts');">관심 목록</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/auction" class="myAccountNav-btn current" onclick="ga_clk_account('account_contacts');">지분 경매</a>
            <a href="${pageContext.request.contextPath}/mypage/deposit" class="myAccountNav-btn" onclick="ga_clk_account('account_points');">예치금 관리</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/stock" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 거래</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/revenue" class="myAccountNav-btn " >나의 수익</a>
            <a href="${pageContext.request.contextPath}/mypage/inquiry/inquiryList" class="myAccountNav-btn " >1:1 문의하기</a>
<c:if test="${mVO.authority eq 'ROLE_ARTIST'}">
            <a href="${pageContext.request.contextPath}/showroom/art/artistview.do?memberId=${mVO.memberId}" class="myAccountNav-btn " >나의 작품 </a>
            <a href="${pageContext.request.contextPath}/mypage/artist/artistWrite" class="myAccountNav-btn " >작품 등록하기</a>
</c:if>

		</nav>
		<section id="my_artwork_order" class="active">
			<section id="my_account_body" class="orders">
				<div class="orders_view in_progress">
					<h3>현재 진행 중인 경매</h3>
					<input type="hidden" id="lastTime" value="${lastTime }" />

					<div>
						<table class="order_list">
							<tbody>
								<tr>
									<th scope="col" class="date_order ">번호</th>
									<th colspan="2" scope="col" class="artworks" style="width: 10%">작품명</th>
									<th scope="col" class="date_install ">입찰수량</th>
									<th scope="col" class="date_install ">입찰가</th>
									<th scope="col" class="date_install ">입찰일자</th>
									<th scope="col" class="date_return ">종료 날짜</th>
								</tr>


								<c:if test="${not empty getTotalBidding}">
									<c:forEach var="sucToBid" items="${getTotalBidding}">

										<tr>
											<td>${sucToBid.roNum}</td>
											<td colspan="2"><a
												href="${pageContext.request.contextPath}/auction/view.do?code=${sucToBid.code}"><img
													src="${sucToBid.imageurl }" alt="${sucBid.title}" />${sucToBid.title}</a></td>
											<td>1</td>
											<td><fmt:formatNumber value="${sucToBid.bidsPrice}"
													pattern="#,###원" /></td>
											<td>${sucToBid.fmtAuctionTime}</td>
											<td>${sucToBid.fmtEndTime}</td>
										

										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty getTotalBidding}">
									<tr>
										<td colspan="8" class="empty">표시할 내역이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<div class="m_order_list">

							<div class="m_order_list_detail m_order_not">
								<span>표시할 내역이 없습니다.</span>
							</div>
						</div>
					</div>



				</div>
				<div class="orders_view completed">
					<h3>낙찰된 경매 내역</h3>




					<div>
						<table class="order_list">
							<tbody>
								<tr>
									
									<!-- <th scope="col" class="date_order ">작품코드</th> -->
									<th colspan=2 scope="col" class="artworks" style="width: 10%">작품명</th>
									
									<th scope="col" class="date_install ">입찰수량</th>
									<th scope="col" class="date_install ">입찰가</th>
									<th scope="col" class="date_install ">입찰가별 합계</th>
									
								</tr>

								<c:if test="${not empty totalSuccessfulBid}">
									<c:forEach var="sucBid" items="${totalSuccessfulBid}">
										<tr>

											<%-- <td>${sucBid.roNum}</td>
											 <td colspan="2">
											<a href="${pageContext.request.contextPath}/auction/view.do?code=${sucBid.code}">
												<img src="${sucBid.imageurl }" alt="${sucBid.title}" />${sucBid.title}</a></td>
											<td>1</td>
											<td><fmt:formatNumber value="${sucBid.bidsPrice}"
													pattern="#,###원" /></td> --%>									
											
											
											 <td colspan="2">
											<a href="${pageContext.request.contextPath}/auction/view.do?code=${sucBid.code}">
												<img src="${sucBid.imageurl }" alt="${sucBid.imageurl }"/>${sucBid.title}</a></td>
											
										<%-- 	<td colspan="2"><a
												href="${pageContext.request.contextPath}/auction/view.do?code=${sucBid.code}"><img
													src="${sucBid.imageurl }" alt="${sucBid.title}" />${sucBid.title}</a></td> --%>
											<td>${sucBid.lot}</td>
											<td>${sucBid.bidsPrice }</td>
											<td>${sucBid.sum}</td>

										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty totalSuccessfulBid}">
									<tr>
										<td colspan="8" class="empty">표시할 내역이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<div class="m_order_list">
							<div class="m_order_list_detail m_order_not">
								<span>표시할 내역이 없습니다.</span>
							</div>
						</div>
					</div>
				</div>
			</section>
		</section>
	</div>
</body>
<script>
/* 카운트 다운 함수 */
const countDownTimer = function (id, date) { 
	var _vDate = new Date(date); // 전달 받은 일자 
	var _mileSecond = 100; 
	var _second = 1000; 
	var _minute = _second * 60; 
	var _hour = _minute * 60; 
	var _day = _hour * 24; 
	var timer; 
	function showRemaining() { 
		var now = new Date(); 
		var distDt = _vDate - now; 
		if (distDt < 0) { 
			clearInterval(timer); 
			document.getElementById(id).innerHTML = '경매 종료'; 
			setEndAuction();//경매가 종료표시되는 요소를 변경시킴
			return; 
		} 
		var days = Math.floor(distDt / _day); 
		var hours = Math.floor((distDt % _day) / _hour); 
		var minutes = Math.floor((distDt % _hour) / _minute); 
		var seconds = Math.floor((distDt % _minute) / _second); 
		var mileSeconds = Math.floor((distDt % _second) / _mileSecond); 
		//document.getElementById(id).textContent = date.toLocaleString() + "까지 : "; 
		document.getElementById(id).innerHTML = days + '일 '; 
		document.getElementById(id).innerHTML += hours + '시간 '; 
		document.getElementById(id).innerHTML += minutes + '분 '; 
		document.getElementById(id).innerHTML += seconds + '초 '; 
		document.getElementById(id).innerHTML += mileSeconds; 
	} 
	timer = setInterval(showRemaining, 100); 
} 
//경매종료시간
var endTime = '<c:out value='${sucToBid.fmtEndTime}' />'
console.log("endTime:"+endTime);
//var dateObj = new Date(); 
//dateObj.setDate(dateObj.getDate()+1); 
//dateObj.setDate(timestamp);
//console.log("timestamp:",timestamp);
//new Date("2020-07-27 18:23:01:000")
//카운드다운함수(카운트다운을표시할DOM, 미래시간)
countDownTimer('timeOut',endTime); 
// 내일까지 countDownTimer('sample02', '04/01/2024 00:00 AM'); 
// 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다. countDownTimer('sample03', '04/01/2024'); 
// 2024년 4월 1일까지 countDownTimer('sample04', '04/01/2019'); 
// 2024년 4월 1일까지 
</script>
</html>

