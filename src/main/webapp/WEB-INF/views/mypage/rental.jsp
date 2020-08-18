<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="en">

<link rel="stylesheet"href="${pageContext.request.contextPath}/resources/css/mypagelist2.css">	
	
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>마이 페이지</title>

</head>
<style>
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

td.empty {
    line-height: 1.5em;
}
/* #my_account_body.orders table.order_list td {
	text-align: left;
} */

#my_account_body.orders table.order_list th {
	text-align: center;
}
</style> 

<body>
	<div id="contents" data-login_required="true">
        <section class="pageHead" id="my_account_head">
            <div class="pageHead-bar"></div>
            <h2 class="pageHead-title">마이페이지</h2>
            <div class="pageHead-description">
                고객님과 관련된 정보입니다.
            </div>
        </section>
        <section id="myModify">
            <div class="myModify-inner">
                <h3 id="myModify-name"><sec:authentication property="principal.username" /> <span>님, 반갑습니다.</span></h3>
                <a href="${pageContext.request.contextPath}/mypage/modify/" onclick="ga_clk_account('account_modify');">
                    <div class="myModify-btn">
                        <p>회원정보수정</p>
                    </div>
                </a>
            </div>
        </section>

        <nav id="myAccountNav" class="cf">
            <a href="${pageContext.request.contextPath}/mypage/rental" class="myAccountNav-btn current" onclick="ga_clk_account('account_orders');">나의 렌탈</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/art" class="myAccountNav-btn" onclick="ga_clk_account('account_gifts');">관심 목록</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/auction" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 경매</a>
            <a href="${pageContext.request.contextPath}/mypage/deposit" class="myAccountNav-btn" onclick="ga_clk_account('account_points');">예치금 관리</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/stock" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 거래</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/revenue" class="myAccountNav-btn " >나의 수익</a>
            <a href="${pageContext.request.contextPath}/mypage/inquiry/inquiryList" class="myAccountNav-btn " >1:1 문의하기</a>
<c:if test="${mVO.authority eq 'ROLE_ARTIST'}">
            <a href="${pageContext.request.contextPath}/showroom/art/artistview.do?memberId=${mVO.memberId}" class="myAccountNav-btn " >나의 작품 </a>
            <a href="${pageContext.request.contextPath}/mypage/artist/artistWrite" class="myAccountNav-btn " >작품 등록하기</a>
</c:if>
        </nav>
	        <section id="my_gift_order" class="active">
		        <section id="my_account_body" class="orders">
		            <div class="orders_view">
		                <h3>나의 렌탈 내역</h3>
		                <div>
		                    <table class="order_list">
		                        <tbody>
		                        <tr>
		                            <th scope="col" class="order_code">번호</th>
		                            <th scope="col" class="order_code">작품이미지</th>
		                            <th scope="col" class="order_code">작품명/작가명</th>
		                            <th scope="col" class="amount">렌탈시작일</th>
		                            <th scope="col" class="type">렌탈종료일</th>
		                            <th scope="col" class="detail">렌탈가격</th>
		                            <th scope="col" class="shipping_name">렌탈정보</th>
		                            <th scope="col" class="delivery_type">렌탈상태</th>
		                        </tr>

	                        	<c:forEach items="${rentalinfo }" var="rental">
	                        	
	                        	<c:choose>
	                        	<c:when test="${empty rentalinfo }">
		                            <tr>
		                                <td colspan="7" class="empty">표시할 내역이 없습니다.</td>
		                            </tr>
	                        	</c:when>
	                        	<c:otherwise>
	                            	<tr>
		                                <td class="empty">${rental.virtualNum }</td>
		                                <td class="empty"><a href="${pageContext.request.contextPath}/rental/view.do?code=${rental.code}">
		                                	<img src="${rental.imageUrl }" style="max-width: 100px; max-height: 100px;"/></a></td>
		                                <td class="empty">${rental.title }<br>${rental.name }</td>
		                                <td class="empty">${rental.rentalBegin }</td>
		                                <td class="empty">${rental.rentalEnd }</td>
		                                <td class="rentalPrice" style="text-align:left;">렌트가: &nbsp;&nbsp;<fmt:formatNumber value="${rental.rentalPrice }"/>원
		                                				<br>총합계: &nbsp;&nbsp;<fmt:formatNumber value="${rental.totalAmount }"/>원</td>
		                                <td class="rentalInfo" style="text-align:left;">수령인: ${rental.receiver }
		                                				<br>설치장소: ${rental.address1 } ${rental.address2 }
		                                				<br>연락처: ${rental.phone }</td>
		                                <c:choose>
		                                	<c:when test="${rental.transType eq '반납'}">
				                                <td class="rentalStatus" >${rental.transType }</td>
		                                	</c:when>
		                                	<c:otherwise>
				                                <td class="rentalStatus">렌탈중</td>
		                                	</c:otherwise>
		                                </c:choose>
		                            </tr>
	                        	</c:otherwise>
	                        	</c:choose>
	                        	
	                            </c:forEach>
		                        
		                        </tbody>
		                    </table>
							
							<!-- 모바일 웹사이즈에서 나타나는 div -->
		                    <div class="m_order_list">
	                            <div class="m_order_list_detail m_order_not">
	                                <span>표시할 내역이 없습니다.</span>
	                            </div>
		                    </div>
		                </div>
		                
		            </div>
		            
	                <!-- 페이징 처리 -->
	                <div class="page_pageniation" style="padding-top: 20px;">
						<nav aria-label="Page navigation example">
							<!-- 페이지버튼 -->
							<ul class="pagination justify-content-center">${pagingBtn }</ul>
						</nav>
					</div>
		        </section>
		    </section>
    </div>
</body>

</html>