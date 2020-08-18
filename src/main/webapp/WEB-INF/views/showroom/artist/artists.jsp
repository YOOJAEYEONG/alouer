<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--Spring Security에서 제공하는 security 관련 태그사용을 위한 선언  -->
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!--Spring Security에서 제공하는 form태그 사용을 위한 선언  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Featured Artists</title>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

<style>
#columns {
	column-width: 250px;
	column-gap: 30px;
}
#columns figure {
	display: inline-block;
	border: 1px solid rgba(0, 0, 0, 0.2);
	margin: 0;
	margin-bottom: 30px;
	padding: 0px;
}
#columns figure img {
	width: 100%;
	height: 300px;
	object-fit: cover;
}
#columns figure figcaption {
	border-top: 1px solid rgba(0, 0, 0, 0.2);
	padding: 10px;
	margin-top: 0px;
}
#artist{font-family:Noto Sans KR, sans-serif ;}
</style>
</head>
<body>
<section>
	<div class="container">
		<form class="form-inline" method="get">
       	
        		<select name="searchField" class="custom-select mr-sm-2" id="inlineFormCustomSelect" >
			        <option value="name">작가명</option>
			    </select>
      		

		    <input name="searchTxt" id="searchbar"  type="text" class="form-control border-0" placeholder="Type...">

			<button class="btn btn-outline-secondary border-0" onclick="submit();">
				<i class='fas fa-search' ></i>
			</button>
	
		</form>
	</div>
</section>


<section class="all_post section_padding">
	<div class="container">
		<div class="row">
			
			<div class="container p-4">
				<div class="row">
					<div id="columns">
					
						<c:forEach items="${artists }" var="dto">
							<a class="cardPath" href="artistview.do?memberId=${dto.memberId}" >
								<figure class="card">
                                    <c:if test="${ fn:contains(dto.imageUrl, 'https')}">
                                       <img src="${dto.imageUrl }">
                                    </c:if>
                                    <c:if test="${ fn:contains(dto.imageUrl, 'upload')}">
                                       <img src="${pageContext.request.contextPath }/${dto.imageUrl }">
                                     </c:if>
									<figcaption>
										<div>
										<sec:authorize access="hasRole('ADMIN')">
											<span>${dto.virtualNum}</span>
										</sec:authorize>	
											<h3 id="artist">${dto.name }</h3>
											
										</div>
									</figcaption>
								
								</figure>
							</a>
						</c:forEach>
					
					</div>
				</div>

				<div class="page_pageniation">
					<nav aria-label="Page navigation example">
						<!-- 페이징 처리 -->
						<ul class="pagination justify-content-center">${pagingImg }</ul>
					</nav>
				</div>
				
			</div> 
			
		</div>
	</div>
</section>


</body>

</html>
















