<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

th{text-align: center; }
.inquiry-Button{float: right; display: block;width: 200px;height:40px;border: 0;outline: 0;	margin: 16px;background-color: #222;font-size: 14px;	color: #fff;	transition: opacity 0.1s ease-in-out mar}
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
            <a href="${pageContext.request.contextPath}/mypage/rental" class="myAccountNav-btn" onclick="ga_clk_account('account_orders');">나의 렌탈</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/art" class="myAccountNav-btn" onclick="ga_clk_account('account_gifts');">관심 목록</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/deposit" class="myAccountNav-btn" onclick="ga_clk_account('account_points');">예치금 관리</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/stock" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 거래</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/auction" class="myAccountNav-btn current" onclick="ga_clk_account('account_contacts');">지분 경매</a>
            <a href="${pageContext.request.contextPath}/mypage/inquiry/inquiryList" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">1:1 문의하기</a>
            
            
        </nav>
     	<section id="my_artwork_order" class="active">
          <section id="my_account_body" class="orders">
              <div class="orders_view in_progress">
                  <h3>현재 진행 중인 경매</h3>
                  
                  <div>
                      <table class="order_list">
                          <tbody>
                          <tr>
                              <th scope="col" class="date_order " >경매번호</th>
                              <th colspan="2" scope="col" class="artworks" style="width: 10%">작품명</th>
                              <th scope="col" class="date_install ">입찰수량</th>
                              <th scope="col" class="date_install ">입찰가</th>
                              <th scope="col" class="date_install ">입찰일자</th>
                              <th scope="col" class="date_return ">종료 날짜</th>
                              <th scope="col" class="type " >비고</th>
                          </tr>
                          
                          
                            <c:if test="${not empty getTotalBidding}">
	                        <c:forEach var="sucToBid" items="${getTotalBidding}">
	                  
	                           <tr>
	                              <td>${sucToBid.roNum}</td>
	                              <td colspan="2"><a href="${pageContext.request.contextPath}/auction/view.do?code=${sucToBid.code}"><img src="${sucToBid.imageurl }" alt="${sucBid.title}" />${sucToBid.title}</a></td>
	                              <td>4</td>
	                              <td><fmt:formatNumber value="${sucToBid.bidsPrice}" pattern="#,###원"/></td>
	                              <td>${sucToBid.fmtAuctionTime}</td>
	                              <td>${sucToBid.fmtEndTime}</td>
	                              <td></td>
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
                                  <th scope="col" class="date_order " >경매번호</th>
                                  <th colspan="2" scope="col" class="artworks" style="width: 10%">작품명</th>
	                              <th scope="col" class="date_install ">입찰수량</th>
	                              <th scope="col" class="date_install ">입찰가</th>
	                              <th scope="col" class="date_install ">입찰일자</th>
	                              <th scope="col" class="date_return ">종료 날짜</th>
	                              <th scope="col" class="type " >비고</th>
                             </tr>
                          
                             <c:if test="${not empty totalSuccessfulBid}">
		                        <c:forEach var="sucBid" items="${totalSuccessfulBid}">
		                  
		                           <tr>
		                              
		                              <td>${sucBid.roNum}</td>
		                              <td colspan="2"><a href="${pageContext.request.contextPath}/auction/view.do?code=${sucBid.code}"><img src="${sucBid.imageurl }" alt="${sucBid.title}" />${sucBid.title}</a></td>
		                              <td>4</td>
		                              <td><fmt:formatNumber value="${sucBid.bidsPrice}" pattern="#,###원"/></td>
		                              <td>${sucBid.fmtAuctionTime}</td>
		                              <td>${sucBid.fmtEndTime}</td>
		                              <td>결제하기<span class="badge badge-primary">결제하기</span></td>
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

</html>