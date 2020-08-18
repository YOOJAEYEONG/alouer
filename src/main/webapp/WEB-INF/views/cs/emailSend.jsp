<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<form action=<c:url value="/cs/mailSending.do" /> method="post" onsubmit="return check(this);">

	<table class="table table-hover col-lg-8" style="margin-left: auto; margin-right: auto;">
		<colgroup>
			<col width="15%"/>
			<col width="*"/>
		</colgroup>
		<tr>
			<!-- 보내는 이 -->
			<th class="text-center" style="vertical-align:middle;">작성자</th>
			<td>
				<input type="text" name="from" size="70" value="jjeong1992@naver.com" class="form-control">
			</td>
		</tr>
		
		<tr>
			<th class="text-center" style="vertical-align:middle;">받는이</th>
			<td>
				<input type="text" name="to" size="70" value="" class="form-control">
			</td>
		</tr>
		
		<tr>
			<th class="text-center" style="vertical-align:middle;">제목</th>
			<td>
				<input type="text" name="title" size="100" placeholder="제목 입력" class="form-control">
			</td>
		</tr>
		
		<tr>
			<th class="text-center" style="vertical-align:middle;">내용</th>
			<td>
				<textarea name="contents" cols="170" rows="10" style="width: 100%;" class="form-control"
				placeholder="답변을 작성하세요">
				
				</textarea>		
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="submit" class="btn btn-outline-secondary" onsubmit="checkForm(this);">
					Submit
				</button>
			</td>
		</tr>
	</table>

</form>

</body>
</html>