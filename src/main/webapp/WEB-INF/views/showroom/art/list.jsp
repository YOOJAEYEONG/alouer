<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--Spring Security에서 제공하는 security 관련 태그사용을 위한 선언  -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- JSTL의 국제화 라이브러리를 사용하기 위한 지시어 선언 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>전체 작품보기</title>
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

<body>
	<section class="all_post section_padding">
		<div class="container">
			<div class="row">


				<div class="container p-4">
					<div class="row">
						<div id="columns">
							<c:set var="now" value="<%= new java.util.Date() %>" />
							<c:forEach items="${artlists }" var="dto">
								<c:choose>						
									<c:when test="${dto.status eq '지분경매'}">
										<a class="cardPath" href="../../../auction/view.do?code=${dto.code}&nowPage=${param.nowPage}" >
									</c:when>
									<c:when test="${dto.status eq '지분거래'}">
										<a class="cardPath" href="../../../stock/view.do?code=${dto.code}&nowPage=${param.nowPage}" >
									</c:when>								
									<c:otherwise>
										<a class="cardPath" href="/view.do?code=${dto.code}&nowPage=${param.nowPage}" >
									</c:otherwise>
								</c:choose>
								
																
									<figure class="card">
									<c:if test="${dto.status eq '경매준비중'}">
										<div id="bg">
											<h1 style="color: white;">경매예정 작품입니다</h1>
										</div>							
									</c:if>
									<c:if test="${dto.status eq '렌탈준비중'}">
										<div id="bg">
											<h1 style="color: white;">렌탈준비중 작품입니다</h1>
										</div>							
									</c:if>
										<img src="${dto.imageUrl }">
										<figcaption class="statusPlag" ></figcaption>
										<figcaption>
											<div>
												<h2 id="title">${dto.title }</h2>
												<p id="artist">작가명:${dto.name }</p>
												<p>
													크기: <span id="sizeho">${dto.width }x${dto.height }cm
														(${dto.sizeHo }호)</span>
												</p>
												<p id="material">소재:${dto.material }</p>
												<p>작가:${dto.name }</p>
												<p id="artvalue">추정가치:${dto.artValueFormat }</p>
												<c:if test="${dto.status eq '렌탈가능' }">
													<p id="rentalPrice">렌탈가:${dto.rentalPriceFormat }</p>												
												</c:if>
												<c:if test="${dto.status eq '지분경매' }">
													<c:forEach var="auctionDTO" items="${auctionInfoList}" varStatus="status">
														<c:if test="${dto.code eq auctionDTO.code }">
														
															<fmt:formatDate value="${auctionDTO.startTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" var="startTime"/>
															<fmt:formatDate value="${auctionDTO.endTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" var="endTime"/>
															<c:if test="${auctionDTO.endTime lt now}">
																<p class="text-center"><b>입찰 마감되었습니다.</b></p>
															</c:if>
															<c:if test="${auctionDTO.endTime gt now}">
																<p id="startBids">현재입찰가:${auctionDTO.minPrice }</p>	
																<p id="endTime">남은시간:<fmt:formatDate value="${auctionDTO.endTime}" type="both" dateStyle="short" timeStyle="short"/></p>		
																<div class="progress" style="height: 0.6em; color: red; background-color: black;">
																	<div id="${'progress'+=status.count }" class="progress-bar progress-bar-striped progress-bar-animated" >
																	</div>																	
																</div>
																	
																<script>
																	var now = new Date(); 
																	var startTime = new Date("${startTime }")
																	var endTime = new Date("${endTime }")
																	console.log("now:",now.getTime(),"endTime:",endTime.getTime(),"startTime",startTime.getTime());
																	
																	startTime = startTime.getTime();
																	endTime = endTime.getTime();
																	now = now.getTime();
																	console.log("계산:", ((now-startTime)/(endTime-startTime))*100   );
																	var remain = ((now-startTime)/(endTime-startTime))*100 ;
																	//(now-start)/(end-start)*100
																	$("${'#progress'+=status.count}").css("width",remain+"%");
																</script>
															</c:if>																																					
																										
															
															
														</c:if>
													</c:forEach> 
												</c:if>
														
												<div hidden="" >													
													<p id="theme">테마:${dto.theme }</p>
													<p id="color">컬러:${dto.color }</p>													
												</div>
												
											</div>
											<div class="discoverCard-tagBox">
												<div class="discoverCard-tag"></div>
												<span class="status">${dto.status }</span>
											</div>
										</figcaption>
									</figure>
								</a>
							</c:forEach>
						
							<c:if test="${empty artlists}">
								<div class="mt-4 mb-5 text-center">
									<h2 class="mt-4 mb-4 text-center">모든조건에 만족하는 작품이 없습니다.</h2>
								</div>
							</c:if>
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


</body>

</html>
















