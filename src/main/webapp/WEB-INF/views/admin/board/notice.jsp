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

<title>관리자 공지사항</title>

<script>

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
							<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
							<!-- 문제될시 폼 태그 밖으로 -->

								<button class="btn btn-Primary float-right" onclick="location.href='boardWrite.do?bname=notice'">글쓰기</button>
								
								
								
								<!-- 검색부분 -->
								<form:form class="form-inline ml-auto" name="searchFrm"
									method="get">
									<div class="form-group">
										<select name="searchField" class="form-control">
											<option value="">전체</option>
											<option value="title">제목</option>
											<option value="name">작가명</option>
											<option value="code">작품코드</option>
											<option value="memberid">렌탈회원</option>
											<option value="transType">구분</option>

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
								</form:form>

								<br></br>
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>조회수</th>
											<th>작성일</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${lists }" var="row">									
												
												<tr>
													<td>${row.virtualNum}</td>
													<td>
													<a href="boardView.do?bname=${params.bname}&idx=${row.idx}&nowPage=${nowPage}&searchField=${params.searchField}&searchTxt=${params.searchTxt}">${row.title}</a>
																				
													</td>
													<td>${row.hits}</td>
													<td>${row.postdate}</td>								
													
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


<div class="modal fade bd-example-modal-lg" id="booking" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-fullsize" role="document">

		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bookingModalLabel">예약관리</h5>
				 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          			<span aria-hidden="true">&times;</span>
			</div>

			<div class="modal-body">
				<!-- 검색부분 -->
				<%-- <form:form class="form-inline ml-auto" name="modalAearchFrm"
					method="get">
					<div class="form-group">
						<select name="moSearchField" class="form-control">
							<option value="code">작품코드</option>
						</select> &nbsp;

						<div class="input-group">

							<input type="text" name="moSearchTxt" id="searchfrm"
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

				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th style="width:70px;">순번</th>
							<th>작품코드</th>
							<th>대기회원아이디</th>
							<th>예약시간</th>
						</tr>
					</thead>
					<form:form>
						<tbody id="moCont">
							


						</tbody>
					</form:form>
				</table>
				<div id="paging" class="text-center"></div>
			</div>
		
			<div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	     	</div>
			
		</div>
	</div>
</div>












</html>
