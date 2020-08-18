<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<!doctype html>
<html lang="en">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypagelist2.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypageInquiryWrite.css">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>신규 작품 등록</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
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
	height: 40px;
}
</style>
<script>
$(function(){
	//확인 버튼을 눌렀을 때 실행되는 함수
	function nullCheck(fn){
	if (fn.title.value==""){alert("제목을 입력해주세요");
		return false;	}
	
	if (fn.Comment-textArea.value=="2"){alert("내용을 입력해주세요");
		return false;	}
	
	alert("문의가 접수되었습니다. ")
	}
	
	
	/* 현재 날짜 구해와서 출력 */
	document.getElementById('regiDate').value = new Date().toISOString().substring(0, 10);


	/* 첨부된 이미지 미리보기 영역에 띄우기 */
	function readURL(input) {
		if (input.files && input.files[0]) {
			
			var reader = new FileReader();
			var html = '';
			
			reader.onload = function (e) {											 
				$('#image_section').removeAttr('hidden'); //hidden 속성 제거
				$('#image_section').attr('style', 'width:200px; padding-top:20px;');
				$('#image_section').attr('src', e.target.result);
			}
			
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	
	$('#consult-request-submit').click(function(){
		alert("작품 신청이 완료되었습니다. ");
		});
	
	
	
	
		 
	// 이벤트를 바인딩해서 input에 파일이 올라올때 위의 함수를 this context로 실행합니다.
	$("#imageUrl").change(function(){
		readURL(this);
	});
});
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
		<section id="my_artwork_order" class="active">
			<section id="my_account_body" class="orders">
				<div class="orders_view in_progress">

					<h3>신규 작품 등록신청</h3>
					<div class="inputbox">
						<form:form id="formbox" method="post" action="artistWrite/artistWriteAction.do"
							enctype="multipart/form-data" class="login_required">
							<input type="hidden" name="csrfmiddlewaretoken"
								value="l6lyuGQoQqwMf76FpKosMNy3abDzkrR2I5PlSOAKslbUl6edHSeKcoQMZU4O35Xe">
							<div class="fieldset">
								<div class="form-row cf">
									<div class="form-left">
										<span>작품 코드</span><span class="need_label">*</span>
									</div>
									<div class="form-right">
										<input type="text" name="code" id="code" class="form-control"
													placeholder="A0000-0000" required="required" value="B0812-0011"/>
									</div>
								</div>
								<div class="form-row cf">
									<div class="form-left">
										<span>작품 제목</span><span class="need_label">*</span>
									</div>
									<div class="form-right">
										<input type="text" name="title" id="title" class="form-control" required="required" value="inner_pain"/>
									</div>
								</div>
								<div class="form-row cf">
									<div class="form-left" >
										<span readonly="readonly">아이디</span><span class="need_label">*</span>
									</div>
									<div class="form-right">
										<input type="text" name="memberId" id="memberId" class="form-control" required="required" value="${mVO.memberId }"/>
									</div>
								</div>
								<div class="form-row cf">
									<div class="form-left">
										<span readonly="readonly">이름</span><span class="need_label">*</span>
									</div>
									<div class="form-right">
										<input type="text" name="name" id="name" class="form-control" required="required" value="${mVO.name }"/>
									</div>
								</div>
								
								<div class="form-row cf">
									<div class="form-left">
										<span>재료</span><span class="need_label">*</span>
									</div>
									<div class="form-right">
										<input type="text" name="material" id="material" class="form-control" required="required" value="차콜, 아크릴물감" />
									</div>
								</div>
								<div class="form-row cf">
									<div class="form-left">
										<span>제작년도<span class="label-red">*</span></span>
									</div>
									<div class="form-right" id="birth">
										<input type="text" name="prodYear" id="prodYear" class="form-control"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
													 maxlength="4" placeholder="2002" required="required" value="2011"/>
									</div>
								</div>
								<div id="artwork_size" class="form-row cf">
									<div class="form-left full"
										onclick="opg.fn.noticePopup('https://og-data.s3.amazonaws.com/static/pages/img/service/home/final_rental.png');">
										<span>작품 사이즈</span> 
									</div>
									<div class="form-right">
									<input type="text" name="height" id="size" class="form-control"
										placeholder="세로(cm)" required="required" value="80"/>
									<input type="text" name="width" id="size" class="form-control"
										placeholder="가로(cm)" required="required" value="80"/>
									</div>
								</div>
								<div class="form-row cf">
									<div class="form-left">
										<span><span class="label-red">*
										</span> 작품 등록일</span>
									</div>
									<div class="form-right" id="birth">
											<input type="date" name="regiDate" id="regiDate" class="form-control" required="required"/>
									</div>
									
								</div>
								<div class="form-row cf">
									<div class="form-left">
										<span>작품 이미지</span><span class="need_label">*</span>
									</div>
									<div class="form-right">
										<input type='file' id="imageUrl" name="imageUrl-param" class="form-control"/>
										<img id="image_section" src="#" hidden/>
									</div>
								</div>

								<div class="form-row cf">
									<div class="form-left">
										<span>희망 가격</span><span class="need_label">*</span>
									</div>
									<div class="form-right">
										<input class="input-name" type="text" id="rentalPrice" name="rentalPrice" 
											maxlength="64"  value="900000">
									</div>
								</div>
								
								<div class="form-row cf">
									<div class="form-left full">
										<span>작품 테마</span>  
									</div>
									<div class="form-right full">
										<select class="form-control selectpicker" id="theme" name="theme" required="required">
											<option value="인물">인물</option>
											<option value="풍경">풍경</option>
											<option value="정물">정물</option>
											<option value="동물">동물</option>
											<option value="추상">추상</option>
										</select>
									</div>
								</div>
								<input type="hidden" id="status" name="status" value="준비중" required="required">
								<div class="form-row cf">
									<div class="form-left full">
										<span>작품 색상</span>  
									</div>
									<div class="form-right full">
										<select class="form-control selectpicker" id="color" name="color" required="required">
											<option value="빨강">빨강</option>
											<option value="파랑">파랑</option>
											<option value="초록">초록</option>
											<option value="노랑">노랑</option>
											<option value="파스텔">파스텔</option>
											<option value="흑백">흑백</option>
											<option value="기타">기타</option>
										</select>
									</div>
								</div>
							</div>
							<div class="submitblock">
								<input id="consult-request-submit" type="submit" value="신청하기">
							</div>
					 	
					</div>
			</section>
		</section>
		</form:form>
	</div>
</body>

</html>