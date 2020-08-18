<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script>
$(function(){
	
});
<!-- CSS ================================================== -->
<link rel="stylesheet" href="/vendors/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="/vendors/jquery.modal/jquery.modal.css">
<link href="/css/fo/common.css" rel="stylesheet">
<link href="/css/fo/css.css" rel="stylesheet">
<link href="/css/fo/main.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/vendors/fontawesome-free-5.10.2-web/css/all.min.css">

<link rel="stylesheet" href="/css/fo/jquery.modal.css">
<link rel="stylesheet" href="/css/fo/slick.css">
<link rel="stylesheet" href="/css/fo/jquery.bxslider.css">


<!-- JS ================================================== -->
<script type="text/javascript" src="/vendors/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/vendors/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/vendors/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/vendors/jquery.bxslider.js"></script>
<script type="text/javascript" src="/vendors/jquery.li-scroller.1.0.js"></script>
<script type="text/javascript" src="/vendors/slick.js"></script>
<script type="text/javascript" src="/vendors/jquery.modal/jquery.modal.min.js"></script>
<script src="/vendors/twbsPagination/jquery.twbsPagination.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/fo/common.js"></script>

<!-- 메인누적수치 -->
<script type="text/javascript" src="js/fo/jquery.particleground.js"></script>
<script type="text/javascript" src="js/fo/jquery.particleground.min.js"></script>
<script type="text/javascript" src="js/fo/demo.js"></script>
<!-- 메인누적 카운터 -->
<script type="text/javascript" src="js/fo/jquery.counterup.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>


	<script type="text/javascript" charset="utf-8" src="/js/fo/js.js"></script>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=bwht74s60v"></script>
<script src="https://d.line-scdn.net/r/web/social-plugin/js/thirdparty/loader.min.js" async="async" defer="defer"></script>
<script src="/vendors/amcharts/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/timeline.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/bullets.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/kelly.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script type="text/javascript" src="/vendors/html2canvas.min.js"></script>
<script type="text/javascript" src="/vendors/printThis.js"></script>
<script type="text/javascript" src="/vendors/table2excel/jquery.table2excel.js"></script>


<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-126586552-4"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'UA-126586552-4');
</script>



<meta property="og:image" content="https://www.weshareart.com/images/fo/logo.png" />
<script type='text/javascript'>
	// 팝업 제어
	$(function(){
		var popupCnt = $('#popupCnt').val();
		var cookieData = document.cookie;
		
		if(parseInt(popupCnt) > 0) {
			if(cookieData.indexOf('_get_popup_yn=Y') == -1) {
				var overlay = $('<div id="overlay"></div>');
				overlay.show();
				overlay.appendTo(document.body);
				$('.popup').show();
				$('.close').click(function(){
					$('.popup').hide();
					overlay.appendTo(document.body).remove();
					
					// 팝업 오늘은 다시 보지 않기 설정
					if($('.popup #checkbox-1').is(':checked') ) {
						// 저장될 쿠키명, 쿠키 value값, 기간( ex. 1은 하루, 7은 일주일)
						fn_todayClosePopup( "_get_popup_yn", "Y", 1 );
					}
					
					return false;
				});
			}
			
			/*
			$('.x').click(function(){
				$('.popup').hide();
				overlay.appendTo(document.body).remove();
				return false;
			});
			
		 	$('#overlay').click(function(){
				$('.popup').hide();
				overlay.appendTo(document.body).remove();
				return false;
			});
			*/
		}
	});
	
	function fn_todayClosePopup( name, value, expiredays ) {
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	}
</script>
<script>
	
	// 슬라이드
	$(function() {
		fn_resize();
		
		/*공지 아이콘 깜빡거림*/
		setInterval(function() {
			$("section.Section .banner-fixed>div>img").toggleClass("op5");
		}, 800);

		$(".main-next p").click(function() {
			return $("#slideShow .bx-next").trigger("click");
		});
		$(".main-prev p").click(function() {
			return $("#slideShow .bx-prev").trigger("click");
		});

		$(window).resize(function(){
			fn_resize();
		});

		
		// 툴팁
		$(".tooltip").each(function(){
			$(this).click( function(){
				if( $(this).find(".tooltip-text").css("display") == "none" ) {
					$(this).find(".tooltip-text").show()
				}else {
					$(this).find(".tooltip-text").hide()
				}
			});
			$(this).mouseenter( function(){ $(this).find(".tooltip-text").show() } );
			$(this).mouseleave( function(){ $(this).find(".tooltip-text").hide() } );
		});

		
		//누적 숫자 카운팅
		$('.numerical ul .counter').eq(3).text($('#artworkYield').val());	// 총 매각 누적 수익률
		$('.numerical ul .counter').eq(4).text($('#allRealPal').val());		// 총 조각거래 실현손익률
		$('.numerical ul .counter').eq(5).text($('#profitLossRate').val());	// 총 조각거래 평가손익률
		$('.numerical ul .counter').eq(7).text($('#clcltYield').val());		// 총 렌탈 수익률
		$(".counter").counterUp({
            delay: 10,
            time: 300
        });
		if(parseInt($('#artworkYield').val()) < 0 || parseInt($('#allRealPal').val()) < 0 || parseInt($('#profitLossRate').val()) < 0 || parseInt($('#clcltYield').val()) < 0) {
			setTimeout("fn_numReIn()", 4000);
		}
		
		// 거래소 실시간 시간
		fn_printClock();

	});
	
	function fn_numReIn() {
		$('.numerical ul .counter').eq(3).text($('#artworkYield').val());	// 총 매각 누적 수익률
		$('.numerical ul .counter').eq(4).text($('#allRealPal').val());		// 총 조각거래 실현손익률
		$('.numerical ul .counter').eq(5).text($('#profitLossRate').val());	// 총 조각거래 평가손익률
		$('.numerical ul .counter').eq(7).text($('#clcltYield').val());		// 총 렌탈 수익률
	}

	function fn_resize() {
		// 이미지 팝업 개수
		var popupCnt = $("#popupCnt").val();
		
		if ($(window).width() < 767) { // 모바일
			$("#mainVisualSlider").removeClass("p");
			$("#mainVisualSlider").addClass("m");

			//section2 아트투게더 소개 자동롤링x
			$('section.Section2 .bxslider').bxSlider({
				auto : true,
				speed : 2000,
				pause : 4000,
				mode : 'fade',
				pager : false,
				controls : true,
				touchEnabled :true
			});

			//section bxslider
			$('#mainVisualSlider.m').bxSlider({
				auto : true,
				speed : 600,
				pause: 7000,
				mode : 'fade',
				controls : true,
				pager : true,
				captions : true,
				touchEnabled :true,
				autoHover : false
			});

			//section bxslider
			$('#eventBannerSlider').bxSlider({
				auto : true,
				speed : 1000,
				
				//pause: 5000,
				mode : 'horizontal',
				autoHover : true,
				controls : true,
				touchEnabled : true
			});

			
		

			if ( popupCnt > 1 ){
				//popup bxslider
				$('#cnt223slider .bxslider').bxSlider({
					auto : true,
					pager : true,
					speed : 500,
					pause: 3500,
					mode : 'horizontal',
					autoHover : false,
					controls : true,
					touchEnabled : true
				});
			}
			
			
			

			//티커
			$("#ticker01").liScroll({
				travelocity : 0.04
			});

		} else { // pc
			$("#mainVisualSlider").addClass("p");
			$("#mainVisualSlider").removeClass("m");
					
			//section2 아트투게더 소개 자동롤링x
			$('section.Section2 .bxslider').bxSlider({
				auto : true,
				speed : 2000,
				pause : 4000,
				mode : 'fade',
				pager : false,
				controls : true,
				touchEnabled :true
			});

			//section bxslider
			$('#mainVisualSlider.p').bxSlider({
				/* auto : true,
				speed : 2000,
				pause : 8000,
				mode : 'fade',
				pager : true,
				captions : true,
				touchEnabled : false,
				autoHover : false */
				
				auto : true,
				speed : 600,
				pause: 7000,
				mode : 'fade',
				controls : true,
				pager : true,
				captions : true,
				touchEnabled :false,
				autoHover : false
			});

			//section bxslider
			$('#eventBannerSlider').bxSlider({
				auto : true,
				speed : 1000,
				//pause: 5000, 
				mode : 'horizontal',
				autoHover : true,
				controls : true,
				touchEnabled : false
			});



			if ( popupCnt > 1 ){
				//popup bxslider
				$('#cnt223slider .bxslider').bxSlider({
					auto : true,
					pager : true,
					speed : 500,
					pause: 3500,
					mode : 'horizontal',
					autoHover : true,
					controls : true,
					touchEnabled : false
				});
			}


			

			//티커
			$("#ticker01").liScroll({
				travelocity : 0.10
			});
		}
	}

	/* 실시간 시간 */
	function fn_printClock() {

		var currentDate = new Date(); // 현재시간
		var calendar = currentDate.getFullYear() + "-" + fn_addZeros(currentDate.getMonth() + 1, 2) + "-" + fn_addZeros(currentDate.getDate(), 2) // 거래소 section 현재 날짜
		var currentHours = fn_addZeros(currentDate.getHours(), 2);
		var currentMinute = fn_addZeros(currentDate.getMinutes(), 2);
		var currentSeconds = fn_addZeros(currentDate.getSeconds(), 2);
		
		$('.piece-title').eq(1).text(calendar + " " + currentHours + ":" + currentMinute + ":" + currentSeconds); // 거래소 section 날짜를 출력해 줌

		setTimeout("fn_printClock()", 1000); // 1초마다 fn_printClock() 함수 호출
	}

	function fn_addZeros(num, digit) { // 자릿수 맞춰주기
		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}
		return zero + num;
	}
</script>

</head>

<body>
	
<form id="commonForm" name="commonForm"></form>
	<div class="bg_boxB"></div>
	<div id="wrap">
		

	<script type="text/javascript">
		/* $(function(){
			// 로그인 상태 유지
			if(localStorage.getItem('secureYn') != null
				&& localStorage.getItem('mmbrNo') != null) {
				var comAjax = new ComAjax();
				comAjax.setUrl("/doLogin");
				comAjax.setCallback("fn_doLoginCallback");
				comAjax.addParam("joinTypeCd", '1');
				comAjax.addParam("secureYn", localStorage.getItem('secureYn'));
				comAjax.addParam("mmbrNo", localStorage.getItem('mmbrNo'));
				comAjax.ajax();
			}
		});
	
		if (localStorage.getItem('secureYn') != null
				&& localStorage.getItem('mmbrNo') != null) {
			function fn_doLoginCallback(data) {
				if (data.result) {
					var fromUri = document.referer;
					if (fromUri == "" || fromUri == "null" || fromUri == null) {
						fromUri = "/";
					}
					document.location.href = fromUri;
				} else {
					//alert(data.resultMsg);
				}
			}
		} */
	</script>

<script>
	$(function() {
		$(".gnb .gnbMenu").css({
			"right" : "-90%"
		});
		/*메뉴버튼*/
		$("#mnav-btn").click(function() {
			$(".gnb .gnbMenu").stop(true, true).animate({
				"right" : 0
			});
			$("#mnav-btn").css({
				"display" : "none"
			});
			$(".bg_boxB").css({
				"display" : "block"
			});
		});
		/*닫기버튼*/
		$(".gnb .close-btn, .bg_boxB").click(function() {
			$(".gnb .gnbMenu").stop(true, true).animate({
				"right" : "-90%"
			});
			$("#mnav-btn").css({
				"display" : "block"
			});
			$(".bg_boxB").css({
				"display" : "none"
			});
		});

		/*모바일스크*/
		$("body").css({
			overflow : 'hidden'
		}).bind("tochmove", function(e) {
			e.preventDefault()
		});
		$("body").css({
			overflow : ""
		}).unbind("tochmove");

		fn_headerSubMenuEvent();

		// 창 리사이징
		$(window).resize(function() {
			fn_headerSubMenuEvent();
		});
	});

	function fn_headerSubMenuEvent() {
		if ($(window).width() > 1200) {
			$("#header .gnb > .gnbMenu > .cl-m").removeClass("m");
			
			$("#header .gnb .gnbMenu").on("mouseenter", function() {
				$("#header .gnb .gnbMenu > li .smenu").show();
				$("#header .bg_box").show();
			});

			$("#header .gnb .gnbMenu").on("mouseleave", function() {
				$("#header .gnb .gnbMenu > li .smenu").hide();
				$("#header .bg_box").hide();
			});
			
			//메인 gnb메뉴 슬라이드다운업-피씨테블릿일때만
			/* $(".gnbMenu").on("mouseenter", function() {
				$(this).find("li>.smenu").show();
				$(".bg_box").show();
			});
			$("#header").on("mouseleave", function() {
				$(this).find("li>.smenu").hide();
				$(".bg_box").hide();
			});
			$(".gnb>.gnbMenu>li.cl-m").off("click"); */
		} else {
			$("#header .gnb .gnbMenu").off("mouseenter");
			$("#header .gnb .gnbMenu").off("mouseleave");

			$("#header .gnb > .gnbMenu > .cl-m").addClass("m");

			var toggle = true;
			$("#header .gnb > .gnbMenu > .cl-m.m").on("click", function() {
				if( toggle ) {
					toggle = false;
					$(this).find(".smenu-m").show();
					
				}else {
					toggle = true;
					$(this).find(".smenu-m").hide();
				}
			});
			
			/* $(".gnbMenu").off("mouseenter");
			$(".gnbMenu").off("mouseleave");
			$("#header").off("mouseenter");
			$("#header").off("mouseleave");

			//모바일토글
			$(".gnb>.gnbMenu>li.cl-m").on("click", function() {
				$("ul.smenu-m", this).stop(true, true).toggle();
				$(this).find(">a>span").toggleClass("arrow");
			}); */
		
			$("#logoutSmmryDiv").show();
		
		}
	}

	function fn_goLogin() {
		alert('로그인 후 이용 가능합니다.');
		location.href = '/login';
	}

	function fn_logOut() {
		localStorage.removeItem('mmbrNo');
		localStorage.removeItem('secureYn');
		location.href = '/logout';
	}

	function fn_selectMmbrSmmryInfo() {
		var comAjax = new ComAjax();
		comAjax.setUrl("/selectMmbrSmmryInfo");
		comAjax.setCallback("fn_selectMmbrSmmryInfoCallback");
		comAjax.ajax();
	}

	function fn_selectMmbrSmmryInfoCallback(data) {
		gfn_setDataText(data.map, "loginSmmryDiv");
	}
</script>
<script>
	$(function(){
		var $headerBoxGnb = $("#headerBox .headerBox-in .headerBox-gnb");
		var $headerBoxGnbBg = $("#headerBox .headerBox-in .headerBox-gnb-bg");
	
		$("#sideNavOpenBtn").off().on("click", function(){
			$headerBoxGnb.stop().animate({"right" : "0"}, 300);
			$headerBoxGnbBg.fadeIn(400);

			fn_headerSubMenuEvent();
		});
		$(".sideNavClose").off().on("click", function(){
			$headerBoxGnb.stop().animate({"right" : "-100%"}, 300);
			$headerBoxGnbBg.fadeOut(0);

			fn_headerSubMenuEvent();
		});
		
		fn_headerSubMenuEvent();
		// 창 리사이징
		$(window).resize(function() {
			fn_headerSubMenuEvent();
		});
	});
	
	function fn_headerSubMenuEvent() {
		var $headerBoxGnb = $("#headerBox .headerBox-in .headerBox-gnb");
		var $headerBoxGnbBg = $("#headerBox .headerBox-in .headerBox-gnb-bg");
	
		var width = $(window).width();

		if ( $headerBoxGnbBg.css("display") == "block" ){
			$("body").css("overflow-y", "hidden");
		}else {
			$("body").css("overflow-y", "auto");
		}
	
		if ( width > 1024 ) {
			$("#headerBox .headerBox-in .headerBox-gnb .headerBox-gnb-list .li.drop").removeClass("m");
			$headerBoxGnb.css({"right" : "-100%"});
			$headerBoxGnbBg.fadeOut(0);
			$("#headerBox .headerBox-in .headerBox-gnb .headerBox-gnb-list .li .sub-menu-list").slideUp(0);
		}
		else {
			$("#headerBox .headerBox-in .headerBox-gnb .headerBox-gnb-list .li.drop").addClass("m");
			$("#headerBox .headerBox-in .headerBox-gnb .headerBox-gnb-list .li.drop.m").off().on("click", function(){
				$(this).find(".sub-menu-list").stop().slideToggle(250);
			});
			
			
		}
	}
</script>
	



<!-- header -->
<header id="headerBox">
	 <div class="headerBox-in clearfix">
		<section class="headerBox-logo">
			<a href="/" class="img">logo</a>
		</section>
		
		<div class="headerBox-gnb-bg sideNavClose"></div>
		<section class="headerBox-gnb">
			<div id="loginSmmryDiv" class="headerBox-info">
				<div class="cont mb30 clearfix">
					<div class="left">
						<a href="/" class="home">홈</a>
					</div>
					<div class="right">
					
						<a href="#" class="close sideNavClose">x</a>
					</div>
				</div>
				<div class="cont">
					<div class="info">
					
						
						<p class="plz-login">로그인이 필요합니다.</p>
						
					
					</div>
					<div class="bottom clearfix">
						<div class="left">
						
							
							<a href="/login" class="login-text">
								<span>로그인</span> <span class="ic-power"><img src="/images/fo/loginicons.svg" alt=""></span>
							</a>
							
						
						</div>
						<div class="right">
						
							
							<a href="/join" class="join">회원가입</a>
							
						
						</div>
					</div>
				</div>
			</div>
			
			<!-- gnb -->
			

<ul class="headerBox-gnb-list clearfix">
	<li class="li drop">
		<a href="/about" class="link">아트투게더</a>

		<ol class="sub-menu-list">
			<li>
				<a href="/about">아트투게더 소개</a>
			</li>
			<li>
				<a href="/notice">공지사항</a>
			</li>
			<!-- <li>
				<a href="/media">언론보도</a>
			</li> -->
			<li>
				<a href="/cs">고객지원</a>
			</li>
		</ol>
	</li>
	<li class="li drop">
		<a href="/goods" class="link">공동구매</a>

		<ol class="sub-menu-list">
			<li>
				<a href="/goods">공동구매</a>
			</li>
			<!--  <li>
				<a href="/ownership">소유자현황</a>
			</li> -->
		</ol>
	</li>
    <li class="li drop">
        <a href="/market" class="link">조각거래소</a>
        
        <ol class="sub-menu-list">
            <li>
                <a href="/market">조각거래소</a>
            </li>
        </ol>
        
    </li>
    <li class="li drop">
        <a href="/rentalProduct" class="link">렌탈</a>

        <ol class="sub-menu-list">
            <li>
                <a href="/rentalGuide">렌탈안내</a>
            </li>
            <li>
                <a href="/rentalProduct">렌탈상품</a>
            </li>
            <li>
                <a href="/rentalStatus">렌탈현황</a>
            </li>
        </ol>
    </li>
	<li class="li drop">
		<a href="/mall" class="link">아트몰</a>
			
		<ol class="sub-menu-list">
            <li>
                <a href="/mall">아트몰</a>
            </li>
        </ol>
	</li>
    <li class="li drop">
        <a href="javascript:void(0);" class="link">경매</a>
        <ol class="sub-menu-list">
            <li>
                <a href="/auctionGuide">응찰안내</a>
            </li>
            <li>
                <a href="/currentAuction">진행중인 경매 <!-- <span class="auction-now">Now</span> --> </a>
            </li>
            <li>
                <a href="/auctionNumber">지난 경매</a>
            </li>
        </ol>
	</li>
	<li class="li drop">
		<a href="/consignmentGuide" class="link">작품위탁</a>
			
		<ol class="sub-menu-list">
            <li>
                <a href="/consignmentGuide">작품위탁</a>
            </li>
        </ol>
	</li>
</ul>
			 <!-- //gnb -->
		</section>
		
		<section class="headerBox-login">
			
		
			
			<a href="/join" class="link">JOIN</a>
			<a href="/login" class="link">LOGIN</a>
			
		
			
			<div id="sideNavOpenBtn" class="ic-menu">
				<span class="line"></span>
				<span class="line"></span>
				<span class="line"></span>
			</div>
		</section>
	</div>
</header>
<!-- //header --> 

		<!--메인 팝업 -->
		<div class="popup">
			<div class="cnt223">
				<div id="cnt223slider">
					<input type="hidden" id="popupCnt" value="2" >
					<ul class="bxslider"> 
						
							
								<li>
									<h1>카우스 작품 100만원 이상 구매고객 대상 구매금액 2% 상품권 증정</h1>
									<img class="cnt223-in-img" src="/file/img/popup/3/20200729153502077daea3-1ea1-438e-9517-500d6a086374.png" />
									<div style='text-align:center;'><button><a href="noticeDetail/79">바로가기</a></button></div>
								</li>
							
								<li>
									<h1>카우스10set 리뷰이벤트</h1>
									<img class="cnt223-in-img" src="/file/img/popup/2/20200727181609ce73748b-5816-4204-b9e5-a5285a0a3ab9.png" />
									<div style='text-align:center;'><button><a href="noticeDetail/78">바로가기</a></button></div>
								</li>
							
						
					</ul>
				</div>
				<div class="cnt223-bottom">
					<div class="agree-cont-in">
                        <input class="styled-checkbox" id="checkbox-1" type="checkbox" required>
                        <label for="checkbox-1">오늘은 다시 보지 않기</label>
                    </div>
					<a rel="modal:close"><img class="close" src="/images/fo/close.png" alt="ic_close"></a>
				</div>
			</div>
		</div>

		<!--메인-->
		<section class="Main-section">
			<div id="slideShow"> <!-- 메인슬라이드이미지 -->
			<div class="slide">
				<ul id="mainVisualSlider" class="bxslider">
					
						
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/47/202007241724243b944f5d-b90c-4dce-bc4c-fc17bc5dcbae.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>Blame game(complete set of 10 prints)</h1>
											<h2>카우스 KAWS</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 28.1%"></span></div>
											<div class="bar-text"><p>4,414 / 15,702 조각</p><h4>28.1%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년07월28일 ~ 20년08월27일</span>
											</div>
											
												
												
													<div class="Right-box-right"><a href="/goodsDetail/50">공동구매 참여하기</a></div>
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
														물방울
													
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
													
														Butterfly Effect
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/46/202007231636479ed22df8-3c57-470d-b79b-6abe7beb2b74.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>Butterfly Effect</h1>
											<h2>마리킴 Mari Kim</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 100.0%"></span></div>
											<div class="bar-text"><p>1,041 / 1,041 조각</p><h4>100.0%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년07월24일 ~ 20년07월24일</span>
											</div>
											
												
													<div class="Right-box-right"><a href="/market/49">조각거래소 바로가기</a></div>
												
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
													
														Blame game(complete set of 10 prints)
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
													
														Le Beau Temps
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/45/202007151443405d272823-942c-4006-a71b-8d894a7629bd.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>Le Beau Temps</h1>
											<h2>만 레이 Man Ray</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 100.0%"></span></div>
											<div class="bar-text"><p>479 / 479 조각</p><h4>100.0%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년07월16일 ~ 20년07월16일</span>
											</div>
											
												
													<div class="Right-box-right"><a href="/market/48">조각거래소 바로가기</a></div>
												
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
													
														Butterfly Effect
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
													
														Still Life with Blonde
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/44/202007091938200b81b7b2-a6c7-48fa-a639-b8092fe40623.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>Still Life with Blonde</h1>
											<h2>톰 웨슬만 Tom Wesselmann</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 100.0%"></span></div>
											<div class="bar-text"><p>684 / 684 조각</p><h4>100.0%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년07월10일 ~ 20년07월10일</span>
											</div>
											
												
													<div class="Right-box-right"><a href="/market/47">조각거래소 바로가기</a></div>
												
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
													
														Le Beau Temps
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
													
														Pumpkin(White T)
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/43/2020070318271316888948-3999-4163-a27d-f736ef65545e.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>Pumpkin(White T)</h1>
											<h2>쿠사마 야요이 Yayoi Kusama</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 100.0%"></span></div>
											<div class="bar-text"><p>4,650 / 4,650 조각</p><h4>100.0%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년07월07일 ~ 20년07월07일</span>
											</div>
											
												
													<div class="Right-box-right"><a href="/market/46">조각거래소 바로가기</a></div>
												
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
													
														Still Life with Blonde
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
													
														Flowers From the Village of Ponkotan
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/41/20200616183138c1fc1929-d6b1-4a98-ace0-6c8144352df4.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>Flowers From the Village of Ponkotan</h1>
											<h2>다카시 무라카미 Takashi murakami</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 100.0%"></span></div>
											<div class="bar-text"><p>194 / 194 조각</p><h4>100.0%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년06월18일 ~ 20년06월18일</span>
											</div>
											
												
													<div class="Right-box-right"><a href="/market/44">조각거래소 바로가기</a></div>
												
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
													
														Pumpkin(White T)
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
													
														Stars and Stripes
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/38/20200520105738c3b785d2-d59a-42e3-a2d6-9de61f6516d8.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>Stars and Stripes</h1>
											<h2>알렉산더 칼더 Alexander Calder</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 100.0%"></span></div>
											<div class="bar-text"><p>335 / 335 조각</p><h4>100.0%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년05월22일 ~ 20년05월22일</span>
											</div>
											
												
													<div class="Right-box-right"><a href="/market/42">조각거래소 바로가기</a></div>
												
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
													
														Flowers From the Village of Ponkotan
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
													
														물방울
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
							<li class="m1">
								<div class="m-in-content">
									<div class="in-content-left">
										<div class="in-content-left-img">
											<img src="/file/img/artWork/37/2020051211035555bd08d9-bc62-48f4-841a-8951c6c49fbf.jpg" alt="product-img" title="공동구매 작품 이미지입니다.">
										</div>
									</div>
									<div class="in-content-right">
										<div class="in-content-right-box1">
											<p><img src="/images/fo/Art-Together.png" alt="Art-Together.png"></p>
											<h1>물방울</h1>
											<h2>김창열 TschangYeul Kim</h2>
										</div>
										
										<!--모집바-->
										<div class="content-ing-bar">
											<div class="bar-all"><span class="bar-in" style="width: 100.0%"></span></div>
											<div class="bar-text"><p>5,000 / 5,000 조각</p><h4>100.0%</h4></div>
										</div>
										
										<div class="in-content-right-box2">
											<div class="Right-box-left">
												<p>모집기간</p>
												<span>20년05월15일 ~ 20년06월14일</span>
											</div>
											
												
													<div class="Right-box-right"><a href="/market/41">조각거래소 바로가기</a></div>
												
												
											
										</div>
										
										<div class="main-prev">
											<p class="prevnext">
												<img src="/images/fo/ic-arrow-left.png">
												
													
													
														Stars and Stripes
													
												
											</p>
										</div>
										<div class="main-next">
											<p class="prevnext">
												
													
														Blame game(complete set of 10 prints)
													
													
												
												<img src="/images/fo/ic-arrow-right.png">
											</p>
										</div>
									</div>
								</div>
							</li>
						
					
				</ul>
			</div>
		</div>
		
		<article id="prev"></article>
		<article id="nex"></article>
		</section>
		
		
		<!-- 누적수치 -->
		<section class="Section numerical">
			<div id="particles">
			  <div id="intro">
			    <div class="intro-in">
			    	
			    	
			    	
			    	
			    	<h1><span class="counter">639</span>일 동안</h1>
			    	<h2>아트투게더 누적 거래현황</h2>
			    	<p>2020.07.31 기준</p>
			    	<ul>
			    		<li>
			    			<span class="numer-top">총 판매금액</span>
			    			<span class="ic-info tooltip">
								<i class="fas fa-question-circle"></i>
								<span class="tooltip-text" style="display: none;">
									공동구매 모집 작품<br>+ 조각거래
								</span>
							</span>
			    			<p><span class="counter">1,502,572,968</span> <span class="numer-bottom">KRW </span></p>
			    		</li>
			    		<li><span class="numer-top">총 판매조각 수</span>
			    			<span class="ic-info tooltip">
								<i class="fas fa-question-circle"></i>
								<span class="tooltip-text" style="display: none;">
									공동구매 + 조각거래
								</span>
							</span>
							<p><span class="counter">147,367</span> <span class="numer-bottom">조각</span></p>
						</li>
			    		<li>
			    			<span class="numer-top">총 매각작품 수</span>
			    			<p><span class="counter">4</span> <span class="numer-bottom">작품</span></p>
			    		</li>
			    		<li>
			    			<span class="numer-top">총 매각 누적 수익률</span>
			    			<span class="ic-info tooltip">
								<i class="fas fa-question-circle"></i>
								<span class="tooltip-text" style="display: none;">
									최초 공동구매가 대비 매각수익률 (플랫폼 이용료 + 부가세 제외)
								</span>
							</span>
			    			<input type="hidden" id="artworkYield" value="30.10" >
			    			<p><span class="counter">0.00</span> <span class="numer-bottom">%</span></p>
			    		</li>
			    		<li>
			    			<span class="numer-top">총 조각거래 실현손익률</span>
			    			<span class="ic-info tooltip">
								<i class="fas fa-question-circle"></i>
								<span class="tooltip-text" style="display: none;">
									조각거래소를 통해 판매를 완료한<br>거래에 대한 수익률 입니다.
								</span>
							</span>
							<input type="hidden" id="allRealPal" value="13.05" >
			    			<p><span class="counter">0.00</span> <span class="numer-bottom">%</span></p>
			    		</li>
			    		<li>
			    			<span class="numer-top">총 조각거래 평가손익률</span>
			    			<span class="ic-info tooltip">
								<i class="fas fa-question-circle"></i>
								<span class="tooltip-text" style="display: none;">
									공동구매 모집 시작가 대비 조각거래소 현재가에 대한 수익률 입니다.
								</span>
							</span>
							<input type="hidden" id="profitLossRate" value="19.03" >
							<p><span class="counter">0.00</span> <span class="numer-bottom">%</span></p>
			    		</li>
			    		
			    	</ul>
			    </div>
			  </div>
			</div>
		</section>

		<!--이벤트+배너-->
		<section class="Section">
			<div class="Section-in clear">
				<div class="banner-rolling">
					<ul id="eventBannerSlider" >
					
						
							<li>
								<a href="noticeDetail/79">
									<img src="/file/img/banner/pc/202007291523388210b6e2-d4b9-49b1-8f4d-4c2553e39141.png" alt="rental-banner" title="카우스 작품 100만원 이상 구매고객 대상 구매금액 2% 상품권 증정">
								</a>
							</li>
						
							<li>
								<a href="noticeDetail/78">
									<img src="/file/img/banner/pc/20200727181121b08fef2a-09da-4304-acb1-8f1c30c1e4a0.png" alt="rental-banner" title="카우스10set 리뷰이벤트">
								</a>
							</li>
						
							<li>
								<a href="noticeDetail/82">
									<img src="/file/img/banner/pc/20200731181553c8b65880-0aac-4854-9e75-8e000e4bfdac.png" alt="rental-banner" title="8월신규회원이벤트">
								</a>
							</li>
						
							<li>
								<a href="/noticeDetail/57">
									<img src="/file/img/banner/pc/2020060115383345f78139-078f-40b3-b8e5-e00faba04c92.png" alt="rental-banner" title="아트몰 오픈 안내 배너">
								</a>
							</li>
						
							<li>
								<a href="https://www.weshareart.com/noticeDetail/70">
									<img src="/file/img/banner/pc/202007031454166a48127d-1c6e-415f-acda-e8d42b9ec0ef.png" alt="rental-banner" title="[아트몰] 타셴 아트북 5%할인 이벤트">
								</a>
							</li>
						
					
					
					</ul>
				</div>
	
				<div class="banner-fixed-box">
					
						
							<!-- 수정코드 -->
							<div class="banner-fixed">
								<div><img src="images/fo/notice-icon.png"><h1>공지사항</h1><a href="/notice"><p>전체보기 &gt;</p></a></div>
								<ul>
									
										
											
												<li><a href="/noticeDetail/82"><span class="ing-notice">진행중</span>8월 맞이 신규 회원 3000원 쿠폰 지급 이벤트!</a></li>
											
											
										
									
										
											
												<li><a href="/noticeDetail/81"><span class="ing-notice">진행중</span>이우환 <dialogue> 6개월 간 수익률 20.67% 달성안내</a></li>
											
											
										
									
										
											
												<li><a href="/noticeDetail/79"><span class="ing-notice">진행중</span>카우스 작품 100만원 이상 구매고객 대상 구매금액 2% 상품권 증정</a></li>
											
											
										
									
										
											
												<li><a href="/noticeDetail/78"><span class="ing-notice">진행중</span>카우스 <Blame Game (complete set)> 작품구매 리뷰 작성하면 선물 증정</a></li>
											
											
										
									
										
											
												<li><a href="/noticeDetail/70"><span class="ing-notice">진행중</span>[아트몰] 타셴 아트북 판매 기념 5%할인 이벤트</a></li>
											
											
										
									
										
											
											
												<li><a href="/noticeDetail/80">[공지] 아트투게더 창립기념일 서비스 이용 안내</a></li>
											
										
									
								</ul>
							</div>
						
						
					
				</div>
			</div>
		</section>
		
		

 


<script>
</script>

<!--아트투게더 소개 ->카테고리연결--> 
<section class="Section Section2">
	<div class="bxslider">
		
			<div class="section2-box">
			   <div class="section2-main">
					<div class="section2-top">
						<h1>아트투게더는 다양한 형태로<br><span>미술품을 구매하고 소유할 수 있는 플랫폼</span> 입니다.</h1>
						<div class="product-go-btn"><a href="/goods">공동구매 바로가기</a></div>
					</div>
					<div class="section2-bottom">
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/47/202007241724243b944f5d-b90c-4dce-bc4c-fc17bc5dcbae.jpg"></div></div>
								<p>카우스 <span>Blame Game(complete set of 10 prints)</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/46/202007231636479ed22df8-3c57-470d-b79b-6abe7beb2b74.jpg"></div></div>
								<p>마리킴 <span>Butterfly Effect</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/45/202007151443405d272823-942c-4006-a71b-8d894a7629bd.jpg"></div></div>
								<p>만 레이 <span>아름다운 나날들(Le Beau Temps )</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/44/202007091938200b81b7b2-a6c7-48fa-a639-b8092fe40623.jpg"></div></div>
								<p>톰 웨슬만 <span>Still Life with Blonde</span></p>
							</div>
						
					</div>
				</div>
				<div class="section2-color"></div>
			</div>
		

		
			<div class="section2-box section2-box-p-color">
			   <div class="section2-main">
					<div class="section2-top section2-top2">
						<h1>렌탈 서비스를 통한 <br><span>수익금과 추가혜택</span>을 받아보세요.</h1>
						<div class="product-go-btn product-go-btn2"><a href="/rentalProduct">렌탈 바로가기</a></div>
					</div>
					<div class="section2-bottom">
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/44/202007091938200b81b7b2-a6c7-48fa-a639-b8092fe40623.jpg"></div></div>
								<p>톰 웨슬만 <span>Still Life with Blonde</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/43/2020070318271316888948-3999-4163-a27d-f736ef65545e.jpg"></div></div>
								<p>쿠사마 야요이 <span>Pumpkin(White T)</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/41/20200616183138c1fc1929-d6b1-4a98-ace0-6c8144352df4.jpg"></div></div>
								<p>다카시 무라카미 <span>Flowers From the Village of Ponkotan</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/artWork/38/20200520105738c3b785d2-d59a-42e3-a2d6-9de61f6516d8.jpg"></div></div>
								<p>알렉산더 칼더 <span>Stars and Stripes</span></p>
							</div>
						
					</div>
				</div>
				<div class="section2-color section2-color2"></div>
			</div>
		

		
			<div class="section2-box">
			   <div class="section2-main">
					<div class="section2-top section2-top3">
						<h1>좋아하는 작품을 <span>합리적인 가격</span>에 구매하고<br>집에서도 즐겁게 감상해보세요.</h1>
						<div class="product-go-btn product-go-btn3"><a href="/mall">아트몰 바로가기</a></div>
					</div>
					<div class="section2-bottom">
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/mall/prdct/8/20200702133334f5f5e06f-2b26-4554-84ca-4b940ea0dd91.png"></div></div>
								<p>Taschen(타셴) <span>Yoshitomo Nara</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/mall/prdct/7/202007021332508693d0f0-ce58-482b-8eeb-756462aa60e8.png"></div></div>
								<p>Taschen(타셴) <span>David Hockney. My Window (Collector's Edition)</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/mall/prdct/6/20200702133231a47b75c6-e0bc-44ba-9716-27ea3dd9251b.jpg"></div></div>
								<p>Taschen(타셴) <span>David Hockney. A Bigger Book (Collector’s Edition)</span></p>
							</div>
						
							<div class="bottom-boxs">
								<div class="white-box"><div class="bottom-img-box"><img src="/file/img/mall/prdct/5/2020052816565928b85360-03c8-4f96-b292-382584fcd8ea.jpg"></div></div>
								<p>프린트베이커리 <span>Un Passage 17</span></p>
							</div>
						
					</div>
				</div>
				<div class="section2-color section2-color3"></div>
			</div>
		
						
		
	</div>
</section>


	<!-- 조각거래소 -->
	<section class="Section Section3piece">
		<article class="piecemarket">
			<div class="piecemarket-margin">
				<h1 class="piece-title">PIECEMARKET<span>(조각거래소)</span></h1><p class="piece-title">2020-06-17 18:20</p>
				<a href="/market/30">
					<ul class="piece-top1 clear">
						<li>
							<p><span>TOP</span>최다 거래 작품</p>
						</li>
						<li class="clear">
							<div><img src="/file/img/goods/30/thumbnail/202004271552591782dfd8-21da-4a37-a413-5ecceaa6a6d5.jpg"></div>
							<h2>Red Hat</h2>
							<h3>마리킴</h3>
						</li>
						<li>
							
								<p><span class="triangle-red"></span>+ 10.00%</p>
							
							
							<h4>11,000<span>KRW</span></h4>
						</li>
					</ul>
				</a>
				<ul class="piece-text">
					<li><p>총 누적 거래 조각 수</p><h1>2,591<span>조각</span></h1></li>
					<li><p>총 누적 거래 작품 수</p><h1>38<span>작품</span></h1></li>
					<li class="color-fff"><p>총 누적 거래 금액</p><h1>31,823,523<span>KRW</span></h1></li>
				</ul>
			</div>
			
			<article class="piece-rolling">
	            <div class="main-exchange">
	                <ul class="clear"  id="ticker01">
	                	
	                		<a href="/market/30"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/30/thumbnail/202004271552591782dfd8-21da-4a37-a413-5ecceaa6a6d5.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Red Hat</h2>
		                    		<h3>마리킴 Mari Kim</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/3"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/3/thumbnail/202004271459577cf9682a-bf1d-4d9e-af27-b683a47514c2.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>줄리안 오피_Sara Dancing 1</h2>
		                    		<h3>줄리안 오피 Julian Opie</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/27"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/27/thumbnail/2020042715521701c6898d-b43c-4928-93e9-7c1c1c4f31dc.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Quadriptyque 4-4</h2>
		                    		<h3>이배 Bae Lee</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/39"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/39/thumbnail/20200427150815d7fd9801-f2f3-44d1-9a51-948262200d87.png"></div>
		                    	<div class="rolling-right">
		                    		<h2>Untitled(middle panel from Triptych August 1972)</h2>
		                    		<h3>프란시스 베이컨 Francis Bacon</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/26"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/26/thumbnail/20200427155204327dbcd3-c856-4537-ab08-b3fa8dae132e.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Quadriptyque 4-3</h2>
		                    		<h3>이배 Bae Lee</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 9.00%</span>10,900<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/35"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/35/thumbnail/2020042715541238b58734-314b-48f4-87fa-32358d220073.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>From Point</h2>
		                    		<h3>이우환 Lee U Fan</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 19.00%</span>11,900<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/12"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/12/thumbnail/20200427151728afe954b6-de2c-449b-ad0b-36f73c949506.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Happy</h2>
		                    		<h3>에바 알머슨 Eva Armisén</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/16"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/16/thumbnail/20200427152846e571672f-4a5c-49e4-96a8-7038725c59e3.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Stone Book</h2>
		                    		<h3>고영훈 Younghoon Ko</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/20"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/20/thumbnail/202004271548255e554c64-5811-4fb4-ac71-433bca6955f3.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>해피월드</h2>
		                    		<h3>강익중 Ikjoong Kang</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/41"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/41/thumbnail/2020051517003636b9b3be-40bd-41e4-89da-b1d7147678d7.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>물방울</h2>
		                    		<h3>김창열 TschangYeul Kim</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/46"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/46/thumbnail/2020070318311032c363e0-5170-4b23-b4b1-277ff4286e96.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Pumpkin(White T)</h2>
		                    		<h3>쿠사마 야요이 Yayoi Kusama</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 20.00%</span>12,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/38"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/38/thumbnail/20200427150735d959fa1b-9f0e-4285-bff5-88dda857fc40.png"></div>
		                    	<div class="rolling-right">
		                    		<h2>Blame game</h2>
		                    		<h3>카우스 KAWS</h3>
		                    		
		                    			
		                    			
		                    				<h4><span class="percent">0.00%</span>10,000<span class="krw">KRW</span></h4>
		                    			
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/22"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/22/thumbnail/20200427154922099e3553-c942-46fb-b5a9-6dc0612b6103.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Cohesive Sphere - 0026</h2>
		                    		<h3>지근욱 Keunwook Ji</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/33"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/33/thumbnail/2020042715534312f93122-19d6-489a-a241-b7e0742455cc.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Commune with...</h2>
		                    		<h3>두민 x 이메진 AI Do  Min x Imagine AI</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 15.00%</span>11,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/18"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/18/thumbnail/202004271543450f8913eb-5457-4854-abea-c83731c99bc8.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Seen 201212</h2>
		                    		<h3>강세경 Sekyung Kang</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 15.00%</span>11,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/19"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/19/thumbnail/2020042715475571ddc5bc-1ed1-4a09-a932-406af955aca2.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Instant Landscape</h2>
		                    		<h3>김남표 Nampyo Kim</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/32"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/32/thumbnail/2020042715532934e5ffc9-3ce6-4267-b798-b47fe168ac32.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Commune with... </h2>
		                    		<h3>두민 x 이메진 AI Do  Min x Imagine AI</h3>
		                    		
		                    			
		                    			
		                    				<h4><span class="percent">0.00%</span>10,000<span class="krw">KRW</span></h4>
		                    			
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/21"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/21/thumbnail/2020042715485288e87b33-d43c-4ac2-8a21-bf36b60b0151.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Untitled</h2>
		                    		<h3>미스터 브레인워시 Mr.Brainwash(Thierry Guetta)</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 20.00%</span>12,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/13"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/13/thumbnail/202004271519157244f7d5-c57d-43b8-a4ba-6e8e0f6b7bfe.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>시고(詩稿)</h2>
		                    		<h3>추사 김정희 JungHee Kim</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/24"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/24/thumbnail/20200427155036fc96f92e-1018-4d3f-a7d6-4d5b250d7652.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>An Homage to monopink 1960 A</h2>
		                    		<h3>다카시 무라카미 Takashi murakami</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 15.00%</span>11,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/40"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/40/thumbnail/202005081054491e059a44-7e2d-431a-a944-30574cb755c1.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>[핀크앱 전용] Love 311</h2>
		                    		<h3>앤디 워홀 Andy Warhol</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 20.00%</span>12,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/10"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/10/thumbnail/202004271513045c4e1bd7-a166-43b7-b2ba-590918e13a14.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Follow Your Dreams</h2>
		                    		<h3>미스터 브레인워시 Mr.Brainwash(Thierry Guetta)</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/15"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/15/thumbnail/202004271527184ad10e45-74e3-479d-8a01-161492b20eb6.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Halte de Comediens ambulants avec Hibou</h2>
		                    		<h3>파블로 피카소 Pablo Picasso</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 99.00%</span>19,900<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/31"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/31/thumbnail/20200427155313eb13d20a-2ac9-45ed-ae43-db2c33726d44.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>A Dream</h2>
		                    		<h3>데미안 허스트 Damien Hirst</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/29"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/29/thumbnail/202004271615516dce2093-54e8-44a9-870b-f865ffde0df7.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Untitled</h2>
		                    		<h3>홍성준 SeongJoon Hong</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/14"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/14/thumbnail/202004271522479bd793d4-b3b4-442a-80ff-951033835f52.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>묵란도(墨蘭圖)</h2>
		                    		<h3>소치 허련 Ryun Huh</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/28"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/28/thumbnail/20200427155232a6393fbc-5e1c-470b-84b6-9fc55455c849.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>JUST ANOTHER CROCODILE BIRD</h2>
		                    		<h3>홍성준 SeongJoon Hong</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/37"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/37/thumbnail/202004271554445ee851cd-8121-48ed-95b2-150022744edd.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>산(山)</h2>
		                    		<h3>월전 장우성 Woosung Chang</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/25"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/25/thumbnail/202004271551432a919472-a71b-459a-b9ce-3e63bb656942.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>The boundary of Fantasy</h2>
		                    		<h3>두민 Do Min</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 25.00%</span>12,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/44"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/44/thumbnail/20200616185044f5269026-2e2a-4ba4-a06b-35d3324aab19.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Flowers From the Village of Ponkotan</h2>
		                    		<h3>다카시 무라카미 Takashi murakami</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 20.00%</span>12,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/36"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/36/thumbnail/202004271554286d579fa6-59f3-4f0d-85c8-30a9f770c5b6.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Reencontrarme Reconocerme</h2>
		                    		<h3>에바 알머슨 Eva Armisén</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 211.00%</span>31,100<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/17"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/17/thumbnail/20200427153447971e7547-680f-4614-92a7-1fa639762dc1.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Un Passage</h2>
		                    		<h3>하태임 Taeim Ha</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 5.00%</span>10,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/49"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/49/thumbnail/20200723163832ddccd9ff-e646-4821-9c2e-00c8bb5f22a9.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Butterfly Effect</h2>
		                    		<h3>마리킴 Mari Kim</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 2.00%</span>10,200<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/42"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/42/thumbnail/202005201108462c931f21-3f71-450f-8496-e381b3a33955.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Stars and Stripes</h2>
		                    		<h3>알렉산더 칼더 Alexander Calder</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 24.00%</span>12,400<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/48"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/48/thumbnail/20200715144446fc7a51a5-2f37-4e9a-b2ed-a6e41bebd5bb.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Le Beau Temps</h2>
		                    		<h3>만 레이 Man Ray</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 20.00%</span>12,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/9"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/9/thumbnail/202004271506204f69dab7-8a6a-42ce-ac32-f23b03ea0540.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Love Is The Answer</h2>
		                    		<h3>미스터 브레인워시 Mr.Brainwash(Thierry Guetta)</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 25.00%</span>12,500<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                		<a href="/market/47"><li>
		                    	<div class="rolling-left"><img src="/file/img/goods/47/thumbnail/20200709193916b762d802-2720-4c63-9e0e-ddbd2f32d716.jpg"></div>
		                    	<div class="rolling-right">
		                    		<h2>Still Life with Blonde</h2>
		                    		<h3>톰 웨슬만 Tom Wesselmann</h3>
		                    		
		                    			
		                    			
		                    			
		                    				<h4><span class="percent redcolor"><span class="triangle-red"></span>+ 10.00%</span>11,000<span class="krw">KRW</span></h4>
		                    			
		                    		
		                    	</div>
		                    </li></a>
	                	
	                </ul>
	            </div>
	        </article>
	        
	        <div class="notice-check" style="max-width:1200px; margin:0 auto; width:100%;">
	        	<p><span class="re-red">*</span> 최초 공동구매가 대비 등락률 입니다.</p>
	        </div>
	        
	        <div style="max-width:1200px; margin:0 auto; width:100%; text-align: center;">
	        	<button class="market-direct"><a href="/market">조각거래소 바로가기</a></button>
	        </div>
		</article>
	</section>
</div>

</body>
</html>