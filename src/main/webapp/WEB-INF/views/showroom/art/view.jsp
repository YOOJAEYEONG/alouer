<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



<!DOCTYPE html>
<html>
<head>
<!-- Meta Tags -->
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0" />
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="pragma" content="no-cache" />

<!-- End Meta Tags -->
<title>${info.name }| ${info.title }</title>

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	var user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36';
	var device_type = 0; // default - web

	if ('' === 'com.opengallery.androidapp') {
		device_type = 1; // android
	} else if (user_agent.indexOf('opengalleryiosapp') !== -1) {
		device_type = 2; // ios
	}
	var uKey = 0;
	dataLayer = [ {
		'uKey' : uKey,
		'deviceType' : device_type,
		'userAgent' : user_agent
	} ];
	

	var pageTitle = $(document).find("title").text(); 
	document.getElementById('pageTitle').text($(document).find("title").text());
	console.log(pageTitle);

</script>
<sec:authorize access="isAuthenticated()" var="isAuth">
	<sec:authentication property="principal.username" var="memberId" />
</sec:authorize>
<script type="text/javascript">

$(function(){
	
	$("#reserve, #reserveMobile").on('click', function(){
		var Auth = '${isAuth}';
		var memberId =  '${memberId}';
		console.log("ID :" + memberId + " Auth : " + Auth);
		
 		if(Auth=='true'){
 			
			var code = '${info.code}';
			var title = '${info.title}';
			
			console.log(code + ': ' + title);
			
			$.ajax({
				url:'${pageContext.request.contextPath}/rental/reserve',			
				type:"get",
				contentType : "text/html;charset:utf-8;",
				data: {
					code : code,
					memberId : memberId
				},
				dataType : "json",
				success : function(d){
					
					let msg = title + ' 작품에 ' + d + "번째로 예약되셨습니다.";
					
					$('.modal-body').html(msg);
					$('#booking').modal('show');
					
				},
				error :function(e){
					alert("db연결실패");
				}
				
			});
			
		}else{
			alert("예약을 하기 위해서는 로그인을 해야합니다.");
			$(location).attr('href', "${pageContext.request.contextPath}/member/login");			
			
		}		
	});
	
	
	
	$("#rental, #rentalMobile").on('click', function(){
		
		var Auth = '${isAuth}';
		var memberId =  '${memberId}';
		console.log("ID :" + memberId + " Auth : " + Auth);
		if(Auth == 'true'){			
			$('#rentalPay').modal('show');
		}else{
			alert("렌탈을 하기 위해서는 로그인을 해야합니다.");
			$(location).attr('href', "${pageContext.request.contextPath}/member/login");			
		}		
	});	
	
	
	//모달창 렌탈시작일 바뀔 때 종료일 렌탈기간만큼 변경
	$('#begin, #rentalPeri').on('change', function(){
		console.log($('#rentalPeri').val());
		console.log($('#begin').val());
		let begin = new Date($('#begin').val())
		let rentalPeri = parseInt($('#rentalPeri').val());
		let endDate = new Date(begin.getFullYear(), begin.getMonth(), begin.getDay()+30*rentalPeri);
		console.log(endDate);
		console.log("full:"+endDate)
		let month;
		let date;
		if(endDate.getMonth()+1 < 10){
			month = '0' + (endDate.getMonth()+1);
		}else{
			month =  endDate.getMonth()+1

		}
		console.log("month:"+month);
		if(endDate.getDate() < 10){
			date = '0' + endDate.getDate();
		}else{
			date = endDate.getDate();
		}	
		
		endDate = endDate.getFullYear()+ '-' +month+ '-' +date;
		console.log("short:"+endDate);
		$('#end').val(endDate);
		
	});
	
	/* 다음버튼 클릭 시 결제모듈 창 바로 띄우기 */
	$("#payWindow").on("click", function(){
		$('#rentalPay').modal('hide');
		
		var memberId =  '${memberId}';
		
		console.log("getMemName:" +memberId);
		$.ajax({
			url:"${pageContext.request.contextPath}/member/memInfo.do",			
			type : "get",	
			data: {			
				memberId : memberId
			},
			dataType : "json",
			success : function(d){
				var map = JSON.stringify(d);
				var vo = JSON.parse(map);			
				console.log("JSON:"+vo.memberVO.name);
				var memberName = vo.memberVO.name;
				var memberPhone = vo.memberVO.hp;
				
				var putValue= (parseInt("${info.rentalPrice }"))*(parseInt($('#rentalPeri').val()));
				
				payload(putValue, memberId, memberName, memberPhone);
				
			},
			error :function(e){
				alert("db연결실패");
			}
		});
		
	});
	
	
	/* 다음버튼 클릭 시 체크아웃 페이지로 이동 */

	$('#goCheckout').on('click', function () {
		$('#rentalPay').modal('hide');
	});

	
	
	
	
});

//결제 모듈 띄우기
function payload(putValue, memberId, memberName, memberPhone){
	
	var code = '${info.code}';
	
	IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : code + new Date().getTime(),
	    name : '주문명: ${info.title} 렌탈',
	    amount : parseInt(putValue), //최소결제금액이하에러(현대카드:최소50원, 카카오페이:최소100원)
	    buyer_email : memberId,
	    buyer_name : memberName,
	    buyer_tel : memberPhone,
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456',
	    m_redirect_url : '#'//결제 결과를 받을 주소를 지정
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        sucPayFunc(rsp.paid_amount);
	        /* 결제하면 뜨는 내용
		        결제가 완료되었습니다.
		        고유ID : imp_069523263238
		        상점 거래ID : merchant_1596093522091
		        결제 금액 : 100
		        카드 승인번호 : 00969974
	        */
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    console.log(msg);
	});
}

function sucPayFunc(paidVal){
	var code = '${info.code}';
	var begin = $('#begin').val();
	var end = $('#end').val();
	var memberId = '${memberId}';
	console.log("sucPayFunc():호출됨,결제금:"+paidVal);
	$.ajax({
		url: "rentalAction.do",
		type:'get',
		data:{
			code : code,
			memberId : memberId,
			rentalBegin : begin,
			rentalEnd : end,
			transType : '렌탈중',
			totalAmount : paidVal
		},
		dataType:'json',//콜백데이터타입
		/* contentType:"application/x-www-form-urlencoded;utf-8",//전송방식 */
		//POST 방식=> contentType:"application/x-www-form-urlencoded;charset:utf-8;",
		success : function(d){			
			console.log(d+"행이 삽입되었습니다.");
		    alert('결제가 완료되었습니다.');

		},error: function(e){
			console.log("checkpayload():error:"+e.status+e.statusText);
		}
	});
} 

//사용 안하는 코드
function takeResponseAndHandle(rsp) {
    if ( rsp.success ) {
        // 인증성공
        console.log(rsp.imp_uid);
        console.log(rsp.merchant_uid);
    } else {
         // 인증취소 또는 인증실패
        var msg = '인증에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
 
        alert(msg);
    }
}


//사용 안하는 코드
function addMonth(date, month) {
	  // month달 후의 1일
	  let addMonthFirstDate = new Date(
	    date.getFullYear(),
	    date.getMonth() + month,
	    1
	  );
	  
	  // month달 후의 말일
	  let addMonthLastDate = new Date(
	    addMonthFirstDate.getFullYear(),
	    addMonthFirstDate.getMonth() + 1
	    , 0
	  );
	  
	  let result = addMonthFirstDate;
	  if(date.getDate() > addMonthLastDate.getDate()) 
	  {
	    result.setDate(addMonthLastDate.getDate());
	  } 
	  else 
	  {
	    result.setDate(date.getDate());
	  }
	  
	  return result;
	}





</script>

<!-- Stylesheet -->
<style>
h1, h2, h3, h4, h5, h6, .artworkDetail-artworkTitle {
	font-family: 'Noto Serif KR', serif, "Cardo", serif;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	-webkit-font-smoothing: antialiased;
	letter-spacing: -0.5px;
}

.artworkDetail-viewinroom.left {
	width: 100% !important;
}

.artworkDetail-viewinroom-img-wrap {
	height: 450px !important;
}

.artworkDetail-viewinroom.right .owl-item .item,
	.artworkDetail-viewinroom.right .owl-item.synced .item {
	object-fit: cover;
	width: 100%;
	height: 70px;
}

.owl-stage-outer .owl-item img {
	object-fit: cover;
	width: 100%;
}

.artworkDetail-viewinroom.right {
	width: 100%;
	margin-left: 0;
	margin-top: 25px !important;
}

.artworkDetail-section-title
,
{
text-align


:

 

left


;
}
#btn-upload {
	background-color: #0e202fdb;
	color: white;
	font-weight: normal;
	font-size: 18px;
	padding: 0 26px;
	margin-top: -26px;
	width: 100%;
	height: 43px;
	margin-bottom: 2px;
}
</style>


</head>

<body class="page_detail">

	<div id="fb-root"></div>
	<div id="wrap" class="">

		<div id="container" class="container">
			<div id="contents">
				<div class="artworkDetail">
					<div class="artworkDetail-inner">

						<section class="artworkDetail-head">
							<!-- 작품 제목 -->
							<p class="artworkDetail-artworkTitle">${info.title}</p>
						</section>
						<section class="artworkDetail-artworkImage">
							<div>
								<div class="artworkDetail-imageViewer">
									<div class="artworkDetail-imageViewer-imgWrap">

										<!-- ZOOM 버튼 -->
										<a class="artworkDetail-artworkZoomBtn" href="#zoom"
											onclick=""></a> <a href="#zoom"> <!-- 작품 대표 이미지 --> <img
											class="artworkDetail-imageViewer-img" src="${info.imageUrl }"
											data-image_url="${info.imageUrl }" />
										</a>
									</div>
								</div>
							</div>

							<!-- 카피라이트 -->
							<div class="artworkDetail-copyright">
								이미지를 클릭하면 확대하여 보실 수 있습니다.<br class="artworkDetail-copyright-br" />
								무단 도용 및 재배포를 금지합니다.<br /> Copyright &copy; ${info.name } All
								rights reserved.
							</div>
						</section>

						<section class="artworkDetail-section">
							<h3 class="artworkDetail-section-title">작품 걸어보기</h3>
							<div class="artworkDetail-section-bar"></div>
							<div class="artworkDetail-section-body cf">




								<!---------- 프리뷰 좌측 큰 이미지 영역 ------------>
								<div class="artworkDetail-viewinroom left">
									<div class="artworkDetail-viewinroom-img-wrap">


										<img class="artworkDetail-viewinroom-img-artwork"
											data-view_in_room_width="${info.width }"
											data-ratio="${ratio }" src="${info.imageUrl }" />

										<!-- 액자 이미지 -->
										<div class="shadow"></div>

										<!-- 배경 인테리어 이미지 -->
										<div
											class="artworkDetail-viewinroom-img-background owl-carousel">
											<img class="artworkDetail-viewinroom-img"
												src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior1.jpg" />
											<img class="artworkDetail-viewinroom-img"
												src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior2.jpg" />
											<img class="artworkDetail-viewinroom-img"
												src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior3.jpg" />
											<img class="artworkDetail-viewinroom-img"
												src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior5.jpg" />
											<img class="artworkDetail-viewinroom-img"
												src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior6.jpg" />

											<!-- 											<img class="artworkDetail-viewinroom-img"
												src="https://og-data.s3.amazonaws.com/static/pages/img/service/viewinroom/view_in_room_2.png" />
											<img class="artworkDetail-viewinroom-img"
												src="https://og-data.s3.amazonaws.com/static/pages/img/service/viewinroom/view_in_room_3.png" />
											<img class="artworkDetail-viewinroom-img"
												src="https://og-data.s3.amazonaws.com/static/pages/img/service/viewinroom/view_in_room_4.png" />
											<img class="artworkDetail-viewinroom-img"
												src="https://og-data.s3.amazonaws.com/static/pages/img/service/viewinroom/view_in_room_4.png" /> -->

										</div>
									</div>
									<!-- 이미지 캡션 텍스트 -->
									<!-- <div class="artworkDetail-viewinroom-tag">
                                    <span class="artworkDetail-viewinroom-tag_space">거실 1</span>
                                    &nbsp;/&nbsp;
                                    <span class="artworkDetail-viewinroom-tag_color">White<span
                                            class="artworkDetail-viewinroom-tag-mark"></span></span>
                                </div> -->

								</div>
								<!---------- 프리뷰 좌측 영역 끝 ------------>

								<!---------- 프리뷰 우측 영역 ------------>
								<div class="artworkDetail-viewinroom right">

									<div class="artworkDetail-viewinroom-box">
										<div class="artworkDetail-viewinroom-title">
											<!-- 파일업로드 외부버튼 -->
											<button type="button" id="btn-upload" role="presentation"
												class="owl-next2 artworkDetail-artistTableBtn">내
												인테리어 공간에 액자 걸어보기</button>
											<!-- 다중 파일 업로드 -->
											<input type="file" multiple="multiple" hidden="hidden"
												id="files" name="files[]" onchange="changeValue(this)" capture="camera"/>
										</div>
										<div class="artworkDetail-viewinroom-content">
											<div class="owl-carousel">
												<img class="item"
													src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior1.jpg" />
												<img class="item"
													src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior2.jpg" />
												<img class="item"
													src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior3.jpg" />
												<img class="item"
													src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior5.jpg" />
												<img class="item"
													src="${pageContext.request.contextPath}/resources/img/owl-carousel/interior6.jpg" />

											</div>
											<div class="counter">
												<span class="current-item"></span>&nbsp;/&nbsp;<span
													class="max-items"></span>
											</div>
										</div>
									</div>

								</div>
								<!---------- 프리뷰 우측 영역 끝 ------------>


							</div>

						</section>

						<section class="artworkDetail-section">
							<div class="artworkDetail-infoTable">
								<div class="artworkDetail-infoTable-head cf">
									<div class="artworkDetail-collectionBox" data-code=""></div>
									<div class="artworkDetail-shareButton" data-pathname=""
										data-txt=""></div>
								</div>
								<div class="artworkDetail-infoTable-body">
									<div class="artworkDetail-artistInfo">
										<div class="artworkDetail-artworkInfo-left">

											<a href="/artist/A0113/#cv" class="artworkDetail-artistLink">${info.name }</a>
											<a
												href="${pageContext.request.contextPath}/showroom/art/artistview.do?memberId=${info.memberId}"
												onclick="" class="artworkDetail-artistTableBtn">작품 더보기</a>

											<div class="artist-education-set">

												<span>${edu }</span>


											</div>
										</div>
									</div>
									<div class="artworkDetail-infoTable-details">
										<h2 class="artworkDetail-title">${info.title }</h2>
										<p class="artworkDetail-infoTable-details-p">
											${info.material } <br /> ${info.height }x${info.width }cm
											(${info.sizeHo }호), ${info.prodYear } <span
												class="artworkDetail-code-view">작품코드 : ${info.code }</span>
										</p>
										<p class="artworkDetail-infoTable-details-pNotice">
											* 출장비 및 설치비는 별도입니다.<br /> * 렌탈 중인 작품 구매시 렌탈요금을 돌려드립니다.<br />
											* 작품에 따라 액자가 포함될 수 있습니다.
										</p>

									</div>



									<div class="artworkDetail-priceWrapper cf">
										<p class="artworkDetail-infoTable-details-p">

											<span class="artworkDetail-priceLabel bigLineHeight">렌탈요금:</span>
											<span class="artworkDetail-priceLabel bigLineHeight">
												<!-- JSTL 국제화 태그로 1000단위 콤마 표시하기 --> <fmt:formatNumber
													value="${info.rentalPrice }" />원
											</span> <span class="artworkDetail-priceSmall">/월 (VAT포함)</span>
											<!-- <span class="artwork_default_sold" style="height: 26px;"></span> 
											<span class="artworkDetail-priceLabel bigLineHeight">구매가격:</span>
											<span class="artworkDetail-priceLabel bigLineHeight">3,000,000원</span> -->

										</p>


										<div class="artworkDetail-functions login_required"
											id='rentalBtn'>

											<c:choose>

												<c:when test="${info.status eq '렌탈가능' }">

													<button id="cart" class="artworkDetail-functionBtn cartBtn">렌탈카트</button>
													<button id="rental"
														class="artworkDetail-functionBtn noMarginRight">렌탈하기</button>
												</c:when>
												<c:when test="${info.status eq '렌탈중' }">

													<button id="reserve"
														class="artworkDetail-functionBtn noMarginRight">예약하기</button>
												</c:when>
											</c:choose>
											<br />

										</div>
									</div>

									<!-- 모바일 -->
									<div class="artworkDetail-priceWrapper mobile">



										<c:choose>
											<c:when test="${info.status eq '렌탈가능' }">
												<span class="artworkDetail-priceLabel bigLineHeight">렌탈요금:</span>
												<span class="artworkDetail-priceLabel bigLineHeight">${info.rentalPrice }원</span>
												<span class="artworkDetail-priceSmall">/월 (VAT포함)</span>
												<button class="artworkDetail-functionBtn" id="rentalMobile">렌탈하기</button>
									</div>

									</c:when>
									<c:when test="${info.status eq '렌탈중' }">
										<button id="reserveMobile" class="artworkDetail-functionBtn">예약하기</button>
									</c:when>

									</c:choose>



									<br class="visible543" />

								</div>

							</div>
					</div>
					</section>


					<section class="artworkDetail-section">
						<h3 class="artworkDetail-section-title">큐레이터 노트</h3>
						<div class="artworkDetail-section-bar"></div>
						<div class="artworkDetail-note_recommend">${info.note1 }</div>
					</section>


					<section class="artworkDetail-section">
						<h3 class="artworkDetail-section-title">추천 이유</h3>
						<div class="artworkDetail-section-bar"></div>
						<div class="artworkDetail-note_recommend">${info.note2 }</div>
					</section>


					<section class="artworkDetail-section">
						<h3 class="artworkDetail-section-title">추천 작품</h3>
						<div class="artworkDetail-section-bar"></div>
						<div class="artworkDetail-relatedArtworks cf">
							<div class="row"
								style="box-sizing: border-box; height: 50%; width: auto;">
								<c:forEach var="dto" items="${recommList }" begin="0" end="3">
									<div class="col-3 artworkDetail-relatedArtworks-item"
										onclick="?code=${dto.code}"
										style="border: 5px solid white; cursor:pointer; box-sizing: border-box; height: inherit; background-image: url('${dto.imageUrl}');  background-position: center;  background-size: cover;">
										<img class="artworkDetail-relatedArtworks-item-img" src=""
											title="" alt="" style="display: none;">
									</div>
								</c:forEach>
								<c:forEach var="dto" items="${recommList }" begin="4" end="7">
									<div class="col-3 artworkDetail-relatedArtworks-item"
										onclick="?code=${dto.code}"
										style="border: 5px solid white; cursor:pointer; box-sizing: border-box; height: inherit; background-image: url('${dto.imageUrl}');  background-position: center;  background-size: cover;">
										<img class="artworkDetail-relatedArtworks-item-img" src=""
											title="" alt="" style="display: none;">
									</div>
								</c:forEach>
							</div>
							<div class="row"
								style="box-sizing: border-box; height: 50%; width: auto;">
								<c:forEach var="dto" items="${recommList }" begin="8" end="11">
									<div class="col-3 artworkDetail-relatedArtworks-item"
										onclick="?code=${dto.code}"
										style="border: 5px solid white; cursor:pointer; box-sizing: border-box; height: inherit; background-image: url('${dto.imageUrl}');  background-position: center;  background-size: cover;">
										<img class="artworkDetail-relatedArtworks-item-img" src=""
											title="" alt="" style="display: none;">
									</div>
								</c:forEach>
								<c:forEach var="dto" items="${recommList }" begin="12" end="15">
									<div class="col-3 artworkDetail-relatedArtworks-item"
										onclick="?code=${dto.code}"
										style="border: 5px solid white; cursor:pointer; box-sizing: border-box; height: inherit; background-image: url('${dto.imageUrl}');  background-position: center;  background-size: cover;">
										<img class="artworkDetail-relatedArtworks-item-img" src=""
											title="" alt="" style="display: none;">
									</div>
								</c:forEach>
							</div>
							<div class="row"
								style="box-sizing: border-box; height: 50%; width: auto;">
								<c:forEach var="dto" items="${recommList }" begin="16" end="19">
									<div class="col-3 artworkDetail-relatedArtworks-item"
										onclick="?code=${dto.code}"
										style="border: 5px solid white; cursor:pointer; box-sizing: border-box; height: inherit; background-image: url('${dto.imageUrl}');  background-position: center;  background-size: cover;">
										<img class="artworkDetail-relatedArtworks-item-img" src=""
											title="" alt="" style="display: none;">
									</div>
								</c:forEach>
								<c:forEach var="dto" items="${recommList }" begin="20" end="23">
									<div class="col-3 artworkDetail-relatedArtworks-item"
										onclick="?code=${dto.code}"
										style="border: 5px solid white; cursor:pointer; box-sizing: border-box; height: inherit; background-image: url('${dto.imageUrl}');  background-position: center;  background-size: cover;">
										<img class="artworkDetail-relatedArtworks-item-img" src=""
											title="" alt="" style="display: none;">
									</div>
								</c:forEach>
							</div>

						</div>
					</section>

				</div>
			</div>


			<!-- 					<div class="event_footer">
						<div class="event_block cf" style="margin: 0 auto;">
							<div class="event-bottom">
								<div class="event-bottom-txt-div">
									<span class="leading-span artworkDetail-priceLabel">월
										렌탈요금:&nbsp;</span><span
										class="before-discount-priceLabel artworkDetail-priceLabel">&nbsp;99,000원</span><br
										class="none_767" /> <span
										class="after-discount-priceLabel artworkDetail-priceLabel">33,000원</span>
								</div>
								<div class="event-bottom-btn-div">
									<button class="artworkDetail-functionBtn eventBtn"
										onclick="">
										첫 렌탈 신청<span class="hide_374">하기</span>
									</button>
								</div>
							</div>
						</div>
					</div> -->



		</div>




		<div id="recentlyViewedArtworks-popup"></div>
		<div id="basePage-RecentlyViewedArtworks" onclick=""></div>
		<!-- 			<a id="kakaoPlusBtn" href="https://pf.kakao.com/_xdWtxbl/chat"
				target="_blank"> <img
				src="https://og-data.s3.amazonaws.com/static/common/img/web-kakao-chat%402x.png" />
			</a> -->
		<div id="basePage-up"></div>

		<%-- </c:forEach> --%>
	</div>
	</div>
	<script type="text/javascript"
		src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"
		charset="utf-8"></script>

	<script src="//developers.kakao.com/sdk/js/kakao.min.js" async></script>

	<script>
		if (!dj_context)
			var dj_context = {};
		dj_context.artwork_code = 'A0113-0014';

		dj_context.is_over_100 = false;
	</script>


	<script> 
	$(function() {
		//추천작품 링크 생성
		console.log("location.pathname:",window.location.pathname);
		$(".artworkDetail-relatedArtworks-item").each(function(index,item){
			let path = $(this).attr("onclick");
	      	$(this).attr("onclick","location.href='"+window.location.pathname+path+"'");
			console.log($(this).attr("onclick"));
		});
	});
	</script>




	<!-- Draggable -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.3/TweenLite.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.3/utils/Draggable.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.3/plugins/CSSPlugin.min.js"></script>
	<!-- END || Draggable -->


	<!-- 프리뷰 Owl Carousel 자바스크립트 -->
	<script>
	<!-- 첨부파일버튼 클릭시 이벤트 설정 -->
		//외부버튼 클릭 시 파일첨부 작동
		$(function() {
			$('#btn-upload').click(function(e) {
				e.preventDefault();
				$('#files').click();
			});
		});
	
		function changeValue(obj) {
		}
	
		//멀티파일 선택 시 미리보기 출력
	    $('#files').change(function(){
	        fileBuffer = [];
	        var target = document.getElementsByName('files[]');
	        
	        Array.prototype.push.apply(fileBuffer, target[0].files);
	        
	        var html = '';//우측의 썸네일 이미지
	        var html2 = '';//좌측의 큰 이미지
	        
	        
	        $.each(target[0].files, function(index, file){
	            const fileName = file.name;
	            /* 좌측 큰 이미지 */
				html = '';
	            html += '<div class="item">';
	            html += '<img class="artworkDetail-viewinroom-img" src="'+URL.createObjectURL(file)+'" alt="내공간'+index+'">';
	            html += '</div>';
	            
	            /* 우측 썸네일 이미지 */
	            html2 = '';
	            html2 += '<img class="item" src="'+URL.createObjectURL(file)+'">';
	            
	            const fileEx = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
	            if(fileEx != "jpg" && fileEx != "png" &&  fileEx != "gif" &&  fileEx != "bmp" ){
	                alert("파일은 (jpg, png, gif, bmp) 형식만 등록 가능합니다.");
	                resetFile();
	                return false;
	            }
	            $('.owl-carousel').owlCarousel('add', html2).owlCarousel('update').trigger('update.owl.carousel');//큰 이미지 영역에 업로드한 이미지를 출력
	        });           
	        	$(".owl-carousel").trigger("to.owl.carousel", [5, 1, true]);//5번째 이후 이미지 위치로 이동
	        	$(".owl-carousel").trigger("refresh.owl.carousel");//새로고침 효과	   
	       
	    });
	
	  	//멀티파일 리스트에서 파일 삭제
	    $(document).on('click', '#removeImg', function(){
	        const fileIndex = $(this).parent().index();
	         fileBuffer.splice(fileIndex,1);
	         $('.owl-carousel>div:eq('+fileIndex+')').remove();
	    });
	  	
	  	
	</script>


</body>
</html>


<!-- 예약 모달창 -->

<div class="modal fade" id="booking" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">

		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bookingModalLabel">예약완료</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
			</div>

			<div class="modal-body"></div>

			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>



<!-- 결제 모달창 -->

<div class="modal fade" id="rentalPay" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">

		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bookingModalLabel">렌탈</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
			</div>

			<form:form
				action="${pageContext.request.contextPath }/rental/checkout"
				method="post">
				<div class="modal-body">
					<div>
						렌탈기간 : <input name="rentalPeri" class="form-control"
							id="rentalPeri" type="number" min="3" value="3"
							style="width: 80%; display: inline;" /> 개월
					</div>
					<div>
						렌탈시작 : <input name="rentalBegin" class="form-control" type="date"
							id="begin" style="width: 80%; display: inline;" /><br /> 렌탈종료 :
						<input name="rentalEnd" class="form-control" type="date" id="end"
							style="width: 80%; display: inline;" />

						<!-- 로그인된 아이디 -->
						<input type="text" name="memberId" value="${memberId }" hidden />
						<!-- 작품 정보 (히든) -->
						<input type="text" name="code" value="${info.code }" hidden />
					</div>
				</div>

				<div class="modal-footer">
					<!-- <button type="submit" class="btn btn-Primary" id="goCheckout">다음(체크아웃)</button> -->
					<button class="btn btn-Primary" id="payWindow">다음(결제)</button>
					<!-- 다음을 누르면 현재 아임포트 결제모듈로 연결됨 -->
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</form:form>
		</div>
	</div>
</div>
