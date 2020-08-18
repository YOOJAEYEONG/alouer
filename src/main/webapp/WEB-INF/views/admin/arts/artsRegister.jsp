<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>신규 작품 등록</title>


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
							<h6 class="m-0 font-weight-bold text-primary">신규 작품 등록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								
								
								<!-- 정보 입력 폼  -->
								<form:form class="form-inline " name="writeFrm" method="post" 
									action="registerAction.do" enctype="multipart/form-data">
									
									<table class="table" id="dataTable" width="100%">
										<colgroup>
											<col width="150px" text-align="left">
											<col width="*">
										</colgroup>
										
										<tr>
											<td><label for="code">작품 코드</label></td>
											<td>
												<input type="text" name="code" id="code" class="form-control"
													placeholder="A0000-0000" required="required"/>
											</td>
										</tr>
										<tr>
											<td><label for="title">작품 제목</label></td>
											<td>
												<input type="text" name="title" id="title" class="form-control" required="required"/>
											</td>
										</tr>
										<tr>
											<td><label for="memberId">작가 아이디</label></td>
											<td>
												<input type="text" name="memberId" id="memberId" class="form-control" required="required"/>
											</td>
										</tr>
										<tr>
											<td><label for="name">작가 이름</label></td>
											<td>
												<input type="text" name="name" id="name" class="form-control" required="required"/>
											</td>
										</tr>
										<tr>
											<td><label for="note1">큐레이터 노트</label></td>
											<td>
												<textarea name="note1" class="form-control" rows="5" id="note1"
													style="width:50%;"></textarea>
											</td>
										</tr>
										<tr>
											<td><label for="note2">추천 이유</label></td>
											<td>
												<textarea name="note2" class="form-control" rows="5" id="note2"
													style="width:50%;"></textarea>
											</td>
										</tr>
										<tr>
											<td><label for="material">재료</label></td>
											<td>
												<input type="text" name="material" id="material" class="form-control" required="required"/>
											</td>
										</tr>
										<tr>
											<td><label for="prodYear">제작년도</label></td>
											<td>
												<input type="number" name="prodYear" id="prodYear" class="form-control"
													 maxlength="4" value="" required="required"/> 년
											</td>
										</tr>
										<tr>
											<td><label for="sizeHo">그림 호수</label></td>
											<td>
												<input type="number" name="sizeHo" id="sizeHo" class="form-control" required="required"/> 호
											</td>
										</tr>
										<tr>
											<td><label for="size">그림 사이즈</label></td>
											<td>
												<input type="text" name="height" id="size" class="form-control"
													placeholder="세로(cm)" required="required"/>
												<input type="text" name="width" id="size" class="form-control"
													placeholder="가로(cm)" required="required"/>
											</td>
										</tr>
										<tr>
											<td><label for="regiDate">작품 등록일</label></td>
											<td>
												<input type="date" name="regiDate" id="regiDate" class="form-control" required="required"/>
											</td>
										</tr>
										<tr>
											<td><label for="imageUrl">작품 이미지</label></td>
											<td>
												<!-- 이미지 첨부 버튼 -->
												<input type='file' id="imageUrl" name="imageUrl-param" class="form-control" required="required"/><br>
												<!-- <input type='file' id="imageUrltest" name="imageUrl" class="form-control"/><br> -->
												<!-- 첨부된 이미지 미리보기 영역 (jQuery chage 함수로 실행됨) -->
												<img id="image_section" src="#" hidden/>
											</td>
										</tr>
										<tr>
											<td><label for="artValue">작품 추정가치</label></td>
											<td>
												<input type='number' id="artValue" name="artValue" class="form-control" required="required"/> 원
												<!-- JSTL 국제화 태그로 1000단위 콤마 표시하기 --> 
												<%-- <fmt:formatNumber value="${info.rentalPrice }" />원 --%>
											</td>
										</tr>
										<tr>
											<td><label for="rentalPrice">렌탈가격</label></td>
											<td>
												<input type='number' id="rentalPrice" name="rentalPrice" class="form-control" required="required"/> 원
												<!-- JSTL 국제화 태그로 1000단위 콤마 표시하기 --> 
												<%-- <fmt:formatNumber value="${info.rentalPrice }" />원 --%>
											</td>
										</tr>
										<tr>
											<td><label for="theme">작품 테마</label></td>
											<td>
												<select class="form-control selectpicker" id="theme" name="theme" required="required">
													<option value="인물">인물</option>
													<option value="풍경">풍경</option>
													<option value="정물">정물</option>
													<option value="동물">동물</option>
													<option value="추상">추상</option>
												</select>
											</td>
										</tr>
										<tr>
											<td><label for="color">작품 색깔</label></td>
											<td>
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
											<td>
												<select class="form-control selectpicker" id="status" name="status" required="required">
													<option value="준비중">준비중</option>
													<option value="렌탈중">렌탈중</option>
													<option value="렌탈가능">렌탈가능</option>
													<option value="지분거래중">지분거래중</option>
													<option value="지분경매중">지분경매중</option>
												</select>
											</td>
										</tr>					
										<tr>
											<td></td>
											<td style="text-align:right;">
												<!-- <input type="text" hidden="hidden" name="lat" value=""/>
												<input type="text" hidden="hidden" name="lng" value=""/> -->
												<!-- 등록 완료 버튼 -->
												<button type="submit" class="btn btn-primary">등록하기</button>
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
											
/* 현재 날짜 구해와서 출력 */
document.getElementById('regiDate').value = new Date().toISOString().substring(0, 10);


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
	 
// 이벤트를 바인딩해서 input에 파일이 올라올때 위의 함수를 this context로 실행합니다.
$("#imageUrl").change(function(){
	readURL(this);
});

</script>

</body>

</html>