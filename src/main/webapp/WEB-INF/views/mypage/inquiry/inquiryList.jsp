<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<!doctype html>
<html lang="en">

<link rel="stylesheet"href="${pageContext.request.contextPath}/resources/css/mypagelist2.css">	
	
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>마이 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<style>
th{text-align: center;}
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
    height: 40px;
}
</style> 
<script>

</script>
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
            <a href="${pageContext.request.contextPath}/mypage/auction" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 경매</a>
            <a href="${pageContext.request.contextPath}/mypage/deposit" class="myAccountNav-btn" onclick="ga_clk_account('account_points');">예치금 관리</a>
            <%-- <a href="${pageContext.request.contextPath}/mypage/stock" class="myAccountNav-btn" onclick="ga_clk_account('account_contacts');">지분 거래</a> --%>
            <a href="${pageContext.request.contextPath}/mypage/revenue" class="myAccountNav-btn " >나의 수익</a>
            <a href="${pageContext.request.contextPath}/mypage/inquiry/inquiryList" class="myAccountNav-btn current" onclick="ga_clk_account('account_contacts');">1:1 문의하기</a>
<c:if test="${mVO.authority eq 'ROLE_ARTIST'}">
            <a href="${pageContext.request.contextPath}/showroom/art/artistview.do?memberId=${mVO.memberId}" class="myAccountNav-btn " >나의 작품 </a>
            <a href="${pageContext.request.contextPath}/mypage/artist/artistWrite" class="myAccountNav-btn " >작품 등록하기</a>
</c:if>
        </nav>
			<section id="my_artwork_order" class="active">
				<section id="my_account_body" class="orders">
					<div class="orders_view in_progress">
		                
		                <h3>1:1 문의 내역</h3>
		                  <div >
		                      <table class="order_list">
		                          <tbody>
		                             <tr>
		                                  <th scope="col" class="date_order" style="width: 10%;">번호</th>
			                              <th scope="col" class="date_install" style="width: 65%;">제목</th>
			                              <th scope="col" class="date_install" style="width: 15%;">작성일</th>
			                              <th scope="col" class="type" style="width: 10%;">상태</th>
		                             </tr>
		                          
		                             <c:if test="${not empty lists}">
				                        <c:forEach var="row" items="${lists}">
				                  
				                           <tr>
				                              
				                              <td>${row.virtualNum}</td>
											<td style="text-align: left; padding-left: 30px;" ><a href="inquiryView.do?idx=${row.idx}&nowPage=${nowPage}&searchField=${params.searchField}&searchTxt=${params.searchTxt}">${row.title}</a></td>				                              

				                              <td>${row.postdate }</td>
											<c:if test="${row.replyOX eq 1}">
											 <td><span class="badge badge-primary">답변 완료</span></td>
											</c:if>
											<c:if test="${row.replyOX eq 0}">
											 <td><span class="badge badge-danger">문의중</span></td>
											 </c:if>
									
				                           </tr>
				                        </c:forEach>
				                     </c:if>
		                             <c:if test="${empty lists}">
		                                <tr>
		                                     <td colspan="4" class="empty">표시할 내역이 없습니다.</td>
		                                </tr>                             
		                             </c:if>
		                          </tbody>
		                      </table>
		                      <div class="page_pageniation">
									<nav aria-label="Page navigation example">
										<!-- 페이지버튼 -->
										<ul class="pagination justify-content-center">${pagingImg }</ul>
									</nav>
								</div>                     
		                      <div class="m_order_list">
		                          
		                         <div class="m_order_list_detail m_order_not">
		                             <span>표시할 내역이 없습니다.</span>
		                         </div>                          
		                      </div>
		                  </div>
		            </div>
		        </section>
		    </section>
       	<button class="inquiry-Button" onclick="location.href='inquiryWrite.do'">문의하기</button>
    </div>
</body>

</html>