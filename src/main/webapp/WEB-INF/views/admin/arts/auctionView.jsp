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
th {
	text-align: center;
}

td {
	text-align: right;
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
							<h6 class="m-0 font-weight-bold text-primary">지분경매등록정보</h6>
						</div>

						<div class="card-body">
							<div class="table-responsive">


								<table class="table table-bordered table-hover" id="dataTable"
									width="100%" cellspacing="0">
									<colgroup>
										<col />
										<col />
										<col />
										<col />
										<col />
										<col />
										<col />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th>경매번호</th>
											<th>작품코드</th>
											<th>입찰시작가</th>
											<th>경매시작</th>
											<th>경매종료</th>
											<th>옥션수량</th>
											<th>비고</th>
										</tr>

									</thead>

									<tbody>
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyyMMddhhmmss"
											var="nowDate" />
										<c:if test="${not empty auctionInfoDTO }">


											<!-- onclick="location.href='${requestScope['javax.servlet.forward.request_uri']}/addAuction/view?&code=${auctionInfoDTO.code}&nowPage=${param.nowPage }&' -->
											<tr class="auctionId${auctionInfoDTO.auctionId }"
												onclick="location.href='${
																requestScope['javax.servlet.forward.request_uri']}/view?auctionId=${
																auctionInfoDTO.auctionId}'">
												<td>${auctionInfoDTO.auctionId}</td>
												<td>${auctionInfoDTO.code}</td>
												<td><fmt:formatNumber value="${auctionInfoDTO.startBids}" /></td>
												<td><fmt:formatDate value="${auctionInfoDTO.startTime}" /></td>
												<td><fmt:formatDate value="${auctionInfoDTO.endTime}" /></td>
												<td><fmt:formatNumber value="${auctionInfoDTO.auctionTotal}"/></td>
												<td>
													<c:if test="${now > auctionInfoDTO.endTime}">경매마감</c:if>
													<c:if test="${now < auctionInfoDTO.endTime}">경매중</c:if>
												</td>

											</tr>
										</c:if>
									</tbody>
								</table>
							</div>

						</div>
						<!-- DataTales Example -->
					</div>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">입찰 내역</h6>
						</div>
						
						<div class="card-body">
							<!-- 입찰 내역 리스트--------------- -->
							<div class="table-responsive mt-1">

								<table class="table table-bordered table-hover" id="dataTable"
									width="100%" cellspacing="0">
									<colgroup>
										<col />
										<col />
										<col />

									</colgroup>
									<thead>
										<tr>
											<th>번호</th>
											<th>아이디</th>
											<th>입찰가</th>
											<th>구분</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${not empty bidlist }">
											<c:forEach items="${bidlist }" var="record">
												<tr>
													<td>${record.rn }</td>
													<td>${record.memberId }</td>
													<td>${record.bidsPrice}</td>
													<td>
														<c:if test="${record.rn <= auctionInfoDTO.auctionTotal}">
															낙찰
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
								
								<div class="page_pageniation">
									<nav aria-label="Page navigation example">
										<script src='https://kit.fontawesome.com/a076d05399.js'></script>
										<!-- 페이지상단가기 버튼 -->
										<span onclick="location.href='#'"
											class="rounded-circle bg-light"
											style="cursor: pointer; float: right; position: fixed; top: 92%; left: 96%;"><i
											class='fas fa-chevron-circle-up'
											style='font-size: 24px; color: black; box-shadow: black;'></i></span>
										<!-- 페이지버튼 -->
										<ul class="pagination justify-content-center">${pagingBtn }</ul>
									</nav>
								</div>

							</div>
						</div>




						<!-- DataTales Example -->
					</div>

					<!-- /.container-fluid -->
				</div>

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
	


});


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
    if(typeof str == "undefined" || str == null || str == "")
        return true;
    else
        return false ;
}
</script>

</html>



































