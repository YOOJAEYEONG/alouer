<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


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
	});	
	

</script>

<style>
th{text-align: center;}
td{text-align: right;}
#addAuction, .edit{cursor: pointer;display: block;}


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
							<h6 class="m-0 font-weight-bold text-primary">지분경매등록리스트</h6>
							
						</div>
					
						<div class="card-body">
							<div class="table-responsive">

									
								<!-- 검색부분 -->
								<form:form class="form-inline ml-auto" name="searchFrm" method="get"
									action="">
									<div class="form-group">
										<select name="searchField" class="form-control">
											<option value="title">제목</option>
											<option value="name">작가명</option>
											<option value="code">작품코드</option>
											
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
								<br />
								<h2>신규경매 등록</h2>
								<!-- 신규작품 -->
								<table class="table table-bordered table-hover" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											
											<th>제목</th>
											<th>작가</th>
											<th>코드</th>
											<th>시작가</th>
											<th>경매시작</th>
											<th>경매종료</th>
											<th>주식 수</th>
											<th style="width:85px;">등록</th>
											
										</tr>
									</thead>
									<tbody>									
									<c:forEach items="${newList }" var="row">
										<form:form action="auction/add">									
										
										<tr class="bg-light" >											
											<th><input type="text" name="title" value="${row.title }" class="form-control form-control-sm" readonly="readonly" /></th>
											<th><input type="text" name="name" value="${row.name }" class="form-control form-control-sm" readonly="readonly" /></th>
											<th><input type="text" name="code" value="${row.code }"  class="form-control form-control-sm" size="5" readonly="readonly"/></th>
											<th><input type="number" name="startBids" value="" class="form-control form-control-sm" min="0" step="1000" required="required"/></th>
											<th><input type="datetime-local" name="fmtStartTime" value="" class="form-control form-control-sm" placeholder="경매시작" required="required"/></th>
											<th><input type="datetime-local" name="fmtEndTime"  value="" class="form-control form-control-sm" placeholder="경매종료" required="required"/></th>
											<th><input type="number" name="auctionTotal"  value=""  min="1" class="form-control form-control-sm" required="required"/></th>
											<th><button type='submit' class='btn btn-danger'>등록</button></th>		
										</tr>
										</form:form>									
									</c:forEach>									
									</tbody>								
									
								</table>
								<div class="page_pageniation">
									<nav aria-label="Page navigation example">
										<!-- 페이지버튼 -->
										<ul class="pagination justify-content-center">${pagingBtn2 }</ul>
									</nav>
								</div>
								
								
								<br /><hr /><br />
								<h2>진행/마감 경매</h2>	
								<table class="table table-bordered table-hover" id="dataTable" width="100%"
									cellspacing="0">
									
									<colgroup>
										<col width="5%"/><!-- No. -->
										<col width="10%"/><!-- 제목 -->
										<col width="7%"/><!-- 작가 -->
										<col width="10%"/><!-- 코드 -->
										<col width="10%"/><!-- 시작가 -->
										<col width="15%"/><!-- 경매시작 -->
										<col width="10%"/><!-- 경매종료 -->
										<col width="8%"/><!-- 지분수 -->
										<col width="*"/><!-- 비고 -->
										<col width="4%"/><!-- 관리 -->
									</colgroup>
									 
									<thead>
										<tr>
											<th>No.</th>
											<th>제목</th>
											<th>작가</th>
											<th>코드</th>
											<th>시작가</th>
											<th>경매시작</th>
											<th>경매종료</th>
											<th>지분수</th>
											<th>상태</th>
											<th>관리</th>		
										</tr>
									<form:form id="registAuction" >										
										<tr class="bg-light" >
											<th><input type="number" name="auctionId" value="${param.auctionId }" class="form-control form-control-sm" readonly="readonly" /></th>
											<th><input type="text" name="title" value="${param.title }" class="form-control form-control-sm" readonly="readonly" /></th>
											<th><input type="text" name="name" value="${param.name }" class="form-control form-control-sm" readonly="readonly" /></th>
											<th><input type="text" name="code" value="${param.code }"  class="form-control form-control-sm" size="5" required="required"/></th>
											<th><input type="number" name="startBids" value="${param.startBids }" class="form-control form-control-sm" min="0" step="1000" size="6" required="required"/></th>
											<th><input type="datetime-local" name="fmtStartTime" value="${param.fmtStartTime}" class="form-control form-control-sm" placeholder="경매시작" required="required"/></th>
											<th><input type="datetime-local" name="fmtEndTime"  value="${param.fmtEndTime}" class="form-control form-control-sm" placeholder="경매종료" required="required"/></th>
											<th><input type="number" name="auctionTotal"  value="${param.auctionTotal}"  min="1" class="form-control form-control-sm" size="8" required="required"/></th>
											<th colspan="2">
												<c:if test="${empty param.auctionTotal }">
													<button type="submit" class="btn btn-sm btn-primary pr-3 pl-3">등록</button>  												
												</c:if>
												<c:if test="${not empty param.auctionTotal }">
													<div class="btn-group">
														<input type="hidden" name="nowPage" value="${param.nowPage }"/>
														<button type="submit" class="btn btn-sm btn-warning p-1">수정</button>  
														<button type="reset" onclick="location.href='${requestScope['javax.servlet.forward.request_uri']}'" 
															class="btn btn-sm btn-danger p-1">취소</button>  														
													</div>
												</c:if>
											</th>		
										</tr>
									</form:form>
								
									</thead>
									<tbody>
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyyMMddhhmmss" var="nowDate"/><%-- 오늘날짜 --%>
										
										
										
										<c:forEach items="${lists }" var="row" varStatus="status">
										<!-- onclick="location.href='${requestScope['javax.servlet.forward.request_uri']}/addAuction/view?&code=${row.code}&nowPage=${param.nowPage }&' -->
										<c:choose>
											<c:when test="${row.isFinish eq 1}">
											<tr class="auctionId${row.auctionId }"  style="background-color: #dedede;">
											</c:when>
											<c:otherwise>												
											<tr class="auctionId${row.auctionId }" >
											</c:otherwise>											
										</c:choose>							
												
											<!-- onclick="location.href='${
															pageContext.request.contextPath}/admin/auctionView?auctionId=${
															row.auctionId}'" -->
												<td>${row.r}</td>
												<td>${row.title }</td>
												<td>${row.name }</td>
												<td>${row.code}</td>
												<td>${row.startBids}</td>
												<td><fmt:formatDate value="${row.startTime }" type="both" timeStyle="short"/></td>
												<td><fmt:formatDate value="${row.endTime }" type="both" timeStyle="short"/></td>
												<td>${row.auctionTotal}</td>
												<fmt:formatDate value="${row.startTime }" type="both" var="startTime" pattern="yyyyMMddHHmmss"/>
												<fmt:formatDate value="${row.endTime }" type="both" var="endTime" pattern="yyyyMMddHHmmss"/>

												
												<c:if test="${row.isFinish eq 0}">
													<c:if test="${row.startTime < now and now < row.endTime}"><td>입찰중</td></c:if>
													<c:if test="${now > row.endTime}"><td>입찰마감</td></c:if>
													<c:if test="${now < row.startTime}"><td>경매예정</td></c:if>
												</c:if>
												<c:if test="${row.isFinish eq 1}">
													<td>경매종료</td>
												</c:if>
												
													
												<td >
													<span id="${'editAuction' += row.auctionId}" 
														class="edit badge badge-success mb-2 edit" 
														style="float: left;"
														onclick="location.href='${

															pageContext.request.contextPath}/admin/auctionView?auctionId=${
															row.auctionId}'">상세</span>

													<c:if test="${row.isFinish eq 0}">
														<span id="${'editAuction' += row.auctionId}" 
															class="edit badge badge-info mb-2 edit" 
															style="float: left;"
															onclick="location.href='${
																requestScope['javax.servlet.forward.request_uri']}/edit?auctionId=${
																row.auctionId}&nowPage=${param.nowPage }'">수정</span>
													</c:if>

													<c:if test="${now > row.endTime and '0' eq row.isFinish }">
														<span id="${'finishAuction' += status.count}"
															class="edit badge badge-warning mb-2"
															style="float: left;"
															onclick="location.href='${
																requestScope['javax.servlet.forward.request_uri']}/finish?auctionId=${
																row.auctionId}'">종료</span>
													</c:if></td>
											</tr>
										</c:forEach>
										<c:if test="${empty lists }">
											<tr>
												<td colspan="9" class="text-center">검색결과가 없습니다</td>
											</tr>
										</c:if>
									</tbody>
								</table>
								<div class="page_pageniation">
									<nav aria-label="Page navigation example">
										<!-- 페이지버튼 -->
										<ul class="pagination justify-content-center">${pagingBtn }</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				<script src='https://kit.fontawesome.com/a076d05399.js'></script>
				<!-- 페이지상단가기 버튼 -->
				<span onclick="location.href='#'"  class="rounded-circle bg-light" style="cursor: pointer; float: right;position: fixed; top: 92%; left: 96%;" ><i class='fas fa-chevron-circle-up' style='font-size:24px;color: black; box-shadow: black; '></i></span>

		
			<!-- End of Main Content -->



		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->



</body>


<!-- url 에서 parameter 추출 -->
<script>
function getParam(sname) {
    var params = location.search.substr(location.search.indexOf("?") + 1);
    var sval = "";
    params = params.split("&");
    for (var i = 0; i < params.length; i++) {
        temp = params[i].split("=");
        if ([temp[0]] == sname) { sval = temp[1]; }
    }
    return sval;
}
</script>




<script>
$(function(){
	
	if(getParam("resultOfRefund")=="-1"){
		alert("변경되었습니다");
	}

	//form#registAuction 의 action 속성 url 변경해줌 [신규등록요청명 / 수정 요청명]
	if(getParam("auctionTotal") > 0 ){
		console.log("수정모드");
		$("form#registAuction").attr("action","${requestScope['javax.servlet.forward.request_uri']}/upDate")
	}else{
		console.log("신규등록모드");
		$("form#registAuction").attr("action","${requestScope['javax.servlet.forward.request_uri']}/add")
	}
	console.log(getParam("auctionTotal"));
	//console.log(endTime);
	

	//현재 페이지 버튼 active속성부여
	$("li.page-link").css({"backgroundColor":"#274FC2","color":"white"});
	
});

//url 에서 parameter 추출
function getParameter(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}




//300000 => 300,000
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//	"￦800,000" => 800000
function priceParse(price){
	while(price.includes(" ")||price.includes(",")){
		price = price.replace(" ","").replace(",","");
	}
	price = price.replace("￦","");
	price = parseInt(price);
	return price;
}
</script>


<!-- 빈값,널값 체크함수 -->
<script>
function isEmptyFunc(str){
    if(typeof str == "undefined" || str == null || str == ""){
        return true;    	
    }
    else
        return false ;
}
</script>

</html>



































