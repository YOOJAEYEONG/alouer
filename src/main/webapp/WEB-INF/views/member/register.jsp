<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberRegister.css">
<style>
#idCheck{
   display: block;
   float: right; 
   width: 100px;
   height: 21px;
   border: 0;
   outline: 0;
   background-color: #222;
   font-size: 14px;
   color: #fff;
   transition: opacity 0.1s ease-in-out;
    hover: opacity:0.9;
}
##idCheck:hover {
   opacity: 0.9
}
</style>
<!-- 아래 2개는 시큐리티 적용시 POST로 데이터 전달할 때 필요 -->
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script>
//아래  token, header 시큐리티 적용시 POST로 데이터 전달할 때 필요
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");



$(function(){
   
   //이메일 한글 입력 불가
   $('#email1').keyup(function(){
      email1.value = email1.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');//한글입력 막기
   });

   //이메일 선택
   $('#joinPage-input-email2').change(function(){
        //alert("이메일 선택됨");
        //option태그 사이의 텍스트를 읽어온다. 
        var text = $('#joinPage-input-email2 option:selected').text();

        //value속성에 지정된 값을 읽어온다. 
        var value = $('#joinPage-input-email2 option:selected').val();
        //alert("선택한 항목의 text:"+text+", value:"+value);

        if(value==''){//선택하세요를 선택
            $('#joinPage-input-email2_man').attr('readonly', true);//readonly 활성화
            $('#joinPage-input-email2_man').val('');
        }
        else if(value=='direct'){//직접 입력을 선택
            $('#joinPage-input-email2_man').attr('readonly', false); //readonly 비활성화
            $('#joinPage-input-email2_man').val('');
        }
        else{//그외 포털 도메인 선택
            $('#joinPage-input-email2_man').attr('readonly', true); //readonly 활성화
            //위에서 읽어온 값을 도메인 부분에 입력한다. 
            $('#joinPage-input-email2_man').val(value);
        }
   });
   
   

   //비밀번호 일치 확인1
   $('#pwd1').keyup(function(){
       //input태그의 value속성을 빈값으로 만들어준다. 
       $('#pwd2').val("");
       //암호를 재입력시에는 msg부분의 텍스트도 지워준다. 
       $('#msg').text('');
    
   
   });
   //비밀번호 일치 확인2
   $('#pwd2').keyup(function(){
       //패스워드 입력란에 입력된 내용을 가져온다. 
       var compareStr1 = $('#pwd1').val();
       var compareStr2 = $(this).val();
      
      if(compareStr1==compareStr2){
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
   

   //중복체크 클릭시 실행되는 함수
    $('#idCheck').click(function(){
       if($('#joinPage-input-email2_man').val().indexOf('.')==-1) {
          alert("이메일 형식이 잘못되었습니다.");
          $('#joinPage-input-email2_man').focus();
          return false;
       }
          console.log($('#email1').val() + '@' + $('#joinPage-input-email2_man').val());
      $.ajax({
         url: "${pageContext.request.contextPath}/member/register/idCheck.do",
         type: "POST",
         contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
         data:{
            //"userId":$('#userId').val()
            "userId":$('#email1').val() + '@' + $('#joinPage-input-email2_man').val()
            
         },
         //beforeSend 시큐리티 적용시 POST로 데이터 전달할 때 필요 -->
          beforeSend : function(xhr)
            {   
             xhr.setRequestHeader(header, token);
            }, 
         success: function(data){
         console.log(data);
             if(data == 0 ){
               idx=true;
               $('#userId').attr("readonly",true);
               var html="<tr><td colspan='3' style='color: blue'>사용 가능합니다.</td></tr>";
               $('#joinPage-message-email').empty();
               $('#joinPage-message-email').append(html);
               $('#idCheckOX').val('1');
            }
            else if(data==11){
                var html="<tr><td colspan='3' style='color: red'>이메일을 입력하세요.</td></tr>";
                  $('#joinPage-message-email').empty();
                  $('#joinPage-message-email').append(html);
                  $('#idCheckOX').val('2');
             }
            else{
               var html="<tr><td colspan='3' style='color: red'>사용 불가능한 아이디입니다.</td></tr>";
               $('#joinPage-message-email').empty();
               $('#joinPage-message-email').append(html);
               $('#idCheckOX').val('2');
            } 
         },
         error: function(){
            alert("사용 가능한 아이디입니다.");
            /* alert("서버에러"); */
         }
      });
      

   }); 
   
    
    
   
    
    $('#email1').keyup(function(){
        var text1 = $('#email1').val();
        var text2 = $('#joinPage-input-email2').val();
        
        $('#userId').value= text1 + '@' + text2;
   

   });

    
    //중복체크 후 아이디 변경했을 경우를 대비해 만듦
    $("#email1").on("propertychange change keyup paste input", function() {
       $('#idCheckOX').val('3');
    });
    
    $("#joinPage-input-email2").on("propertychange change keyup paste input", function() {
       $('#idCheckOX').val('3');
    });

   

        
}); //제이쿼리 end

   //가입하기 버튼을 눌렀을 때 실행되는 함수
   function joinCheck(fn){
   
   if (fn.idCheckOX.value==""){alert("중복 체크를 눌러주세요.");
      return false;   }
   
   if (fn.idCheckOX.value=="2"){alert("중복된 아이디입니다. ");
      return false;   }
   
   /* if (fn.idCheckOX.value=="3"){alert("중복체크를 눌러주세요.");
      return false;   } */
   
   //이메일 두 번째에 .이 없을 경우
   if($('#joinPage-input-email2_man').val().indexOf('.')==-1) {
         alert("이메일 형식이 잘못되었습니다.");
         fn.joinPage-input-email2.focus();
         return false;   }
   
   //패스워드가 일치하지 않을 때 
   if (fn.passCheckOX.value=="2"){   
      alert("비밀번호를 일치시켜주세요.");
      fn.pwd2.focus();
      return false;   }
}
   




</script>
</head>
<body>

<div id="joinPage">
            <h2 id="joinPage-header">회원가입</h2>
            <div id="joinPage-body">
                <form:form method="post" action="register/join.do" id="joinPage-joinForm" 
                      autocomplete="off" onsubmit="return joinCheck(this);">
                    <div class="joinPage-row">
                        <div class="joinPage-labelWrapper cf">
                            <label for="joinPage-input-email1">이메일  </label>
                            <input type="hidden" name="idCheckOX" id="idCheckOX"  />
                         
                            <!-- 중복체크 클릭시 함수가 실행됨 register/idCheck.do -->
                            <input type="button" id="idCheck" name="idCheck" class="joinPage-profile-certifyButton" value="중복체크">
                            <span id="joinPage-message-email" class="joinPage-message"  style=" margin-left: 5;"> </span>
                        </div>
                        <div id="joinPage-emailWrapper" class="manually">
                            <div id="joinPage-email1-container">
                                <input type="text" name="email1" id="email1" class="joinPage-input" autocomplete="off" autocorrect="off" autocapitalize="off" required>
                            </div>
                            <div id="joinPage-email2-container">
                                <span>@</span>
                                <input type="text" name="email2" id="joinPage-input-email2_man" class="joinPage-input" autocomplete="off" autocorrect="off" autocapitalize="off" required readonly="readonly"> 
                                <select name="selectEmail" id="joinPage-input-email2" class="joinPage-input"  >
                                    <option value="">이메일 선택</option>
                                    
                                        <option value="naver.com">naver.com</option>
                                    
                                        <option value="hanmail.net">hanmail.net</option>
                                    
                                        <option value="gmail.com">gmail.com</option>
                                    
                                        <option value="nate.com">nate.com</option>
                                    
                                    <option value="direct">직접입력</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <input type="text" name="username" id="joinPage-input-email" autocomplete="username" tabindex="-1">
                    <div class="joinPage-row">
                        <div class="joinPage-labelWrapper cf">
                            <label for="joinPage-input-password1">비밀번호</label>
                            <input type="hidden" name="passCheckOX" id="passCheckOX"  />
                            <span id="joinPage-message-password1" class="joinPage-message"></span>
                        </div>
                        <input type="password" name="password1" id="pwd1" class="joinPage-input" autocomplete="off" autocorrect="off" autocapitalize="off" minlength="4" maxlength="20" required>
                    </div>
                    <div class="joinPage-row">
                        <div class="joinPage-labelWrapper cf">
                            <label for="joinPage-input-password2">비밀번호 확인</label>
                            <span id="msg" class="joinPage-message1"></span>
                        </div>
                        <input type="password" name="password2" id="pwd2" class="joinPage-input" autocomplete="off" autocorrect="off" autocapitalize="off" minlength="4" maxlength="20" required>
                    </div>
                   <!--  <div id="joinPage-profile">
                        <div id="joinPage-profile-mask">
                            <p>고객님의 개인정보보호 및 관련 법규 준수를 위해<br>인증을 거쳐 회원가입을 하고 있습니다.</p>
                            <input type="button" id="joinPage-profile-certifyButton" value="휴대폰으로 본인인증">
                            <input type="hidden" id="joinPage-input-uid" name="certification_uid">
                        </div>
                        <div class="joinPage-profile-row">
                            <label class="joinPage-profile-label">이름</label>
                            <div class="joinPage-profile-box">
                                <input type="hidden" id="joinPage-input-name" name="name">
                                <span></span>
                            </div>
                        </div>
                        <div class="joinPage-profile-row">
                            <label class="joinPage-profile-label">휴대폰</label>
                            <div class="joinPage-profile-box">
                                <input type="hidden" id="joinPage-input-phone" name="phone">
                                <span></span>
                            </div>
                        </div>
                        <div class="joinPage-profile-row cf">
                            <div class="joinPage-profile-column-left">
                                <label class="joinPage-profile-label">생년월일</label>
                                <div class="joinPage-profile-box">
                                    <input type="hidden" id="joinPage-input-birth" name="birth">
                                    <span></span>
                                </div>
                            </div>
                            <div class="joinPage-profile-column-right">
                                <label class="joinPage-profile-label">성별</label>
                                <div class="joinPage-profile-box">
                                    <input type="hidden" id="joinPage-input-gender" name="gender">
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div> -->
                    <!-- <div class="joinPage-row last">
                        <div class="joinPage-labelWrapper cf">
                            <label for="joinPage-input-address1">주소</label>
                            <span id="joinPage-message-address" class="joinPage-message"></span>
                        </div>
                        <div id="joinPage-address1-container">
                            <input type="text" name="address1" id="joinPage-input-address1" class="joinPage-input" readonly="readonly">
                            <input type="button" id="joinPage-addressButton" value="주소찾기" readonly="readonly">
                        </div>
                        <div id="joinPage-address2-container">
                            <input type="text" name="address2" id="joinPage-input-address2" class="joinPage-input">
                        </div>
                    </div> -->
                    <!-- memberController join.do 실행 -->
                    <input type="submit" class="joinPage-button" name="_signup_with_email" value="가입하기" >
                </form:form>
            </div>
        </div>

</body>
</html>