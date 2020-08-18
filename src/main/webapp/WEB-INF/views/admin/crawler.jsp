<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<script>
	$(function(){
		
	});
	
	function validCheck(){
		var startNum = document.frm.startNum.value;
		var endNum = document.frm.endNum.value;
		
		console.log(startNum);
		console.log(endNum);
		
		if(startNum && endNum){
			return true;
		}
		else{
			alert("시작페이지와 마지막페이지를 입력하세요.");
			return false;
		}
		
		return true;
		
		
	}
</script>
</head>
<body>
	
	<div class="container">
		<h2>크롤링 페이지</h2>
		<form action="crawl.do" name="frm" onsubmit="return validCheck()">
			시작페이지 : <input type="number" name ="startNum"/>
			끝 페이지 : <input type="number" name = "endNum"/>
			<button type="submit" class="btn">크롤링하기</button>
		</form>
	</div>
	
</body>
</html>