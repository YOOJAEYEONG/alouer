<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ include file="/resources/css/buttonCSS.css" %> --%>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FAQ Page</title>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"><!-- 화살표 그림 -->
<style>
#searchbar {width: 90px;}
#inlineFormCustomSelect{outline-color: white;}
</style>
</head>

<body>
    <!--::header part start::-->
   
    <!-- Header part end-->

    <!-- breadcrumb start-->
    
    <!-- breadcrumb start-->

    <!-- feature_post start-->
    <section class="all_post section_padding">
        <div class="container">
        	
	        <div class="row">
	        <!-- 검색창 -->
		        <div class="form-group col-md-7">
		        	<form class="form-inline" action="/action_page.php">
		        		<!-- <button class="btn btn-outline-secondary" type="submit">Search</button>
		        		<input class="form-control mr-sm-2" type="text" placeholder="Search.." id="searchbar"> -->
		        		<select class="custom-select mr-sm-2" id="inlineFormCustomSelect">
					        <option selected>content</option>
					        <option value="1">author</option>
					    </select>
		        		<div class="input-group">
						    <input id="searchbar" type="text" class="form-control border-0" placeholder="Type...">
							<!--검색아이콘버튼  -->
							<button class="btn btn-outline-secondary border-0" onclick="submit();">
							<i class='fas fa-search'></i>
							</button>
						</div>&nbsp;
			        	
					</form>
				</div>
				<!-- 검색창 -->
				<div class="col-md-5 text-right">
					<c:choose>
					  	<c:when test="${not empty sessionScope.siteUserInfo }">
					  		<button class="btn btn-outline-secondary" 
					  		onclick="location.href='logout.do'">Logout</button>
					  		&nbsp;&nbsp;
					  		<button class="btn btn-outline-secondary" 
					  		onclick="location.href='write.do'">Write</button>
					  	</c:when>
					  	<c:otherwise>
					  		
					  	</c:otherwise>
				     </c:choose>
       			</div>
			</div><!-- end of class="row" -->
        
        	<!-- login, logout, write buttons -->

        	<div class="row">
        		<div class="col-lg-12" align="center" style="font-size: 35px;">1 : 1 문의</div>
        	</div>
        	<br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <table class="table table-hover">
						  <thead align="center" style="padding-top:15px">
						    <tr>
						      <th width="10%">No</th>
						      <th width="*">Title</th>
						      <th width="20%">Posted</th>
						      <th width="10%">Views</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:choose>
						  	<c:when test="${empty lists }">
							  	<tr>
									<td colspan="6" class="text-center">
										No Posts were uploaded
									</td>
								</tr>
						  	</c:when>
						  	<c:otherwise>
						  		<c:forEach items="${lists }" var="row" varStatus="loop">
						  			<!-- 리스트 반복 시작 -->
							  		<tr>
								      <td class="text-center"><b>${row.virtualNum }</b></td>
								      <td class="text-center">
								      	<a href="./inquiryview.do?idx=${row.idx}&nowPage=${nowPage}">${row.title}</a>
								      </td>
								      <td class="text-center">${row.postdate }</td>
								      <td class="text-center">${row.hits }</td>
								    </tr>
								    <!-- 리스트 반복 끝 -->
							    </c:forEach>
						  	</c:otherwise>
						  </c:choose>
						  </tbody>
						</table>
						
							                        
                    </div><!-- end of inner row -->
	                    
	                    <!-- pagination -->
	                    <div class="page_pageniation">
							<nav aria-label="Page navigation example">
								<!-- 페이지버튼 -->
								<ul class="pagination justify-content-center">${pagingImg }</ul>
							</nav>
						</div>
						
                </div><!-- end of < div class="col-lg-12" > -->
                
            </div><!-- end of outer < row > -->
        
        </div><!-- end of container -->
    </section>
    <!-- feature_post end-->

    <!-- social_connect_part part start-->
    <section class="social_connect_part">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-12">
                    <div class="social_connect">
                    <div class="single-social_connect">
                        <div class="social_connect_img">
                            <img src="${pageContext.request.contextPath}/img/insta/instagram_1.png" class="" alt="blog">
                            <div class="social_connect_overlay">
                                <a href="#"><span class="ti-instagram"></span></a> 
                            </div>
                        </div>
                    </div>
                    <div class="single-social_connect">
                        <div class="social_connect_img">
                            <img src="${pageContext.request.contextPath}/img/insta/instagram_2.png" class="" alt="blog">
                            <div class="social_connect_overlay">
                                <a href="#"><span class="ti-instagram"></span></a> 
                            </div>
                        </div>
                    </div>
                    <div class="single-social_connect">
                        <div class="social_connect_img">
                            <img src="${pageContext.request.contextPath}/img/insta/instagram_3.png" class="" alt="blog">
                            <div class="social_connect_overlay">
                                <a href="#"><span class="ti-instagram"></span></a> 
                            </div>
                        </div>
                    </div>
                    <div class="single-social_connect">
                        <div class="social_connect_img">
                            <img src="${pageContext.request.contextPath}/img/insta/instagram_4.png" class="" alt="blog">
                            <div class="social_connect_overlay">
                                <a href="#"><span class="ti-instagram"></span></a> 
                            </div>
                        </div>
                    </div>
                    <div class="single-social_connect">
                        <div class="social_connect_img">
                            <img src="${pageContext.request.contextPath}/img/insta/instagram_5.png" class="" alt="blog">
                            <div class="social_connect_overlay">
                                <a href="#"><span class="ti-instagram"></span></a> 
                            </div>
                        </div>
                    </div>
                    <div class="single-social_connect">
                        <div class="social_connect_img">
                            <img src="${pageContext.request.contextPath}/img/insta/instagram_6.png" class="" alt="blog">
                            <div class="social_connect_overlay">
                                <a href="#"><span class="ti-instagram"></span></a> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </section>
    <!-- social_connect_part part end-->

    <!-- footer part start-->

</body>

</html>