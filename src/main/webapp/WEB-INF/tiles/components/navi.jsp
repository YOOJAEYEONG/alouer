<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>


<header class="main_menu">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-lg-12">
				<nav class="navbar navbar-expand-lg navbar-light">

					<a class="navbar-brand" href="${pageContext.request.contextPath}">
						<img src="${pageContext.request.contextPath}/img/logo.svg"
						width="123px" alt="logo">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div
						class="collapse navbar-collapse main-menu-item justify-content-center"
						id="navbarSupportedContent">
						<ul class="navbar-nav">
							<li class="nav-item nav-item2 active"><a
								class="nav-link nav-link2"
								href="${pageContext.request.contextPath}/about">아루에</a></li>
							<li class="nav-item nav-item2 dropdown"><a
								class="nav-link nav-link2 dropdown-toggle" href="#"
								id="navbarDropdown" role="button" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> 전시관 </a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown">
									<a class="dropdown-item"
										href="${pageContext.request.contextPath}/showroom/art">작품보기</a>
									<a class="dropdown-item"
										href="${pageContext.request.contextPath}/showroom/art/artists">작가소개</a>

								</div></li>

							<li class="nav-item nav-item2"><a class="nav-link nav-link2"
								href="${pageContext.request.contextPath}/auction">지분경매</a></li>

							<li class="nav-item nav-item2"><a class="nav-link nav-link2"
								href="${pageContext.request.contextPath}/rental">렌탈</a></li>

							<!-- CS페이지 드롭다운메뉴 -->
							<li class="nav-item nav-item2 dropdown "><a
								class="nav-link nav-link2 dropdown-toggle" href="#"
								id="navbarDropdown" role="button" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> 고객지원 </a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown">
									<a class="dropdown-item"
										href="${pageContext.request.contextPath}/cs/board.do?bname=notice">공지사항</a>
									<a class="dropdown-item"
										href="${pageContext.request.contextPath}/cs/board.do?bname=faq">FAQs</a>
									<a class="dropdown-item"
										href="${pageContext.request.contextPath}/mypage/inquiry/inquiryList">1:1
										문의하기</a>
								</div></li>
							<li class="nav-item nav-item2"><a class="nav-link nav-link2"
								href="${pageContext.request.contextPath}/mypage/rental">마이페이지</a></li>
								
								
								
								
								
						<sec:authorize access="isAuthenticated()">
                        <%-- <li class="nav-item nav-item2" style="padding-top: 11px">
                           <sec:authentication property="principal.username" />
                        </li>  --%>
                        <form:form method="post" action="${pageContext.request.contextPath }/member/logout">
                           <li class="nav-item nav-item2">
                              <button class="btn" type="submit">로그아웃</button>
                           </li>
                        </form:form>
                     </sec:authorize>
                     <!-- view/member/login.jsp 이동 -->
                     <sec:authorize access="!isAuthenticated()">
                        <li class="nav-item nav-item2">
                           <a
                           href="${pageContext.request.contextPath}/member/login"
                           class="nav-link nav-link2">로그인</a>
                        </li>
                        <!-- view/member/register.jsp 이동 -->
                        <li class="nav-item nav-item2"><a
                           href="${pageContext.request.contextPath}/member/join"
                           class="nav-link nav-link2">회원가입</a>
                        </li>
                     </sec:authorize>
                 	
								
								
								
								
							<%-- 	
					<sec:authorize access="isAuthenticated()">
                        <form:form method="post" action="${pageContext.request.contextPath }/member/logout">
                           <li class="nav-item nav-item2 isAuthenticated" style="display: none;">
                              <button class="btn ml-3" type="submit">로그아웃(<sec:authentication property="principal.username" />)</button>
                           </li>
                        </form:form>
                     </sec:authorize>
                     
                     <!-- view/member/login.jsp 이동 -->
                     <sec:authorize access="!isAuthenticated()">
                        <li class="nav-item nav-item2 isAnonymous">
                           <a href="${pageContext.request.contextPath}/member/login"  class="nav-link nav-link2">login</a>
                        </li>
                        <!-- view/member/register.jsp 이동 -->
                        <li class="nav-item nav-item2 isAnonymous">
                           <a href="${pageContext.request.contextPath}/member/join"  class="nav-link nav-link2">join</a>
                        </li>
                     </sec:authorize>
                      --%>

                  <%-- 
                  </ul>
               </div>
               <div class="header_social_icon d-none d-lg-block">
                  <ul class="navbar-nav">
                     <li class="nav-item" style="padding-top: 11px">
                        <div id="wrap" style="min-width: 0">
                           <form:form action="${pageContext.request.contextPath}/showroom/art" autocomplete="on">
                              <input id="search" name="searchTxt" type="text"
                                 placeholder="Search here"><span class="ti-search"></span>
                           </form:form>
                        </div>
                     </li>
                     <sec:authorize access="isAuthenticated()">
                        <li class="nav-item" style="padding-top: 11px">
                           
                        </li>
                        <form:form method="post"
                           action="${pageContext.request.contextPath }/member/logout">
                           <li class="nav-item">
                              <button class="btn" type="submit">로그아웃(<sec:authentication property="principal.username" />)</button>
                           </li>
                        </form:form>
                     </sec:authorize>
                     <!-- view/member/login.jsp 이동 -->
                     <sec:authorize access="isAnonymous()">
                        <li class="nav-item" style="padding-top: 11px"><a
                           href="${pageContext.request.contextPath}/member/login"
                           class="d-none d-lg-block">login</a></li>
                        <!-- view/member/register.jsp 이동 -->
                        <li class="nav-item">
                           <button class="btn">
                           <a
                           href="${pageContext.request.contextPath}/member/join"
                           class="d-none d-lg-block">join</a>
                           </button>
                           </li>
                     </sec:authorize>
								 --%>
				
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
</header>

<section class="breadcrumb breadcrumb_bg align-items-center">
	<div class="container">
		<div class="row align-items-center justify-content-between">
			<div class="col-sm-6">

				<div class="breadcrumb_tittle text-left">
					<h2 id="pageTitle">à Louer</h2>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="breadcrumb_content text-right">
					<p style="font-family: Noto Sans KR, sans-serif;">
						아루에<span>/</span>à Louer
					</p>
				</div>
			</div>
		</div>
	</div>
	<script>
	$(function() {
		//페이지 타이틀 바 		
		var pageTitle = $(document).find("title").text();
		$('#pageTitle').text(pageTitle);
	
	});	
	</script>
</section>

