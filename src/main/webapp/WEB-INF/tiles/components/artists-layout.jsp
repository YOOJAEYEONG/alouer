<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--Spring Security에서 제공하는 security 관련 태그사용을 위한 선언  -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<html>
<head>
	
	<tiles:insertAttribute name="head" />
</head>
<body>
	<tiles:insertAttribute name="navi" />


	<tiles:insertAttribute name="content" />

</body>
	<tiles:insertAttribute name="footer" />
</html>