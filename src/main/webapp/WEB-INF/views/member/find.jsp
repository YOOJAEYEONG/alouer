<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberFind.css">
<script>
$(function(){

        
});
</script>
</head>
<body>

<div id="contents" data-redirect_after_login="/">
        <div id="resetPassword">
            <h2 id="resetPassword-header">비밀번호 찾기</h2>
            <p id="resetPassword-p">가입 시 입력한 <b>이메일</b>이나 <b>휴대폰번호</b>를 통해<br/>비밀번호를 재설정할 수 있습니다.</p>
            <div id="resetPassword-body">
                <div class="resetPassword-formWrap">
                    <label class="resetPassword-label">이메일로 찾기</label>
                    <form method="post" action="" id="resetPassword-email-form" autocomplete="off">
                        <input type="hidden" name="csrfmiddlewaretoken" value="NWFKWbzP9358rV7iA3kLZzcQYRMWY0h7wvh4ADclCsOoQ1PapnzlliZXZ4GX8gnS">
                        <input type="text" id="resetPassword-email-input" name="email" autocomplete="off" autocorrect="off" autocapitalize="off" placeholder="이메일 주소"/>
                        <input type="submit" id="resetPassword-email-submit" class="resetPassword-button" name="set_password" value="보내기" />
                    </form>
                </div>
                <div class="resetPassword-formWrap">
                    <label class="resetPassword-label">휴대폰으로 찾기</label>
                    <input type="button" id="resetPassword-certifyButton" class="resetPassword-button" value="휴대폰으로 본인인증" />
                </div>
            </div>
        </div>
    </div>

	

</body>
</html>