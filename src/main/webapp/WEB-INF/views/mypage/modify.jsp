<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<!doctype html>
<html lang="en">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageModify.css">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>회원정보 수정</title>
    
</head>
<style>


</style>

<!-- 아래 2개는 시큐리티 적용시 POST로 데이터 전달할 때 필요 -->
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script>
//아래  token, header 시큐리티 적용시 POST로 데이터 전달할 때 필요
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


//다음 우편번호 API
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}

//제이쿼리 시작
$(function(){

	//기존 비밀번호 입력 후 포커스 잃었을 때 실행되는 함수
	//아이디(이메일), 비밀번호 확인 후 히든에 일치하는지 여부 저장
 	$('#oldPwd').blur(function(){
 			//alert("포커스 잃음");
		$.ajax({
			url: "${pageContext.request.contextPath}/mypage/modify/idPwdCheck.do",
			type: "POST",
			contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
			data:{
				//"userId":$('#userId').val()
				"userId":$('#email').val(), 
				"userPass":$('#oldPwd').val()
			},
			//beforeSend 시큐리티 적용시 POST로 데이터 전달할 때 필요 -->
			 beforeSend : function(xhr)
            {   
				 xhr.setRequestHeader(header, token);
            }, 
			success: function(data){
			console.log(data);
				 if(data == 1 ){
					idx=true;
					$('#userId').attr("readonly",true);
					var html="<tr><td colspan='3' style='color: blue'>일치</td></tr>";
					$('#joinPage-message-email').empty();
					$('#joinPage-message-email').append(html);
					$('#idPwdCheck').val('1');
				}
				else{
					var html="<tr><td colspan='3' style='color: red'>불일치</td></tr>";
					$('#joinPage-message-email').empty();
					$('#joinPage-message-email').append(html);
					$('#idPwdCheck').val('2');
				} 
			},
			error: function(){
				alert("서버에러");
			}
		});
 	});
 			
 			
	//회원정보에서 비밀번호 변경 클릭하면 실행되는 함수
 	$('#password_submit').click(function(){
		//alert("비밀번호 변경 클릭");
 		
		if ($('#oldPwd').val()==""){alert("기존 비밀번호를 입력해주세요");
 			return false;	}
		
		
 		if ($('#passCheckOX').val()=="2"){alert("변경할 비밀번호를 일치시켜주세요. ");
 			return false;	}
 		
 		if ($('#idPwdCheck').val()=="2"){alert("기존 비밀번호가 틀렸습니다.");
 			return false;	}
 		$('#idPwdCheck').val('2');
		$.ajax({
			url: "${pageContext.request.contextPath}/mypage/modify/pwdChange.do",
			type: "POST",
			contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
			data:{
				"userId":$('#email').val(), 
				"userPass":$('#pwd2').val()
			},
			//beforeSend 시큐리티 적용시 POST로 데이터 전달할 때 필요 -->
			 beforeSend : function(xhr)
            {   
				 xhr.setRequestHeader(header, token);
            }, 
            
            
			success: function(data){
				console.log(data);
				console.log("비밀번호 변경 성공");
				alert("비밀번호가 변경되었습니다.");
				$('#msg').html('<b style="color:blue;">비밀번호가 변경되었습니다.</b>');
				$('#oldPwd').attr("readonly",true);
				$('#pwd1').attr("readonly",true);
				$('#pwd2').attr("readonly",true);
				$('#idPwdCheck').val('3');
			},            
			error: function(){
				alert("서버에러");
			}
		});
	}); 
	
	
	
	
	

/* 	
	//비밀번호 일치 확인
	$('#pwd1').keyup(function(){
	    $('#pwd2').val("");  //input태그의 value속성을 빈값으로 만들어준다. 
	    $('#msg').text('');  //암호를 재입력시에는 msg부분의 텍스트도 지워준다. 
	});
	 */
	//비밀번호 일치 확인
	$('#pwd2').keyup(function(){
	    //패스워드 입력란에 입력된 내용을 가져온다. 
	    var compareStr1 = $('#pwd1').val();
	    var compareStr2 = $(this).val();
	    
	    var compareStr3 = $('#idPwdCheck').val();
	    if(compareStr3=="3"){
	    	$('#msg').html('<b style="color:blue;">비밀번호가 변경되었습니다.</b>');
	    }
	    else if(compareStr1==compareStr2){
	       //암호가 일치하면 붉은색 텍스트
	        $('#msg').html('<b style="color:blue;">암호가 일치합니다.</b>');
	        $('#passCheckOX').val('1');
	   }
	   else{
	       //일치하지 않으면 검은색 텍스트
	        $('#msg').html('<b style="color:red;">암호가 다릅니다.</b>');
	        $('#passCheckOX').val('2');
	   }
	            
	});
	$('#pwd1').keyup(function(){
	    //패스워드 입력란에 입력된 내용을 가져온다. 
	    var compareStr1 = $('#pwd2').val();
	    var compareStr2 = $(this).val();
	    var compareStr3 = $('#idPwdCheck').val();
	    if(compareStr3=="3"){
	    	$('#msg').html('<b style="color:blue;">비밀번호가 변경되었습니다.</b>');
	    }
	    else if(compareStr1==compareStr2){
	       //암호가 일치하면 붉은색 텍스트
	        $('#msg').html('<b style="color:blue;">암호가 일치합니다.</b>');
	        $('#passCheckOX').val('1');
	  	}
	   	else{
	       //일치하지 않으면 검은색 텍스트
	        $('#msg').html('<b style="color:red;">암호가 다릅니다.</b>');
	        $('#passCheckOX').val('2');
	  	}
	   	         
	});
	
	
	 $("#inp_userinfo_receive_message").change(function(){
	        if($("#inp_userinfo_receive_message").is(":checked")){
	        	 $('#subscribe').val('1');
	        }else{
	        	 $('#subscribe').val('0');
	        }
   	 });

});//제이쿼리 end

	//확인을 눌렀을 때 실행되는 함수
 	function memberInfosave(fn){
		//alert("회원정보수정 클릭");
		
		//이름
	if (fn.name.value==""){alert("이름을 입력해주세요 ");
		return false;	}
		
		//생일
	if (fn.birth.value==""){alert("생년월일을 입력해주세요");
		return false;	}
	
		//휴대전화 번호
	if (fn.hp.value==""){alert("휴대전화 번호를 입력해주세요");
		return false;	}
	
	//이메일 두 번째에 .이 없을 경우
	if($('#joinPage-input-email2').val().indexOf('.')==-1) {
			alert("이메일 형식이 잘못되었습니다.");
			fn.joinPage-input-email2.focus();
			return false;	}
	
	//패스워드가 일치하지 않을 때 
	if (fn.passCheckOX.value=="2"){	
		alert("비밀번호를 일치시켜주세요.");
		fn.pwd2.focus();
		return false;	}
	}







</script>

<body>

	<div id="contents" data-login_required="true">
		<section class="pageHead" id="my_account_head">
			<div class="pageHead-bar"></div>
			<h2 class="pageHead-title">회원정보</h2>
			<div class="pageHead-description">고객님과 관련된 정보입니다.</div>
		</section>
		<section id="my_account_body" class="modify">
			<div>
				<form:form method="post" action="MemberInfoUpdate.do" id="modify_userinfo_form" class="cf"
					autocomplete="off" onsubmit="return memberInfosave(this);" >
					
					<!-- <input type="hidden" name="csrfmiddlewaretoken"
						value="a2BI5sjQg6e52cob4fzwIf6Lio7tGSkA1RCj38AZMDpdUxwmrkJGAXsHPbQSu9O7"> -->
					<div id="table_userinfo">
						<div class="fieldset">
							<div class="form-row cf">
								<div class="form-left">
									<span><span class="label-red">*</span> 이메일</span>
								</div>
								<div id="userinfo_email">
									<input type="hidden" name="memberId" id="email" value="${mVO.memberId }"/>
									<span >${mVO.memberId }</span>
								</div>
							</div>
							<div class="form-row cf">
								<div class="form-left">
									<span><span class="label-red">*</span> 비밀번호</span>
								</div>
								
								<div class="form-right" id="userinfo_password">
									<input class="inp_userinfo_password" name="password"
										placeholder="기존 비밀번호" id="oldPwd" type="password">
										<input type="hidden" name="idPwdCheck" id="idPwdCheck"  />
										<!-- <span id="joinPage-message-email" class="joinPage-message" style=" margin-left: 5;"> </span> --><br>
									<input class="inp_userinfo_password" name="new_password1"
										placeholder="새 비밀번호" id="pwd1" type="password" minlength="4">
										<input type="hidden" name="passCheckOX" id="passCheckOX"  />
										<span id="msg"></span>
										<br>
									<input class="inp_userinfo_password" name="new_password2"
										placeholder="새 비밀번호 확인" id="pwd2" type="password" minlength="4">
									<input
										type="button" id="password_submit" name="change_password"
										value="변경">
								</div>
							</div>
							<div id="userInfo-profile" class="certified">
								<div class="form-row cf">
									<div class="form-left">
										<span><span class="label-red">*</span> 이름</span>
									</div>
									<c:choose>
										<c:when test="${not empty mVO.name }">
											<div class="userInfo-profile-box">
												<input type="hidden" id="userInfo-input-name" name="name"
												value="${mVO.name }"> <span>${mVO.name }</span> 
											</div>
										</c:when>
										<c:otherwise>
										<div class="form-right" id="userinfo_password">
											<input class="inp_userinfo_password" name="name"
												placeholder="이름을 입력해주세요" id="name" type="text" >
												<span id="msg"></span>
										</div>
										</c:otherwise>
									</c:choose>
								</div>
								
								<div class="form-row cf">
									<div class="form-left">
										<span><span class="label-red">*</span> 생년월일</span>
									</div>
									<c:choose>
										<c:when test="${not empty mVO.birth }">
											<div class="form-right" id="birth">
												<input type="date" name="birth" value="${mVO.birth }"/>
											</div>
										</c:when>
										<c:otherwise>
											<div class="form-right" id="birth">
												<input type="date" name="birth"/>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
								<!-- 
								<div class="form-row cf">
									<div class="form-left">
										<span><span class="label-red">*</span> 성별</span>
									</div>
									<div class="form-right">
										<div class="userInfo-profile-box">
											<input type="hidden" id="userInfo-input-gender" name="gender"
												value="M"> <span>남자</span>
										</div>
									</div>
								</div>
								 -->
								 
				
								 
								 
								
								<div class="form-row cf">
									<div class="form-left">
										<span><span class="label-red">*</span> 휴대폰</span>
									</div>
									<c:choose>
										<c:when test="${not empty mVO.hp }">
											<div class="form-right" id="userinfo_password">
												<input class="inp_userinfo_password" name="hp" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
													 id="hp" type="text" value="${mVO.hp }" maxlength="11" >
													<span id="msg">숫자만 입력해주세요</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="form-right" id="userinfo_password">
												<input class="inp_userinfo_password" name="hp" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
													placeholder="휴대폰번호를 입력해주세요" id="hp" type="text" maxlength="11">
													<span id="msg">숫자만 입력해주세요</span>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="form-row cf">
								<div class="form-left">
									<span>주소</span> 
								</div>
								
								
								<c:choose>
									<c:when test="${not empty mVO.address }">
									<input type="hidden" id="address" name="address" value="${mVO.address }" />
									
									<script>
									
									var addressAll =  $('#address').val();
									var arr = addressAll.split("||");
									
									var addressPostcode = (arr[0]);
									var addressRoad = (arr[1]);
									var addressJibun = (arr[2]);
									var addressDetail = (arr[3]);
									var addressExtra = (arr[4]);
									
									$(document).ready(function() {
										$('#sample4_postcode').val(addressPostcode);
										$('#sample4_roadAddress').val(addressRoad);
										$('#sample4_jibunAddress').val(addressJibun);
										$('#sample4_detailAddress').val(addressDetail);
										$('#sample4_extraAddress').val(addressExtra);
									   });
										
									</script>
										<div class="form-right" id="userinfo_address">
											<input type="text" id="sample4_postcode" name="sample4_postcode" 
												placeholder="우편번호"
												onclick="sample4_execDaumPostcode()" class="join_input"
												readonly="readonly" style="width: 100px;"> 
											<input type="button" id="search_address_btn"
												onclick="sample4_execDaumPostcode()" value="우편번호찾기"
												readonly="readonly"> <br>
											<input type="text" id="sample4_roadAddress" name="sample4_roadAddress"
												placeholder="도로명주소" onclick="sample4_execDaumPostcode()"
												class="join_input" readonly="readonly"> 
											<input	type="text" id="sample4_jibunAddress"
												name="sample4_jibunAddress"
												onclick="sample4_execDaumPostcode()" placeholder="지번주소"
												class="join_input" readonly="readonly"> 
												<span id="guide" style="color: #999; display: none"></span> <br /> 
											<input type="text" id="sample4_detailAddress"
												name="sample4_detailAddress" placeholder="상세주소"
												class="join_input">
											<input type="text" id="sample4_extraAddress" name="sample4_extraAddress"
												placeholder="참고항목" class="join_input">
										</div>
									</c:when>
									<c:otherwise>
										<div class="form-right" id="userinfo_address">
											<input type="text" id="sample4_postcode" name="sample4_postcode" 
												placeholder="우편번호"
												onclick="sample4_execDaumPostcode()" class="join_input"
												readonly="readonly" style="width: 100px;"> 
											<input type="button" id="search_address_btn"
												onclick="sample4_execDaumPostcode()" value="우편번호찾기"
												readonly="readonly"> <br>
											<input type="text" id="sample4_roadAddress" name="sample4_roadAddress"
												placeholder="도로명주소" onclick="sample4_execDaumPostcode()"
												class="join_input" readonly="readonly"> 
											<input	type="text" id="sample4_jibunAddress"
												name="sample4_jibunAddress"
												onclick="sample4_execDaumPostcode()" placeholder="지번주소"
												class="join_input" readonly="readonly"> 
												<span id="guide" style="color: #999; display: none"></span> <br /> 
											<input type="text" id="sample4_detailAddress"
												name="sample4_detailAddress" placeholder="상세주소"
												class="join_input">
											<input type="text" id="sample4_extraAddress" name="sample4_extraAddress"
												placeholder="참고항목" class="join_input">
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							
							
							<div class="form-row cf last">
								<div class="form-left">
									<span>혜택알림</span>
								</div>
								<div class="form-right" id="userinfo_receive">
									<div class="cf">
										<!-- <div class="input-checkbox">
											<div class="input-checkbox-label">
												<input id="inp_userinfo_receive_mail" class="modify-check"
													name="receive_mail" placeholder="" type="checkbox"
													value="receive_mail" checked="checked"> <label
													for="inp_userinfo_receive_mail"><span>우편</span></label>
											</div>
										</div>
										<div class="input-checkbox">
											<div class="input-checkbox-label">
												<input id="inp_userinfo_receive_email" class="modify-check"
													name="receive_email" placeholder="" type="checkbox"
													value="receive_email" checked="checked"> <label
													for="inp_userinfo_receive_email"><span>Email</span></label>
											</div>
										</div>
										<div class="input-checkbox">
											<div class="input-checkbox-label">
												<input id="inp_userinfo_receive_kakaotalk"
													class="modify-check" name="receive_kakaotalk"
													placeholder="" type="checkbox" value="receive_kakaotalk"
													checked="checked"> <label
													for="inp_userinfo_receive_kakaotalk"><span>카카오톡</span></label>
											</div>
										</div> -->
										<c:choose>
											<c:when test="${1 eq mVO.subscribe }">
												<div class="input-checkbox">
													<div class="input-checkbox-label">
														<input id="inp_userinfo_receive_message"
															class="modify-check" name="receive_message" placeholder=""
															type="checkbox" value="receive_message" checked="checked" >
														<label for="inp_userinfo_receive_message"><span>SMS</span></label>
													</div>
													<input type="hidden" id="subscribe" name="subscribe" value="0"/>
												</div>
											</c:when>
											<c:otherwise>
												<div class="input-checkbox">
													<div class="input-checkbox-label">
														<input id="inp_userinfo_receive_message"
															class="modify-check" name="receive_message" placeholder=""
															type="checkbox" value="receive_message" >
														<label for="inp_userinfo_receive_message"><span>SMS</span></label>
													</div>
													<input type="hidden" id="subscribe" name="subscribe" value="0"/>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
									<p style="margin: 14px 0; font-size: 14px; color: #989898;">*
										거래정보와 관련된 내용은 수신동의 여부와 관계없이 발송됩니다.</p>
								</div>
							</div>
						</div>
					</div>
					<!-- <a href="/account/delete/guide/"><div id="withdrawal_btn">
							<span>탈퇴를 원하시는 분은 회원탈퇴 버튼을 눌러주세요.</span>회원탈퇴
						</div></a> -->
					<div class="submit_wrapper">
						<input type="submit" id="save_submit" name="save_submit" value="회원정보수정">
					</div>
				</form:form>
			</div>
		</section>
	</div>



</body>

</html>