<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- auction>list -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>지분경매</title>
    <!-- css, CDN -->
   
    <link rel="stylesheet" href=" ${pageContext.request.contextPath }/resources/css/ListFilter2.css" type="text/css" />
	<link rel="stylesheet" href=" ${pageContext.request.contextPath }/resources/css/ListFilter1.css" type="text/css" /> 
	<link rel="stylesheet" href=" ${pageContext.request.contextPath }/resources/css/ListFilter.css" type="text/css" /> 
   
</head>

<style>
#bg { 
    background-color: rgb(0 37 62 / 25%); /*살짝 투명한 검정으로 배경색*/ 
	width:100%; 
	height:100%; 
	position: absolute; /*다른 요소들 위로 겹쳐질 수 있게함*/ 
	
}
.card h1 { 
	position: relative; 
	z-index:1000; /*맨 앞으로 나오도록 함*/ 
	text-align: center;
    top: 0;
    background-color: rgba(0, 37, 62, .9);
    padding: 5px 0;
    font-size: 20px;
    line-height: 2em;
}
.statusPlag {
    padding: 4px !important;
}

</style>


<script>
//매개변수로 전달된 시간이 현재보다 이전이면 true를 반환
function isBefore(endTime){
	let now = new Date();
	let time = new Date(endTime);
	//Mon Jul 27 2020 18:23:01 GMT+0900 (대한민국 표준시)
	console.log("===============");
	console.log("now",now);
	console.log("endTime:",time);
	console.log("now.getTime()    :"+now.getTime());
	console.log("endTime.getTime():"+time.getTime());
	console.log("===============");
	if(now.getTime() > time.getTime()){
		console.log("과거");
		return true;
	}else{
		console.log("미래");
		return false;
	}
}
</script>
<body>
    <!--::navi part start::-->
   
    <!-- navi part end-->



    <!-- feature_post start-->
	<section class="all_post section_padding">
		<div class="container">
			<div class="row">


				<div class="container p-4">
					<div class="row">
						<div id="columns">
							<c:set var="now" value="<%= new java.util.Date() %>" />
							<c:forEach items="${artlists }" var="dto" varStatus="status">
								<c:forEach items="${auctionInfo }" var="auDTO">
									<c:if test="${auDTO.code eq dto.code }">
										<c:set var="code" value="${auDTO.code }"/>
										<c:set var="fmtEndTime" value="${auDTO.fmtEndTime }"/>
									</c:if>
								</c:forEach>
								<a class="cardPath" href="/view.do?code=${dto.code}&nowPage=${param.nowPage}" >	
									<figure class="card">
									<c:if test="${dto.status eq '경매준비중'}">
										<div id="bg">
											<h1 style="color: white;">경매예정 작품입니다</h1>
										</div>							
									</c:if>
										<img src="${dto.imageUrl }">
										<figcaption class="statusPlag" ></figcaption>
										<figcaption>
											
											<h2 id="title">${dto.title }</h2>
											<p>
												크기: <span id="sizeho">${dto.width }x${dto.height }cm
													(${dto.sizeHo }호)</span>
											</p>
											<p id="material">소재:${dto.material }</p>
											<p>작가:${dto.name }</p>
											<p id="artvalue">추정가치:${dto.artValueFormat }</p>
											<p>코드:${dto.code }</p>
										
											<c:forEach var="auctionDTO" items="${auctionInfoList}" varStatus="status">
												<c:if test="${dto.code eq auctionDTO.code }">
													<fmt:formatDate value="${auctionDTO.startTime }" var="startTime" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
													<fmt:formatDate value="${auctionDTO.endTime }" var="endTime" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
													<c:choose>
														<c:when test="${auctionDTO.endTime lt now}">
															<p class="text-center"><b>입찰 마감되었습니다.</b></p>													
														</c:when>
														<c:when test="${auctionDTO.endTime gt now}">
															<div hidden="">
																<p>now:${now }</p>
																<p>endTime:${auctionDTO.endTime }</p>
																<p>startTime:${auctionDTO.startTime }</p>															
															</div>
															<p id="startBids">현재입찰가:${auctionDTO.minPrice }</p>	
															<p id="endTime">종료시간:<fmt:formatDate value="${auctionDTO.endTime}" type="both" dateStyle="short" timeStyle="short"/></p>		
															<div class="progress" style="height: 0.6em; color: red; background-color: black;">
																<div id="${'progress'+=status.count }" class="progress-bar progress-bar-striped progress-bar-animated" ></div>																	
															</div>
															<script>
																var now = new Date(); 
																var startTime = new Date("${startTime }")
																var endTime = new Date("${endTime }")
																console.log("now:",now.getTime(),"endTime:",endTime.getTime(),"startTime",startTime.getTime());
																
																startTime = startTime.getTime();
																endTime = endTime.getTime();
																now = now.getTime();
																console.log("계산:", ( (now-startTime)/(endTime-startTime) )*100   );
																var remain = ((now-startTime)/(endTime-startTime))*100 ;
																//(now-start)/(end-start)*100
																$("${'#progress'+=status.count}").css("width",remain+"%");
															</script>
														</c:when>
													</c:choose>
												</c:if>
											</c:forEach> 
											<div class="discoverCard-tagBox">
												<div class="discoverCard-tag"></div>
												<span class="DTOstatus">${dto.status }</span>
											</div>
										</figcaption>
									</figure>
								</a>
								
							</c:forEach>
						</div>

					</div>

					<div class="page_pageniation">
						<nav aria-label="Page navigation example">
							<!-- 페이지버튼 -->
							<ul class="pagination justify-content-center">${pagingBtn }</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
    <!-- feature_post end-->


    <!-- footer part start-->

</body>


</html>