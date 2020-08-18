<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>관리자 1:1문의 게시판</title>

<script>
$(function(){

	//페이지에서 완료/대기된 게시글 확인 
	$('#replySelect').change(function(){
		//alert("변경2");
        var k = $(this).val();
        $("#dataTable > tbody > tr").hide();
        var temp = $("#dataTable > tbody > tr > td:nth-child(5n+5):contains('" + k + "')");
        $(temp).parent().show();
    })
	
}); //제이쿼리 end
</script>
<style>

</style>

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
							<h6 class="m-0 font-weight-bold text-primary">관리자 1:1문의게시판</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
							<!-- 문제될시 폼 태그 밖으로 -->
								<%-- <button class="btn btn-Primary float-right" onclick="location.href='boardWrite.do?bname=faq'">
									글쓰기
								</button>
								
		
								<!-- 검색부분 -->
								<form:form class="form-inline ml-auto" name="searchFrm"
									method="get">
									<div class="form-group">
										<select name="searchField" class="form-control">
											<option value="">전체</option>
											<option value="name">답변 대기</option>
											<option value="name">답변 완료</option>


										</select> &nbsp;

										<div class="input-group">

											<input type="text" name="searchTxt" id="searchfrm"
												class="form-control" placeholder="검색어를 입력하세요">
											<div class="input-group-append">
												<button type="submit" class="btn btn-primary" type="button"
													href="#">
													<i class="fas fa-search fa-sm"></i>
												</button>
											</div>
										</div>
									
									</div>
								</form:form> --%>

								<br></br>
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>아이디</th>
											<th>작성일${row.replyOX }</th>
											<th>
											<select name="replySelect" id="replySelect" class="form-control">
												<option value="">전체</option>
												<option value="대기">답변 대기</option>
												<option value="완료">답변 완료</option>
											</select>
											</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${lists }" var="row">									
												
												<tr>
													<td>${row.virtualNum}</td>
													<td>
													<a href="boardView.do?bname=${params.bname}&idx=${row.idx}&nowPage=${nowPage}&searchField=${params.searchField}&searchTxt=${params.searchTxt}">${row.title}</a>
																				
													</td>
													<td>${row.memberId}</td>								
													<td>${row.postdate}</td>								
													<c:if test="${row.replyOX eq 1}">
													 <td><span class="badge badge-primary">답변 완료</span><input type="hidden" name="replyOX" readonly="readonly" id="replyOX" value="${row.replyOX }"  /></td>
													</c:if>
													<c:if test="${row.replyOX eq 0}">
													 <td><span class="badge badge-danger">답변 대기</span><input type="hidden" name="replyOX" readonly="readonly" id="replyOX" value="${row.replyOX }"  /></td>
													 </c:if>
												</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>


				</div>
				<!-- /.container-fluid -->
				<div class="page_pageniation">
					<nav aria-label="Page navigation example">
						<!-- 페이지버튼 -->
						<ul class="pagination justify-content-center">${pagingImg }</ul>
					</nav>
				</div>
			</div>
			<!-- End of Main Content -->



		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->



</body>


</html>
