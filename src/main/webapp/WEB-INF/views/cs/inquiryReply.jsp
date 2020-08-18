<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@page import="smtp.SMTPAuth"%> --%><!-- 이메일 보내기용 -->
<%-- <%
request.setCharacterEncoding("UTF-8");
SMTPAuth smtp = new SMTPAuth();

Map<String,String> emailContent = new HashMap<String, String>();
emailContent.put("from", request.getParameter("from"));
emailContent.put("to", request.getParameter("to"));
emailContent.put("subject", request.getParameter("subject"));
emailContent.put("content", request.getParameter("content"));

if(request.getParameter("content")!=null){
	boolean emailResult = smtp.emailSending(emailContent);
	if(emailResult==true){
		out.print("메일발송성공");
	}
	else{
		out.print("메일발송 실패");
	}
	return;
}
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">

<form action="/admin/cs/mailSending.do" method="post">
<table>
	<tr>
		<!-- 문의글을 작성한 회원의 이메일이 입력되어있는 '받는이' 란 -->
		<!-- 멤버아이디는 컨트롤러에서 모델에 "view"로 저장했다. -->
		<!-- 상세보기에서 받은 폼값을 적용시킨다(멤버아이디에) -->
		<td>
			<input type="text" name="to" size="70" value="jjeong1992@naver.com" class="form-control">
		</td>
		<td>
			<input type="text" name="from" size="70" value="" class="form-control">
		</td>
		<!-- 제목 -->
		<td style="text-align: center;">
			<input type="text" name="title" size="100" placeholder="제목 입력" class="form-control">
		</td>
	</tr>
	<tr>
		<td>
			<textarea name="contents" cols="170" rows="10"
            style="width: 100%; resize: none" placeholder="내용"
            class="form-control"></textarea>
		
		</td>
	</tr>
</table>
<div align="center">
  <input type="submit" value="메일 보내기" class="btn btn-warning">
</div>
    
</form>

</div><!-- end of container class -->

</body>
</html>