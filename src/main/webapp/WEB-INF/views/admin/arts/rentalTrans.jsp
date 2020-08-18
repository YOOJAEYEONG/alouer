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

<title>SB Admin 2 - Dashboard</title>

<script>
	

	
	$(function(){

		/* 페이지 로드시 작품상태 설정(셀렉트박스) */
		$("td[name='transName']").each(function(index){
			console.log(index);	
			
			var sel = $(this).children("input[type='hidden']").val();
						
			$(this).children().children().val(sel).prop("selected", true);
		});
				

		
		$("input[name='code'], input[name='memberId']").on('click',
				function(){	
			
			$(this).removeAttr("readonly");	
			/* $("td[name='item']").off("click"); */			
			
		});
		

		
		
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
		
		///////////////////////////////////////
		
		//모달
		
		///////////////////////////////////////
		
		//예약 모달
		$("button[name='bookMo']").click(function(){
						
			var code = $(this).parent().parent().parent().children().children("input[name='code']").val();
			
			console.log(code);
			
			$.ajax({
				url:'rental/bookingList',			
				type:"get",
				contentType : "text/html;charset:utf-8",
				data: {
					code : code
				},
				dataType : 'json',
				success : lists,
				error :function(e){
					console.log("DB연결실패");
				}
			
			});
			
		});
		//렌탈내역 모달
		$("button[name='history']").click(function(){					
			
			
			var code = $(this).parent().parent().parent().children().children("input[name='code']").val();
			alert(code);
			
			$.ajax({
				url:'rental/transList',			
				type:"get",
				contentType : "text/html;charset:utf-8",
				data: {					
					code : code
				},
				dataType : 'json',
				success : listHistory,
				error :function(e){
					alert("DB연결실패");
				}			
			});
			
		});
				
		
		
	});//jquery end	
	
	/* 렌탈 예약 페이징 */
	function paging(pNum){		
		
		var code = $(".modal-body tr td[name='code']").eq(0).text();
		
		$.ajax({
			url : 'rental/bookingList',
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : { code : code, 
				nowPage : pNum },
			dataType : "json",
			success : lists,
			error: function(e){
				alert("실패" + e);
			}
			
		});
	}
	
	/* 렌탈 예약리스트 */
	function lists(d){					
		let htmlStr = ""
		
		var parStr = JSON.stringify(d);
		var par = JSON.parse(parStr);		
		console.log("par:" +JSON.stringify(par.pagingImg));
		
		console.log("par.lists:" + JSON.stringify(par.lists));
		var lists = par.lists;
		
		$(lists).each(function(i){
			
			console.log(i);
			var dto = lists[i];
			console.log("dto:"+JSON.stringify(dto));					
			
			htmlStr +=
				'<tr>' +
				"<td>"+dto.virtualNum+"</td>"+ 		
				"<td name='code'>"+ dto.code +"</td>"+ 		
				"<td>"+ dto.memberId +"</td>"+ 		
				"<td>"+dto.jsTime+"</td>"

				;
		});					
		
			$("#moCont").html(htmlStr);
			$("#paging").html(par.pagingImg);
			console.log(htmlStr);
		
		$("#booking").modal('show');
							
	}
	
	
	/* 렌탈거래 리스트 */
	function listHistory(d){					
		let htmlStr = ""
		
		var parStr = JSON.stringify(d);
		var par = JSON.parse(parStr);		
		console.log("par:" +JSON.stringify(par.pagingImg));
		
		console.log("par.lists:" + JSON.stringify(par.lists));
		var lists = par.lists;
		
		$(lists).each(function(i){
			
			console.log(i);
			var dto = lists[i];
			console.log("dto:"+JSON.stringify(dto));					
			
			htmlStr +=
				'<tr>' +
				"<td>"+dto.virtualNum+"</td>"+ 		
				"<td>"+dto.idx+"</td>"+ 		
				"<td name='code'>"+ dto.code +"</td>"+ 		
				"<td>"+ dto.memberId +"</td>"+ 		
				"<td>"+dto.rentalBegin+"</td>"+
				"<td>"+dto.rentalEnd+"</td>"+
				"<td>"+dto.returnDate+"</td>"+
				"<td>"+dto.transType+"</td>"+
				"<td>"+dto.totalAmount+"</td>"
				+"</tr>"
				;
		});					
		
			$("#moContHis").html(htmlStr);
			$("#pagingHis").html(par.pagingImg);
			console.log(htmlStr);
		
		$("#rentalHistory").modal('show');
							
	}
	/* 렌탈거래 페이징 */
	function pagingHistory(pNum){		
		
		var code = $("div[name='hisMoBody'] tr td[name='code']").eq(0).text();
		console.log("페이징요청코드:"+code);
		$.ajax({
			url : 'rental/transList',
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : { code : code, 
				nowPage : pNum },
			dataType : "json",
			success : listHistory,
			error: function(e){
				alert("실패" + e);
			}
			
		});
	}

</script>
<style>
.modal-content.modal-fullsize {
  height: auto;
  min-height: 100%;
  border-radius: 0; 
}



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
							<h6 class="m-0 font-weight-bold text-primary">렌탈관리</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">

								<!-- 검색부분 -->
								<form:form class="form-inline ml-auto" name="searchFrm"
									method="get">
									<div class="form-group">
										<select name="searchField" class="form-control">
											<option value="">전체</option>
											<option value="title">제목</option>
											<option value="name">작가명</option>
											<option value="C.code">작품코드</option>
											<option value="memberid">렌탈회원</option>
											<option value="transType">상태</option>
											
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


								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>번호</th>											
											<th>주문번호</th>											
											<th>작품코드</th>
											<th>작품제목</th>
											<th style="width: 89px;">작가명</th>
											<th>렌탈회원</th>
											<th>상태</th>
											<th>렌탈시작</th>
											<th>렌탈종료</th>
											<th>반납일</th>
											<th style="width: 85px;">구분</th>

										</tr>
									</thead>
									<tbody>

									
										<c:forEach items="${lists }" var="row">
											<form:form name="modifyFrm" action="rental/insertRT" method="get">
												<tr>
													<td>${row.virtualNum }</td>
													<td>${row.idx }</td>
													<%-- <td>${row.idx }<input type="hidden" name="idx"
														value="${row.idx }" />
													</td> --%>
													<td><input name="code" type="text"
														class="form-control" value="${row.code }" readonly /></td>
													<td>${row.title }</td>
													<td>${row.name }</td>
													<td><input name="memberId" id="memberId" type="text"
														class="form-control" value="${row.memberId }" readonly />
														<span name="idCheckTxt"></span></td>
													<td style="width: 130px;" name="transName">
													<input type="hidden" value="${row.transType }" />
														<div class="form-group" name="transDiv">
															<select class="form-control" name="transType">
																<option val="렌탈가능">렌탈가능</option>
																<option val="렌탈중">렌탈중</option>
																<option val="반납">반납</option>
																<option val="취소">취소</option>
															</select>
														</div></td>

													<td><input name="rentalBegin" type="date"
														class="form-control" value="${row.rentalBegin }" /></td>
													<td><input name="rentalEnd" type="date"
														class="form-control" value="${row.rentalEnd }" /></td>
													<td><input name="returnD" type="date"
														class="form-control" value="${row.returnDate }" /></td>
													<td> 
														
														<div style="margin-bottom:1px">
														<button type="button" class="btn btn-primary" name="bookMo" id="bookMo">예약</button>
														</div>
														<div style="margin-bottom:1px">
														<button class="btn btn-Primary" type="button" name="history" >내역</button>
														</div>
														<div>
														<button class="btn btn-Primary" type="submit">저장</button>
														</div>
													</td>
												</tr>
											</form:form>

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


<!-- 예약 모달 -->
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

<!-- 렌탈내역 모달 -->

<div class="modal fade bd-example-modal-lg" id="rentalHistory" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-fullsize" role="document">

		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bookingModalLabel">렌탈내역</h5>
				 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          			<span aria-hidden="true">&times;</span>
			</div>

			<div class="modal-body history" id="hisMoBody" name="hisMoBody">

				<table class="table table-bordered" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th style="width:70px;">번호</th>
							<th>주문번호</th>
							<th>작품번호</th>
							<th>주문회원</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>반납일</th>
							<th>구분</th>
							<th>주문금액</th>
						</tr>
					</thead>
					<form:form>
						<tbody id="moContHis">
							


						</tbody>
					</form:form>
				</table>
				<div id="pagingHis" class="text-center"></div>
			</div>
		
			<div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	     	</div>
			
		</div>
	</div>
</div>









</html>
