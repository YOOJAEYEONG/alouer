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
<title>${params.name}</title>
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
		<div align="center">
			<h2>artist: ${params.name}</h2>
		</div>
		<div>
			<h5>학력: </h5>
		</div>
	</div>
	
	
</section>


<section class="all_post section_padding">
	<div class="container">

	<ul class="nav nav-tabs" role="tablist">
	    <li class="nav-item">
	      <a class="nav-link active" data-toggle="tab" href="#artwork">작품</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" data-toggle="tab" href="#cv">이력</a>
		    </li>
	    <li class="nav-item">
	      <a class="nav-link" data-toggle="tab" href="#intro">소개글</a>
	    </li>
	</ul>
	
	
	<!-- Tab panes -->
	<div class="tab-content">
		<div id="artwork" class="container tab-pane active"><br>
	      <h3>artworks</h3>
	      artwork here
	    </div>
    
	    <div id="cv" class="container tab-pane fade"><br>
	      <h3>이력</h3>
	      exhibition etc
	    </div>
    
	    <div id="intro" class="container tab-pane fade"><br>
	      <h3>소개글</h3>
	      어쩌고 저쩌고
	    </div>
  </div>


		<div class="row">

			<div class="container p-4">
				<div class="row">
					<div id="columns">
					
						<c:forEach items="${artists }" var="dto">
							<a class="cardPath" href="/artistview.do?code=${dto.code}&nowPage=${param.nowPage}" >
								<figure class="card">
									<img src="${dto.imageUrl }">
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
				
			</div> 
			
		</div>
	</div>
</section>


</body>

</html>
















