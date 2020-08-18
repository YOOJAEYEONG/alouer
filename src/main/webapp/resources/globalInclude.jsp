<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!--JSTL -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--View 페이지에 Spring-Security에서 제공하는 폼태그를 사용하기위한 CDN-->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!--security taglib을 사용하고 싶은 jsp 파일 상단에 다음과 같이 선언합니다-->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- Load the Google Platform Library-->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/api:client.js"></script>
<!--Specify your app's client ID  -->
<meta name="google-signin-client_id" content="37712299698-a21hqmkbb90erkdguaaqd3lp7plgpb9s.apps.googleusercontent.com">
<meta name="google-signin-scope" content="profile email">


<!--jquery와 부트스트랩 CDN 추가함 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<!--CSS속성 설정파일-->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/globalCSS.css" />
<!--파비콘-->
<link rel="icon" href="${pageContext.request.contextPath }/resources/favicon.ico">

<!--컨텍스트루트 : ${pageContext.request.contextPath }  -->









