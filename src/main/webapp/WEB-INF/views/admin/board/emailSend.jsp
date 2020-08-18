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
<script>
//제목과 내용 작성했는지 확인
function checkForm(f) {
	if(f.title.value==""){
		alert("Write in the title!!!");
		f.title.focus();
		return false;
	}
	else if(f.contents.value==""){
		alert("Write in the content!!!");
		f.contents.focus();
		return false;
	}

}
</script>

<form action=<c:url value="/admin/mailSending.do" /> method="post" onsubmit="return checkForm(this);">
	<input type="hidden" name="bname" value="${params.bname}"/>
	<table class="table table-hover col-lg-10" style="margin-left: auto; margin-right: auto;">
		<colgroup>
			<col width="15%"/>
			<col width="*"/>
		</colgroup>
		
		
		<tr>
			<th class="text-center" style="vertical-align:middle;">작성회원</th>
			<!-- 나중에 value부분은 회원의 아이디를 받아 오는 것으로 한다(${list.memberId}로)-->
			<td>
				<input type="text" name="to" size="70" value="jjeongjackie@gmail.com" class="form-control">
			</td>
		</tr>
		<tr>
			<th class="text-center" style="vertical-align:middle;">제목</th>
			<td>
				<input style="width:100%;" name="title" type="text" value="${list.title} "/>			
			</td>
				
		</tr>

		<tr>	
			<th class="text-center" style="vertical-align:middle;">내용</th>									
			<td>
				<textarea name="contents" id="" style="width:100%;" rows="10">${list.contents }</textarea>
			</td>
		</tr>
		
		
		
		<tr>
			<!-- 관리자가 이메일로 보낼 내용 -->
			<!-- <th class="text-center" style="vertical-align:middle;">작성자</th> -->
			
				<input type="hidden" name="from" size="70" value="jjeong1992@naver.com" class="form-control">
			
		</tr>
		
		<tr>
			<th class="text-center" style="vertical-align:middle;">제목</th>
			<td>
				<input type="text" name="mailtitle" size="100" placeholder="제목 입력" class="form-control" value="답변 : ${list.title}">
			</td>
		</tr>
		
		<tr>
			<th class="text-center" style="vertical-align:middle;">내용</th>
			<td>
				<textarea name="mailcontents" cols="170" rows="10" style="width: 100%;" class="form-control"
				placeholder="답변을 작성하세요"></textarea>		
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