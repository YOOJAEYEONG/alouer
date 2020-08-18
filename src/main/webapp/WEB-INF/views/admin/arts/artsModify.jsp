<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>작품 정보 수정</title>


<style type="text/css">
	label {
		float: left;
	}
	.table td, .table th {
    	vertical-align: middle;
    }
</style>

<script>
</script>

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">작품 정보 수정</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								
								
								<!-- 정보 입력 폼  -->
								<form:form class="form-inline " name="writeFrm" method="post" 
									action="modifyAction.do" onsubmit="checkFile()" enctype="multipart/form-data">
									
									<table class="table" id="dataTable" width="100%">
										<colgroup>
											<col width="150px" text-align="left">
											<col width="*">
										</colgroup>
										
										<tr>
											<td><label for="code">작품 코드</label></td>
											<td>
												<input type="text" name="code" id="code" class="form-control" required="required" value="${artEdit.code }"/>
											</td>
										</tr>
										<tr>
											<td><label for="title">작품 제목</label></td>
											<td>
												<input type="text" name="title" id="title" class="form-control" required="required"  value="${artEdit.title }"/>
											</td>
										</tr>
										<tr>
											<td><label for="memberId">작가 아이디</label></td>
											<td>
												<input type="text" name="memberId" id="memberId" class="form-control" required="required" value="${artEdit.memberId }"/>
											</td>
										</tr>
										<tr>
											<td><label for="name">작가 이름</label></td>
											<td>
												<input type="text" name="name" id="name" class="form-control" required="required" value="${artEdit.name }"/>
											</td>
										</tr>
										<tr>
											<td><label for="note1">큐레이터 노트</label></td>
											<td>
												<textarea name="note1" class="form-control" rows="5" id="note1"
													style="width:50%;">${artEdit.note1 }</textarea>
											</td>
										</tr>
										<tr>
											<td><label for="note2">추천 이유</label></td>
											<td>
												<textarea name="note2" class="form-control" rows="5" id="note2"
													style="width:50%;">${artEdit.note2 }</textarea>
											</td>
										</tr>
										<tr>
											<td><label for="material">재료</label></td>
											<td>
												<input type="text" name="material" id="material" class="form-control" required="required" value="${artEdit.material }"/>
											</td>
										</tr>
										<tr>
											<td><label for="prodYear">제작년도</label></td>
											<td>
												<input type="number" name="prodYear" id="prodYear" class="form-control"
													 maxlength="4" required="required" value="${artEdit.prodYear }"/> 년
											</td>
										</tr>
										<tr>
											<td><label for="sizeHo">그림 호수</label></td>
											<td>
												<input type="number" name="sizeHo" id="sizeHo" class="form-control" required="required" value="${artEdit.sizeHo }"/> 호
											</td>
										</tr>
										<tr>
											<td><label for="size">그림 사이즈</label></td>
											<td>
												<input type="text" name="height" id="size" class="form-control"
													placeholder="세로(cm)" required="required" value="${artEdit.height }"/>
												<input type="text" name="width" id="size" class="form-control"
													placeholder="가로(cm)" required="required" value="${artEdit.width }"/>
											</td>
										</tr>
										<tr>
											<td><label for="regiDate">작품 등록일</label></td>
											<td>
												<input type="date" name="regiDate" id="regiDate" class="form-control" required="required" value="${artEdit.regiDate }"/>
											</td>
										</tr>
										<tr>
											<td><label for="imageUrl">작품 이미지</label></td>
											<td>
												<!-- 첨부이미지 미리보기 -->													
												<c:choose>
											         <c:when test="${ fn:contains(artEdit.imageUrl, 'https')}">
											            <%-- <img src="${artEdit.imageUrl }" style="width: 80px; height: auto;" /> --%>
											            <script>
											            $(function () {
											            	$('#image_section').removeAttr('hidden'); //hidden 속성 제거
												            $('#image_section').attr('style', 'width:200px; padding-top:20px;');
															$('#image_section').attr('src', '${artEdit.imageUrl}');
														});
											            </script>
											         </c:when>
											         <c:otherwise>
											         	<%-- <img src="${pageContext.request.contextPath }/${artEdit.imageUrl }" style="width: 80px; height: auto;" /> --%>
											         	<script>
											         	$(function () {
											            	$('#image_section').removeAttr('hidden'); //hidden 속성 제거
												            $('#image_section').attr('style', 'width:200px; padding-top:20px;');
															$('#image_section').attr('src', '${pageContext.request.contextPath }/${artEdit.imageUrl }');
														});
											            </script>
											         </c:otherwise>
										      	</c:choose>
										      	
										      	<!-- <script>
											      	function checkFile() {
										      			var file = document.getElementById('imageUrl').value;
										      			
										      			if (!file) {
										      				
														}
														
													}
										      		
										      	</script> -->
										      	
												<!-- 이미지 첨부 버튼 -->
												<input type='file' id="imageUrl" name="imageUrl-param" class="form-control" hidden/><br>
												<!-- 외부버튼 : 클릭 시 이미지 첨부버튼 클릭작동 -->
												<input type='button' id="imageUrlBtn" name="imageUrl-param" class="form-control" value="이미지 변경"/><br>
												<!-- 첨부된 이미지 미리보기 영역 (jQuery chage 함수로 실행됨) -->
												<img id="image_section" src="#" hidden/>
											</td>
										</tr>
										<tr>
											<td><label for="artValue">작품 추정가치</label></td>
											<td>
											<!-- JSTL 국제화 태그로 1000단위 콤마 표시하기 --> 
											<fmt:formatNumber value="${artEdit.artValue }" var="num"/>
												<input type='text' id="artValue" name="artValueStr" class="form-control" required="required" 
													value="${num }" /> 원
											</td>
										</tr>
										<tr>
											<td><label for="rentalPrice">렌탈가격</label></td>
											<td>
											<!-- JSTL 국제화 태그로 1000단위 콤마 표시하기 --> 
											<fmt:formatNumber value="${artEdit.rentalPrice }" var="num"/>
												<input type='text' id="rentalPrice" name="rentalPriceStr" class="form-control" required="required" 
													value="${num }"/> 원
											</td>
										</tr>
										<tr>
											<td><label for="theme">작품 테마</label></td>
											<td name="whichValue">
												<input type="hidden" value="${artEdit.theme }"/>
												<select class="form-control selectpicker" id="theme" name="theme" required="required">
													<option value="인물">인물</option>
													<option value="풍경">풍경</option>
													<option value="정물">정물</option>
													<option value="동물">동물</option>
													<option value="추상">추상</option>
													<option value="상상">상상</option>
												</select>
											</td>
										</tr>
										<tr>
											<td><label for="color">작품 색깔</label></td>
											<td name="whichValue">
												<input type="hidden" value="${artEdit.color }" />
												<select class="form-control selectpicker" id="color" name="color" required="required">
													<option value="빨강">빨강</option>
													<option value="파랑">파랑</option>
													<option value="초록">초록</option>
													<option value="노랑">노랑</option>
													<option value="파스텔">파스텔</option>
													<option value="흑백">흑백</option>
													<option value="기타">기타</option>
												</select>
											</td>
										</tr>
										<tr>
											<td><label for="status">현재 거래상태</label></td>
											<td name="whichValue">
												<input type="hidden" value="${artEdit.status }" />
												<select class="form-control selectpicker" id="status" name="status" required="required">
													<option value="준비중">준비중</option>
				                                       <option value="렌탈중">렌탈중</option>
				                                       <option value="렌탈준비중">렌탈준비중</option>
				                                       <option value="렌탈가능">렌탈가능</option>
				                                       <option value="지분경매">지분경매</option>
				                                       <option value="경매준비중">경매준비중</option>
												</select>
											</td>
										</tr>					
										<tr>
											<td></td>
											<td style="text-align:right;">
												<!-- <input type="text" hidden="hidden" name="lat" value=""/>
												<input type="text" hidden="hidden" name="lng" value=""/> -->
												<!-- 등록 완료 버튼 -->
												<button type="submit" class="btn btn-primary" href="#">수정하기</button>
												<button class="btn btn-danger" onclick="history.back()">취소</button>
											</td>
										</tr>					
									</table>
								
								</form:form>
								
							</div>
						</div>
					</div>
					


				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->



		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

<script>

/* 작가 아이디  */
$(function () {
	$("input[name = 'memberId']").on('keyup', function(){
		var id = $(this).val();
		var idTxt = $(this).next(); 
		
		$.ajax({
			url:'rental/idCheck',			
			type:"get",
			contentType : "text/html;charset:utf-8",
			data: {
				memberId : id
			},
			success : function(d){
				if(d>0){
					idTxt.html("<span name='idChk' style='color:blue;'>입력가능</span>");
				}
				else{
					idTxt.html("<span name='idChk' style='color:red;'>입력불가</span>");
				}
			},
			error :function(e){
				idTxt.html("<span name='idChk' style='color:red;'>DB연결실패</span>");
			}
		});
	});
});
											



/* 첨부된 이미지 미리보기 영역에 띄우기 */
function readURL(input) {
	if (input.files && input.files[0]) {
		
		var reader = new FileReader();
		var html = '';
		
		reader.onload = function (e) {											 
			$('#image_section').removeAttr('hidden'); //hidden 속성 제거
			$('#image_section').attr('style', 'width:200px; padding-top:20px;');
			$('#image_section').attr('src', e.target.result);
		}
		
		reader.readAsDataURL(input.files[0]);
	}
}
	 
$(function() {
	//외부버튼 클릭 시 파일첨부 작동
	$('#imageUrlBtn').click(function(e) {
		e.preventDefault();
		$('#imageUrl').click();
	});
});


// 이벤트를 바인딩해서 input에 파일이 올라올때 위의 함수를 this context로 실행합니다.
$("#imageUrl").change(function(){
	readURL(this);
});

$("td[name='transName']").each(function(index){
	console.log(index);	
	
	var sel = $(this).children("input[type='hidden']").val();
				
	$(this).children().children().val(sel).prop("selected", true);
});


// DB의 값에 맞는 옵션 selected로 변경하기
$(function(){
	//select 박스의 옵션값 처리
	$("td[name='whichValue']").each(function(index){
		console.log(index);	
		
		var sel = $(this).children("input[type='hidden']").val();
		console.log(sel);
		
		$(this).children().val(sel).prop("selected", true);
	});
	/* $("td[name='whichValue2']").each(function(index){
		console.log(index);	
		
		var sel = $(this).children("input[type='hidden']").val();
		console.log(sel);
		
		$(this).children().children().val(sel).prop("selected", true);
	});
	$("td[name='whichValue3']").each(function(index){
		console.log(index);	
		
		var sel = $(this).children("input[type='hidden']").val();
		console.log(sel);
		
		$(this).children().children().val(sel).prop("selected", true);
	}); */
});


</script>

</body>

</html>