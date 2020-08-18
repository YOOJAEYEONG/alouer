<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %><!-- 시큐리티 코어 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FAQ Page</title>
    
<script src='https://kit.fontawesome.com/a076d05399.js'></script><!-- 돋보기 아이콘 cdn -->



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
		        	<form class="form-inline" method="get">
		        	
		        		<select class="custom-select mr-sm-2" id="inlineFormCustomSelect" name="searchField">
		        			<option value="title">title</option>
					        <option value="contents">contents</option>
					        
					    </select>
		        		
		        		<div class="input-group">
						    <input id="searchbar" name="searchTxt" type="text" 
						    class="form-control border-0" placeholder="Type...">
						    <!--검색아이콘버튼  -->
							<button class="btn btn-outline-secondary border-0" onclick="submit();">
								<i class='fas fa-search'></i>
							</button>
						</div>&nbsp;
			        	
					</form>
				</div>
				<!-- 여러가지 버튼 -->
				<!-- 관리자만: 쓰기 수정 삭제(지금은 그냥 버튼이 보고 싶어서 이렇게) -->
				<!--일반인은 쓰기,수정,삭제 안 보이기 -->
				<div class="col-md-5 text-right">
					<c:choose>
					  	<c:when test="${not empty sessionScope.siteUserInfo }">
					  		<button class="btn btn-outline-secondary" 
					  		onclick="location.href='writeFAQ.do';">Write</button>
					  	</c:when>
					  	<c:otherwise>
					  	</c:otherwise>
				     </c:choose>
       			</div>
			</div><!-- end of class="row" -->       


        	<div class="row">
        		<div class="col-lg-12" align="center" style="font-size: 35px;">FAQs</div>
        	</div>
        	<br /><br />
            <div class="row">
            
                <div class="col-lg-12 text-center">
                   <!--  <div class="row"> -->
                    <form:form action="" method="get" align="center">
                   
                        <table class="table table-hover">
                        
						  <thead align="center" style="padding-top:15px">
						    <tr>
						      <th width="8%">No</th>
						      <th width="*">Title</th>
						      <th width="10%">Posted</th>
						      <th width="8%">Views</th>
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
						  			
					  		<!-- 리스트 반복 시작 -->							   						
							    <!-- 관리자일 결우 게시물 옆에 '수정', '삭제' 버튼이 보인다-->
						      	<%-- <c:if test="${empty sessionScope.siteUserInfo}"> --%>
						      		<c:forEach items="${lists }" var="row" varStatus="loop">
						      		
						      		
					      			<tr>
								      <td class="text-center"><b>${row.virtualNum }</b></td>
								      
								      <td class="text-center" width="60%">
								      
								      	<a href="faqview.do?idx=${row.idx}&nowPage=${nowPage}">${row.title}</a>
								      	
								      		<sec:authorize access="hasRole('ADMIN')">
								      	 	<button class="btn btn-outline-secondary" onclick="location.href='faqmodify.do?idx=${row.idx}';">
								      			Edit
								      		</button >
								      		
								      		<button class="btn btn-outline-secondary" onclick="location.href='deleteFAQ.do?=idx${row.idx}';">
								      			Delete
								      		</button>
								      		</sec:authorize>
								      </td>
								      <td class="text-center">${row.postdate }</td>
								      <td class="text-center">${row.hits }</td>
								    </tr>
						      		
						      		
						      		
							  		
								    <!-- 리스트 반복 끝 -->
							    	</c:forEach>						      	
					      			
						      	<%-- </c:if> --%>
						  	</c:otherwise>
						  </c:choose>
						  </tbody>
						</table>
				     </form:form>                   
                    <!-- </div> --><!-- end of inner row -->
                    
	                    <!-- pagination -->
	                    <div class="page_pageniation">
							<nav aria-label="Page navigation example">
								<!-- 페이지버튼 -->
								<ul class="pagination justify-content-center">${pagingImg }</ul>
							</nav>
						</div>
	                    <!-- pagination -->

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
                            <img src="${pageContext.request.contextPath}/img/insta/gypsy_girl.jpg" class="" alt="blog">
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