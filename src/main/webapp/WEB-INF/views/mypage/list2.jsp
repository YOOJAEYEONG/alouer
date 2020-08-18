<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
</style> 

<body>
	<div id="contents" data-login_required="true">
        <section class="pageHead" id="my_account_head">
            <div class="pageHead-bar"></div>
            <h2 class="pageHead-title">마이페이지</h2>
            <div class="pageHead-description">
                고객님과 관련된 정보입니다. <input type="hidden" name="" value="${mVO.authority }" />
            </div>
        </section>
        <section id="myModify">
            <div class="myModify-inner">
                <h3 id="myModify-name"><sec:authentication property="principal.username" /> <span>님, 반갑습니다. </span></h3>
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
        <section id="my_artwork_order" class="active">
            <section id="my_account_body" class="orders">
                <div class="orders_view in_progress">
                    <h3>현재 렌탈 중인 작품</h3>
                    <div>
                        <table class="order_list">
                            <tbody>
                            <tr>
                                <th scope="col" class="date_order">주문일자<br>(주문번호)</th>
                                <th scope="col" class="type">유형</th>
                                <th scope="col" class="artworks">주문작품</th>
                                <th scope="col" class="date_install">설치일자</th>
                                <th scope="col" class="date_return">반납 예정일</th>
                                <th scope="col" class="status">현황</th>
                            </tr>
                            
                                <tr>
                                    <td colspan="6" class="empty">표시할 내역이 없습니다.</td>
                                </tr>
                            
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
                    <h3>반납 완료된 작품</h3>
                    <div>
                        <table class="order_list">
                            <tbody>
                            <tr>
                                <th scope="col" class="date_order">주문일자<br>(주문번호)</th>
                                <th scope="col" class="type">유형</th>
                                <th scope="col" class="artworks">주문작품</th>
                                <th scope="col" class="date_install">설치일자</th>
                                <th scope="col" class="date_return">반납 예정일</th>
                                <th scope="col" class="status">현황</th>
                            </tr>
                            
                                <tr>
                                    <td colspan="6" class="empty">표시할 내역이 없습니다.</td>
                                </tr>
                            
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