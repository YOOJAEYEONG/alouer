<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
<head>



<!-- 아트투게더 ------------------>
<!-- CSS ================================================== -->
<link href="${pageContext.request.contextPath}/resources/css/main/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main/css.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main/main.css" rel="stylesheet">

<!-- JS ================================================== -->
<script src="${pageContext.request.contextPath}/resources/js/main/jquery.bxslider.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main/jquery.li-scroller.1.0.js"></script>


<!-- Owlcarousel -->
<script src="${pageContext.request.contextPath}/resources/js/owl.carousel.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">


<script>
	
	$(function() {
		fn_resize();
		
		//메인 슬라이드
		var slidenum = 0;
		$('.carousel-item:first-child').addClass('active'); //첫번째 슬라이드만 active 처리
		$('.carousel-indicators li:first-child').addClass('active'); //첫번째 인디케이터 버튼 active 처리
		$('.carousel-indicators li').attr('data-slide-to', slidenum++); //불러온 작품정보 수만큼 슬라이드 개수 증가
		
		//렌탈작품 더보기 영역 숨기기
		$('#artwork_list_3').hide();
		$('#artwork_list_4').hide();
		$('#artwork_list_5').hide();
		$('#artwork_list_6').hide();
	});
	
	// 롤링 주식 배너
	function fn_resize() {
		if ($(window).width() < 767) { // 모바일
			//티커
			$("#ticker01").liScroll({
				travelocity : 0.04
			});
		} else { 
			//티커
			$("#ticker01").liScroll({
				travelocity : 0.10
			});
		}
	}
	
	//렌탈작품 더보기 영역 보이기
	function ga_clk_home2() {
		console.log('버튼클릭되었습니다');
		
		$('#artwork_list_3').slideDown('slow');
		$('#artwork_list_4').slideDown('slow');
		$('#artwork_list_5').slideDown('slow');
		$('#artwork_list_6').slideDown('slow');
		
		$('.hidebtn1').hide();
		$('#artwork_list_discover').show();					
	}		

</script>


<style>
/* 메인 슬라이더 스타일 */
.carousel-caption p {
	font-family: 'Noto Sans KR', sans-serif;
}

.carousel-inner img {
	width: 100%;
	height: 650px;
	object-fit: cover;
}

.carousel-caption {
	background-color: rgba(0, 37, 62, .9);
}

.carousel-caption h3 {
	color: white;
	font-size: 2.1em;
	font-family: 'Noto Serif KR', serif, "Cardo", serif;
}

.carousel-caption .art-name {
	color: #ffffff8a;
	font-size: 1.4em;
}

.carousel-caption .pieces {
	color: white;
	text-align: left;
}

.carousel-caption .percent {
	color: white;
	font-size: 18px;
	text-align: right;
	margin-top: -28px;
	font-weight: bold;
}

.carousel-caption a {
	color: #c29b40;
	font-weight: bold;
}

.carousel-caption a:hover {
	color: #c29b40 !important;
	font-weight: bold !important;
	text-decoration: underline !important;
}

.progress-bar {
	background-color: #c29b40;
}

.carousel-control-next-icon, .carousel-control-prev-icon {
	width: 30px;
	height: 30px;
}

@media ( min-width : 1200px) {
	/* line 306, /Applications/MAMP/htdocs/palash/cl/july 2019/191 Lifeleck Blog/191 Lifeleck Blog html/sass/_common.scss */
	.container .container2 {
		max-width: 115% !important;
		margin: 0 -80px 0 -80px !important;
	}
}

/* 업커밍 경매 영역 */
.banner_post .banner_post_1 {
	height: 333px;
}
h1 {
    font-size: 33px;
    font-family: "Cardo", serif;
}

h1:after {
	content: "";
	display: block;
	width: 80px;
	border-bottom: 2px solid #c29b40;
	margin: 20px 0px;
}

.banner_post_1 img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.banner_post h5 {
	font-family: 'Noto Serif KR', serif, "Cardo", serif;
}

.banner_post p {
    font-family: 'Noto Sans KR', sans-serif;
}

.banner_post_iner h2 {
	height: 55px;
}
.banner_post_iner h4 {
	font-family: 'Noto Serif KR', serif, "Cardo", serif;
}
.badge {
	margin-top: -130px;
	margin-left: 15px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 15px;
	background-color: rgb(237, 15, 0);
	box-shadow: 0px 1px 9px -2px #000000;
}

.viewBtn {
	margin-top: 17px;
	margin-right: -6px;
}

.btn-outline-secondary:not (:disabled ):not (.disabled ):active,
	.btn-outline-secondary:hover {
	background-color: #00253e;
}

.artwork_section_btn {
	margin-top: 50px;
	text-align: center;
}

#artwork_list_more {
	display: block;
	margin: 0 auto;
	width: 180px;
	height: 46px;
	border: 1px solid #979797;
	border-radius: 22px;
	line-height: 46px;
	font-size: 16px;
	font-weight: bold;
	color: #222;
	background: #fff;
	cursor: pointer;
	box-sizing: border-box;
}

#artwork_list_discover {
	display: none;
	margin: 0 auto;
}

#artwork_section2 {
	/* line-height: 1.5; */
	/* max-width: 956px; */
	/* width: 92%; */
	/* margin: 0 auto; */
	padding: 66px 0 50px;
	overflow: hidden;
	text-align: center;
}

/************** 아트투게더 ***************/


section.Section3piece {
	width: 1950px;
	left: -400px;
}
/* section.Section3piece .main-exchange ul li div.rolling-left {
	width: 100px;
	height: 100px;
}

section.Section3piece .main-exchange ul li {
	height: 150px;
	padding: 26px 20px;
}

section.Section3piece .main-exchange div.mask ul.newsticker,
section.Section3piece .main-exchange div.mask,
section.Section3piece .main-exchange div.tickercontainer,
section.Section3piece .main-exchange {
	height: 150px;
}
 */
section.Section3piece .piecemarket {
	padding: 0px;
}

section.Section3piece .main-exchange {
	background-color: #00253e;
}

.breadcrumb {
	display: none;
}

</style>



</head>
<body>
	<!-- header(nav) -->

	<!------------------------ #1 메인 슬라이더 영역 ------------------------>
	<div class="container2">
		<div id="demo" class="carousel slide" data-ride="carousel">
			<ul class="carousel-indicators">
			<c:forEach items="${mainlist }" var="dto">
				<li data-target="#demo" data-slide-to=""></li>
			</c:forEach>
			</ul>
			<div class="carousel-inner">
			
				<!-- 경매정보 반복 부분 -->
				<c:forEach items="${mainlist }" var="dto">
					<div class="carousel-item">
						<a href="<c:url value="/auction/view.do?code=${dto.code }"/>"><img
							src="${dto.imageUrl }"
							alt="Los Angeles"></a>
						<div class="carousel-caption justify-content-center">
							<div class="inner-caption" style="width: 80%; margin: 0 10%;">
								<h3 class="art-title">${dto.title }</h3>
								<p class="art-name">${dto.name }</p>
								<div class="progress">
									<div class="progress-bar" style="width: ${dto.competition}%"></div>
								</div>
								<p class="pieces">${dto.countTrans } / ${dto.auctionTotal } 조각</p>
								<!-- 경쟁률(지분 수 대비 참여율) -->
								<p class="percent">경쟁률 : ${dto.competition }%</p>
								<a href="<c:url value="/auction/view.do?code=${dto.code }"/>">지분경매 바로가기</a>
							</div>
						</div>
					</div>
				</c:forEach>	
				<!-- 경매정보 반복 부분 END -->
			
			</div>
			
			<a class="carousel-control-prev" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</a> <a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon"></span>
			</a>
		</div>
	</div>
	<!------------------------ #1 메인 슬라이더 영역 END ------------------------>

	
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />


	<!------------------------ #2 Coming Soon 영역 ------------------------>
   <!-- 섹션 타이틀 -->
   <div class="container">
      <div class="row">
         <h1>Coming Soon</h1>
      </div>
   </div>

   <section class="banner_post">
      <div class="container-fluid">
         <div class="row justify-content-between">
            
            <!-- 경매준비중 작품 가져오기 -->
            <c:forEach items="${cominglist }" var="coming">
               <div class="banner_post_1 banner_post_bg_1">
               
                  <img src="${coming.imageUrl }" alt="Los Angeles" />
                  <h3>
                     <span class="badge badge-pill badge-primary">경매예정</span>
   <!--                   <span class="badge badge-pill badge-primary"><span
                        style="font-size: 10px;">▲</span> + 300 %</span> -->
                  </h3>
                  <div class="banner_post_iner text-center">
                     <a href="category.html"><h5>경매 예정 작품</h5></a> <a
                        href="single-blog.html"><h2>${coming.title }</h2></a>
                     <p>${coming.name }</p>
                     <%-- <p>경매 시작가</p>
                     <h4><fmt:formatNumber value="${coming.startBids }"/>원</h4> --%>
                  </div>
               </div>
            </c:forEach>
            
            
         </div>
      </div>

   </section>


   <div class="container" style="margin-top: 164px;">

      <div class="artwork_section_btn">
         <div id="artwork_list_more" style="border-radius:0px;"
            onclick="location.href='<c:url value="/stock"/>'">더 많은 거래 보기</div>
      </div>
   </div>
   <br />
   <!------------------------ #2 Coming Soon 영역 END------------------------ >


	
	<!------------------------ #3 롤링 주식 배너 ------------------------>
   <!-- 조각거래소 -->
   <section class="Section Section3piece">
      <article class="piecemarket">
         <article class="piece-rolling">
            <div class="main-exchange">
               <ul class="clear" id="ticker01">
                  
                  <!-- 경매정보 가져오기 -->
                  <c:forEach items="${rollinglist }" var="rolling">
                     <a href="auction/view.do?code=${rolling.code }"><li>
                           <div class="rolling-left">
                              <img
                                 src="${rolling.imageUrl }">
                           </div>
                           <div class="rolling-right">
                              <h2>${rolling.title }</h2>
                              <h3>${rolling.name }</h3>
                              <h4>
                                 <span class="percent redcolor"><span
                                    class="triangle-red"></span>낙찰가능가</span>
                                    <fmt:formatNumber value="${rolling.minPrice }"/><span class="krw">KRW</span>
                              </h4>
   
   
                           </div>
                     </li></a>
                  </c:forEach>

               </ul>
            </div>
         </article>
      </article>
   </section>
   <!------------------------ #3 롤링 주식 배너 END ------------------------>
	
	
	<!------------------------------ #4 렌탈 작품 영역  ----------------------------->
	<div class="wrap">
		<div id="contents">
			<div id="start_content"></div>
			<div class="container_full cf">
				<section id="artwork_section2">


					<!-- 섹션 타이틀 -->
					<div class="container">
						<div class="row">
							<h1>Rent Now Our Arts</h1>
						</div>
					</div>
					
					<!-- 렌탈 작품 정보 가져와서 html태그로 이어 붙이기  -->
					<c:forEach items="${mainlistrental }" var="dto" varStatus="status">
						<script>
							$(function() {
								var html = '';
								html += '<a href="<c:url value="/rental/view.do?code=${dto.code}"/>" class="artwork_list_block"';
								html += '	style="background-image: url(${dto.imageUrl})"><div';
								html += '		class="artwork_list_mask">';
								html += '		<div class="artwork_list_mask_block">';
								html += '			<h4>${dto.title}</h4>';
								html += '			<span>${dto.name}</span>';
								html += '		</div>';
								html += '	</div></a>';
								
								var index = ${status.index};
								
								if (index >= 0 && index < 4) {
									$('#artwork_list_1').append(html);
								} 
								if (index == 4) {
									$('#artwork_list_2').append(html);
								}
								if (index >= 5 && index < 9) {
									$('#artwork_list_3').append(html);
								}
								if (index >= 9 && index < 12) {
									$('#artwork_list_4').append(html);
								}
								if (index >= 12 && index < 15) {
									$('#artwork_list_5').append(html);
								}
								if (index >= 15 && index < 19) {
									$('#artwork_list_6').append(html);
								}
							});
						</script>
					</c:forEach>
					
					
					<!-- 작품 진열 -->
					<div class="artwork_section_list"
						onclick="ga_clk_home('weekly_artwork_list_190208');">
						<div id="artwork_list_1">
							<!-- 모델객체 통해 가져온 데이터 반복구간 -->
						</div>
						<div id="artwork_list_2">
							<!-- 모델객체 통해 가져온 데이터 반복구간 -->
						</div>
						<div id="artwork_list_3" class="hide_block">
							<!-- 모델객체 통해 가져온 데이터 반복구간 -->
						</div>
						<div id="artwork_list_4" class="hide_block">
							<!-- 모델객체 통해 가져온 데이터 반복구간 -->
						</div>
						<div id="artwork_list_5" class="hide_block">
							<!-- 모델객체 통해 가져온 데이터 반복구간 -->
						</div>
						<div id="artwork_list_6" class="hide_block">
							<!-- 모델객체 통해 가져온 데이터 반복구간 -->
						</div>
					</div>

					<!-- 더보기 버튼 -->
					<div class="artwork_section_btn hidebtn1">
						<div id="artwork_list_more" onclick="ga_clk_home2();">+ 더보기</div>
					</div>
					<div class="artwork_section_btn">
						<a href="<c:url value="/rental"/>" id="artwork_list_discover">
							<div>더 많은 작품 보기</div>
						</a>
					</div>

				</section>
			</div>


		</div>
	</div>
	<!------------------------------ #4 렌탈 작품 영역 END ----------------------------->


	<!-- Draggable -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.3/TweenLite.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.3/utils/Draggable.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.3/plugins/CSSPlugin.min.js"></script>



	<!-- footer -->

	<!-- footer part end-->
	<!-- jquery -->

</body>

</html>