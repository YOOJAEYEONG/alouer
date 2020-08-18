<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberLogin.css">
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>

</script>
<style>
	#contents {
	padding-top: 0px
} 

th{text-align: center; }
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
}
</style>
</head>
<body>

<div id="contents" data-redirect_after_login="/">


        <div id="loginPage">
            <h2 id="loginPage-header">로그인</h2>
            <div id="loginPage-body">
            
                                
                  <sec:authorize access="isAuthenticated()">
                        <li class="nav-item" style="padding-top:11px">
                        <sec:authentication property="principal.username" />
                        </li>
                     <form:form method="post"
                     action="${pageContext.request.contextPath }/member/logout">
                        <li class="nav-item">
                           <button class="btn" type="submit">로그아웃</button>
                        </li>
                     </form:form>
                  </sec:authorize>
					
					<sec:authorize access="!isAuthenticated()">
						<c:url value="/member/loginAction" var="loginUrl" />						
						<form:form name="loginFrm"  action="${loginUrl }"  method="post"  id="loginPage-loginForm">
				
							<p>
							
								<!-- 아이디: <input type="text" name="email" id="loginPage-input-email" class="loginPage-input" 
				                    value="test@alouer.com" autocomplete="off" autocorrect="off" autocapitalize="off" placeholder="이메일" required/> -->
								아이디: <input type="text" name="email" id="loginPage-input-email" class="loginPage-input" 
				                    value="test@alouer.com" autocomplete="off" autocorrect="off" autocapitalize="off" placeholder="이메일" required/>
				                  
							</p>
							<p>
								패스워드 : <input type="password" name="password" id="loginPage-input-password" class="loginPage-input" 
				                    value="1111" autocomplete="off" autocorrect="off" autocapitalize="off" placeholder="비밀번호" maxlength="20" required />
							</p>
							<c:if test="${param.error != null }">
							
								<p  style='color: red' id="loginPage-message">아이디와 패스워드가 잘못되었습니다.</p>
							</c:if>
							<c:if test="${param.login != null }">
								<p  style='color: red' id="loginPage-message">로그아웃하였습니다. </p>
							</c:if>
							<input type="submit" class="loginPage-button" name="_signin_with_email" id="loginButton" value="로그인" />
						</form:form>
                    
                    
                    


                    
                    
                    <div class="fakebox longbox">
                        <input id="login_checkbox" type="checkbox" class="consult-check" value="로그인 상태 유지"
                               name="keep_login">
                        <label for="login_checkbox">
                            <div>로그인 상태 유지</div>
                        </label>
                    </div>
                    <div id="loginPage-resetPassword" class="cf">
                        <a href="find" target="_blank">비밀번호 찾기</a>
                    </div>
                </form>
                <%-- 
                <div id="loginPage-separator"><span>또는</span></div>
                <input type="button" class="loginPage-button facebook" value="페이스북으로 로그인" />
                <div id="naverIdLogin">
                    <a id="naverIdLogin_loginButton" href="javascript:void(null);"><input type="button" class="loginPage-button naver" value="네이버로 로그인"></a>
                </div>
                <div id="kakaoLogin">
                    <a id="kakaoLogin_loginButton" href="${kakao_url}"><input type="button" class="loginPage-button kakao" value="카카오로 로그인"></a>
                </div>
                 --%>
            </div>
            
            
            
		      <%--   

		        <div id="kakao_id_login" style="text-align: center">
		                     <a href="https://kauth.kakao.com/oauth/authorize?client_id=8bba638244771d9bc2d9e2480e608b8b&redirect_uri=http://localhost:8282/alouer&response_type=code">
		                     <img width="223" 
		                        src="${pageContext.request.contextPath}/resources/img/kakao_login_medium_wide.png" /></a>
		        </div>
            
              --%>
            
            
            <div id="loginPage-footer">
                <span>아직 회원이 아니시라면?</span>
                <!-- view/member/register.jsp 이동 -->
                <a href="${pageContext.request.contextPath}/member/join">아루에 회원가입</a>
				</sec:authorize>
            </div>
        </div>
    </div>
	
	

</body>
</html>