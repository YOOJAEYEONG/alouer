<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- 다음 우편번호 api -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 아임포트 결제 모듈 -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<!doctype html>
<html>
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 아래 2개는 시큐리티 적용시 POST로 데이터 전달할 때 필요 -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />


<title>주문결제</title>

</head>
<style>
.breadcrumb {
	display: none;
}

.cardB {
	border: 1px solid #dfdfdf;
}

li, h3 {
	font-weight: 600 !important;
}

.mallBuy .mallBuy-in div.mallBuy-box-line .mallBuy-box-stay .mallBuy-boxsize40 h3
	{
	margin-top: 12px;
}
</style>


<!-- CSS ================================================== -->
<link
	href="${pageContext.request.contextPath}/resources/css/main/common.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/main/css.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/main/main.css"
	rel="stylesheet">




<body>
	<form id="commonForm" name="commonForm"></form>
	<div id="wrap">

		<!-- 시큐리티 통해 memberid 받아오기 -->
		<sec:authorize access="isAuthenticated()" var="isAuth">
			<sec:authentication property="principal.username" var="memberId" />
		</sec:authorize>

		<script>
			//아래  token, header 시큐리티 적용시 POST로 데이터 전달할 때 필요
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");

			$(function() {
				// 전화번호 입력 자동 하이픈
				function fn_mpNoHyphen(obj) {
					var num = obj.value.replace(/[^0-9]/g, "");
					var tel = gfn_viewMpNo(num);

					obj.value = tel;
				}
				// '주문자 정보와 동일' 클릭시
				$('#address-check').on('click', function() {
					$('#toMem').val('${memberinfo.name}');
					/* $('#phoneNum').val(gfn_viewMpNo('') ); */
					/* $('#zipCd').val('');
					$('#address').val('');
					$('#detailAddress').val(''); */
				});

				// select box '직접입력' 선택시 input open
				$('#deliveryMsg').change(function() {
					if ($(this).val() == '99') {
						$('.mallBuyall2').attr('readonly', false);
						$('.mallBuyall2').removeAttr('disabled');
					} else {
						$('.mallBuyall2').attr('readonly', true);
						$('.mallBuyall2').attr('disabled', '');
						$('.mallBuyall2').val('');
					}
				});
				//이용약관 전체 동의 클릭시
				$("#checkbox-all").on(
						'click',
						function() {
							var check = $("#checkbox-all").is(':checked');

							if (check) {
								$('.agree-cont input[type="checkbox"]').prop(
										'checked', true);
							} else {
								$('.agree-cont input[type="checkbox"]').prop(
										'checked', false);
							}

						});
				$('.agree-cont input[type="checkbox"]').on(
						'click',
						function() {
							var check1 = $('.agree-cont-in #checkbox-1').is(
									':checked');
							var check2 = $('.agree-cont-in #checkbox-2').is(
									':checked');

							if (check1 && check2) {
								$("#checkbox-all").prop('checked', true);
							} else {
								$("#checkbox-all").prop('checked', false);
							}
						});

			});

			// 우편번호 검색
			function fn_searchPostCode() {
				new daum.Postcode({
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						/* if(data.userSelectedType === 'R'){
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if(data.buildingName !== '' && data.apartment === 'Y'){
								extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if(extraAddr !== ''){
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;
						
						} else {
							document.getElementById("sample6_extraAddress").value = '';
						} */

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipCd').value = data.zonecode;
						document.getElementById("address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("detailAddress").focus();
					}
				}).open();
			}

			// input 숫자 콤마 자동표기
			function fn_autoComma(obj) {
				// 콤마( , )의 경우도 문자로 인식되기때문에 콤마를 따로 제거한다.
				var deleteComma = obj.value.replace(/\,/g, "");

				// 콤마( , )를 제외하고 문자가 입력되었는지를 확인한다.
				if (isFinite(deleteComma) == false) {
					obj.value = "";
					return false;
				}

				// 기존에 들어가있던 콤마( , )를 제거한 이 후의 입력값에 다시 콤마( , )를 삽입한다.
				obj.value = gfn_comma(gfn_uncomma(obj.value));
			}

			
			
			
			
			// 구입버튼 클릭 시 결제모듈 창 바로 띄우기
			function fn_doBuy() {
				if (!$('#checkbox-1').is(":checked")) {
					alert("서비스 이용약관에 동의해야 합니다.");
					return false;
				}

				if (!$('#checkbox-2').is(":checked")) {
					alert("개인정보 처리방침에 동의해야 합니다.");
					return false;
				}

				//받는사람
				if ($("input[name='receiver']").val() == "") {
					alert("받는사람을 입력해주세요.");
					return false;
				}
				//연락처
				if ($("input[name='phone']").val() == "") {
					alert("연락처를 입력해주세요.");
					return false;
				}
				//주소1
				if ($("input[name='address1']").val() == "") {
					alert("주소를 입력해주세요.");
					return false;
				}
				//주소2
				if ($("input[name='address2']").val() == "") {
					alert("상세주소를 입력해주세요.");
					return false;
				}

				//회원아이디 변수 저장
				var memberId = '${memberId}';
				console.log("getMemName:" + memberId);

				$
				.ajax({
					url : "${pageContext.request.contextPath}/member/memInfo.do",
					type : "get",
					data : {
						memberId : memberId
					},
					dataType : "json",
					success : function(d) {
						var map = JSON.stringify(d);
						var vo = JSON.parse(map);
						console.log("JSON:" + vo.memberVO.name);
						var memberName = vo.memberVO.name;
						var memberPhone = vo.memberVO.hp;

						var putValue = (parseInt("${artinfo.rentalPrice }"))
								* (parseInt("${transinfo.rentalPeriMonth}"));

						payload(putValue, memberId, memberName,
								memberPhone);

					},
					error : function(e) {
						alert("db연결실패");
					}
				});

			}

			//결제 모듈 띄우기
			function payload(putValue, memberId, memberName, memberPhone) {

				var code = '${info.code}';
				var orderTime = "";

				IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
				IMP.request_pay({
					pg : 'inicis', // version 1.1.0부터 지원.
					pay_method : 'card',
					merchant_uid : code + new Date().getTime(),
					name : '주문명: ${artinfo.title} 렌탈',
					amount : parseInt(putValue), //최소결제금액이하에러(현대카드:최소50원, 카카오페이:최소100원)
					buyer_email : memberId,
					buyer_name : memberName,
					buyer_tel : memberPhone,
					buyer_addr : '',
					buyer_postcode : '',
					m_redirect_url : '#'//결제 결과를 받을 주소를 지정
				}, function(rsp) {
					if (rsp.success) {
						var msg = '결제가 완료되었습니다.';
						/* msg += '고유ID : ' + rsp.imp_uid;
						msg += '상점 거래ID : ' + rsp.merchant_uid;
						msg += '결제 금액 : ' + rsp.paid_amount;
						msg += '카드 승인번호 : ' + rsp.apply_num;
						 */
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
					alert(msg);
				});
			}

			//결제 성공시 실행 함수
			function sucPayFunc(paidVal) {
				var code = '${artinfo.code}';
				var memberId = '${memberId}';
				var rentalBegin = '${transinfo.rentalBegin}';
				var rentalEnd = '${transinfo.rentalEnd}';
				var rentalPrice = '${transinfo.rentalPrice}';
				var phone = $("input[name='phone']").val();
				var address1 = $("input[name='address1']").val();
				var address2 = $("input[name='address2']").val();
				var memo = $("select[name='memo1']").val();
				var receiver = $("input[name='receiver']").val();
				
				console.log("sucPayFunc():호출됨,결제금:" + paidVal);
				console.log("code"+code);
				console.log("memberId"+memberId);
				console.log("rentalBegin"+rentalBegin);
				console.log("rentalEnd"+rentalEnd);
				console.log("rentalPrice"+rentalPrice);
				console.log("phone"+phone);
				console.log("address1"+address1);
				console.log("address2"+address2);
				console.log("memo"+memo);
				console.log("receiver"+receiver);
				
				$.ajax({
					url : "checkoutAction.do",
					type : 'get',
					data : {
						code : code,
						memberId : memberId,
						rentalBegin : rentalBegin,
						rentalEnd : rentalEnd,
						transType : '렌탈중',
						totalAmount : paidVal,
						rentalPrice : rentalPrice,
						phone : phone,
						address1 : address1,
						address2 : address2,
						memo : memo,
						receiver : receiver
					},
					dataType : 'json',//콜백데이터타입
					/* contentType:"application/x-www-form-urlencoded;utf-8",//전송방식 */
					//POST 방식=> contentType:"application/x-www-form-urlencoded;charset:utf-8;",
					success : function(d) {
						console.log(d + "행이 삽입되었습니다.");
						alert('결제가 완료되었습니다.');
						location.href="${pageContext.request.contextPath}/mypage/rental";
					},
					error : function(e) {
						console.log("checkpayload():error:" + e.status
								+ e.statusText);
					}
				});
			}
		</script>



		<!-- content area -->
		<div style="height: 50px;"></div>
		<%-- <section class="bg-gray bg-gray-mall"> --%>

		<section class="mallBuy cardB">
			<h2>렌탈 결제하기</h2>
			<div class="mallBuy-in clear">
				<div class="mallBuy-left">

					<div class="mallBuy-box">
						<h1>주문 상품</h1>
						<div class="mallBuy-prouduct">
							<div class="clear mallBuy-detail">

								<div class="mallBuy-detailImg">
									<img src="${artinfo.imageUrl }">
								</div>
								<div class="mallBuy-detailText">

									<h1>${artinfo.title }</h1>

									<h2>
										<span>${artinfo.name } </span> &nbsp;${artinfo.height }x${artinfo.width }cm
										(${artinfo.sizeHo }호)
									</h2>

									<div class="clear mallBuy-detail2">
										수량 1개
										<p>
											<fmt:formatNumber value="${artinfo.rentalPrice }" />
											KRW / 월
										</p>
									</div>

								</div>
							</div>
						</div>
					</div>

						<div class="mallBuy-box">
							<h1>주문자 정보</h1>
							<ul class="mallBuy-state clear">
								<li class="mallBuy-state-text">주문자명<span>${memberinfo.name }</span></li>
								<li class="mallBuy-state-text">이메일<span>${memberinfo.memberId }</span></li>

							</ul>
						</div>
						<div class="mallBuy-box mallBuy-box-line">
							<h1 class="checkBoxh1">배송지 정보</h1>
							<div class="agree-cont-in">
								<input class="styled-checkbox address-check" id="address-check"
									type="checkbox"> <label for="address-check">주문자
									정보와 동일</label>
							</div>
							<div class="mallBuy-box-stay clear" id="mallBuyBoxStay">
								<div class="mallBuy-boxsize40">
									<h3>받으시는 분</h3>
									<input type="text" name="receiver" class="hasValue mallBuyall"
										id="toMem" alt="받으시는 분 입력" >
								</div>
								<div class="mallBuy-boxsize40">
									<h3>연락처</h3>
									<input type="number" name="phone" class="hasValue mallBuyall"
										id="phoneNum" onkeyup="fn_mpNoHyphen(this);"
										placeholder="- 없이 입력" alt="연락처 입력" >
								</div>
								<div class="mallBuy-boxsize40">
									<input type="hidden" id="zipCd" value="">
									<h3>주소</h3>
									<h4>
										<input type="text" name="address1" class="hasValue"
											id="address" alt="주소 입력" ><span><a
											href="javascript:fn_searchPostCode();">검색</a></span>
									</h4>
								</div>
								<div class="mallBuy-boxsize40" style="margin-bottom: 0px;">
									<h3>상세 주소</h3>
									<h4>
										<input name="address2" class="mallBuyall" id="detailAddress"
											placeholder="상세주소를 입력해주세요." alt="상세주소 입력" >
									</h4>
								</div>

								<div class="agree-cont-in" style="margin-bottom: 0px;">
									<!-- <input class="styled-checkbox address-check" id="address-save"
								type="checkbox"> <label class="address-label"
								for="address-save">이 주소 기억하기</label> -->
								</div>

								<div class="mallBuy-boxsize40">
									<h3>배송요청사항</h3>
									<select id="deliveryMsg" name="memo1">
										<option value="" disabled selected hidden>배송요청사항을
											선택해주세요.</option>


										<option value="선택안함">선택안함</option>

										<option value="배송 전 연락주세요.">배송 전 연락주세요.</option>

										<option value="부재시 휴대폰으로 연락주세요.">부재시 휴대폰으로 연락주세요.</option>

										<option value="부재시 경비실에 보관해 주세요.">부재시 경비실에 보관해 주세요.</option>

										<option value="직접입력">직접입력</option>


									</select>
								</div>
								<div class="mallBuy-boxsize40">
									<h3 class="noh3">x</h3>
									<input name="memo2" class="mallBuyall mallBuyall2" value=""
										placeholder="50자 이내로 입력해주세요." alt="배송요청사항 입력"
										readonly="readonly" disabled>
								</div>
							</div>
						</div>
					
					
				</div>

				<div class="mallBuy-right">

					<div class="mallBuy-box mallBuy-box-gray">

						<p>(단위:KRW)</p>
						<ul class="mallBuy-state clear">
							<li class="mallBuy-state-text">작품 수 <span>1점<input
									type="hidden" id="buyAmt" value="137750"></span>
							</li>
							<li class="mallBuy-state-text">렌탈기간<span>${transinfo.rentalPeriMonth }개월(${transinfo.rentalPeriDays }일)</span>
							</li>
							<li class="mallBuy-state-text">렌탈요금<span><fmt:formatNumber
										value="${artinfo.rentalPrice }" />원 / 월</span>
							</li>
							<li class="mallBuy-state-text">출장비
								<div class="ic-info tooltip">
									<i class="fas fa-question-circle"></i> <span
										class="tooltip-text"><h3>착불 배송</h3></span>
								</div> <span> (＋) 현장결제<input type="hidden" id="shppngAmt"
									value="0">
							</span>
							</li>

							<li class="mallBuy-state-text">총 결제금액<span
								class="mallBuy-maincolor"><fmt:formatNumber
										value="${transinfo.totalAmount }" />원</span></li>
						</ul>
						<p>
							<span class="re-red">*</span>필수 입력
						</p>

						<span class="agree-label">약관동의<span class="re-red">*</span></span>
						<div class="agree-cont">
							<p class="agree-cont-in">
								<input class="styled-checkbox" id="checkbox-all" type="checkbox">
								<label for="checkbox-all">전체동의</label>
							</p>
							<hr>
							<p></p>
							<p class="agree-cont-in">
								<input class="styled-checkbox" id="checkbox-1" type="checkbox"
									> <label for="checkbox-1">아루에 서비스
									이용약관(필수)</label> <span class="look-detail"><a href="/service"
									target="_blank">보기</a></span>
							</p>
							<p class="agree-cont-in">
								<input class="styled-checkbox" id="checkbox-2" type="checkbox"
									> <label for="checkbox-2">개인정보
									처리방침(필수)</label> <span class="look-detail"><a href="/terms"
									target="_blank">보기</a></span>
							</p>
						</div>
						<div class="mallBuybtn">
							<a id="payWindow" href="javascript:fn_doBuy();" >구입</a>
							<!-- <button type="button" id="submitBtn" hidden></button> -->
						</div>
					</div>
				</div>
			</div>
			
			
			
		</section>
		<%-- </section> --%>
		<!-- //content area -->
	</div>
	<!-- //#wrap -->

</body>

</html>