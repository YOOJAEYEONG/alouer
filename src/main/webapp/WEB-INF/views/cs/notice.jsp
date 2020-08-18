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
    <title>Notice</title>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
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
    <br /><br />
    <section class="all_post section_padding">
        <div class="container">
        	
	        <div class="row col-lg-12">
	        
	        <!-- 검색창 -->
        	<form class="form-inline" method="get">
	        	
       			<input type="hidden" name="bname" value="${params.bname }" />
       	
	        		<select name="searchField" class="custom-select mr-sm-2" id="inlineFormCustomSelect" >
				        <option value="title">title</option>
				        <option value="contents">contents</option>
				    </select>
       		

			    <input name="searchTxt" id="searchbar"  type="text" class="form-control border-0" placeholder="Type...">

				<button class="btn btn-outline-secondary border-0" onclick="submit();">
					<i class='fas fa-search' ></i>
				</button>

			</form>
				
			</div><!-- end of class="row" -->
			
			<div class="row">
       			<div class="col-md-12" align="center" style="font-size: 35px;">공지사항</div>
			</div>
        	<br /><br />
			
        
            <div class="row">
            
                <div class="col-md-12 text-center">
                    <!-- <div class="row"> -->
                    <form:form action="" method="get" align="center">
                        <table class="table table-hover">
 
						  
						  <thead align="center" style="padding-top:15px">
						    <tr>
						      <th width="8%">No</th>
						      <th width="*" style="padding-left: 30px;">Title</th>
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
								      
								      <td class="text-left" width="60%" style="padding-left: 30px;">
								      
								      	<a href="boardView.do?bname=${params.bname}&idx=${row.idx}&nowPage=${nowPage}&searchField=${params.searchField}&searchTxt=${params.searchTxt}">${row.title}</a>

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
				     
				     <!-- pagination -->
	                    <div class="page_pageniation" style="font-size: 20px; font-family: Lora, serif; padding-top: 20px; padding-bottom: 10px;">
							<nav aria-label="Page navigation example">
								<!-- 페이지처리. 검색어 유무에 따라 다르다 -->
								<c:choose>
									<c:when test="${empty params.searchTxt}">
										<ul class="pagination justify-content-center">${pagingImg2 }</ul>
									</c:when>
									<c:otherwise>
										<ul class="pagination justify-content-center">${pagingImg }</ul>
									</c:otherwise>
								</c:choose>
								
							</nav>
						</div>
	                    <!-- pagination --> 	
							                        
                    </div><!-- end of < div class="col-lg-12" > -->
	                    
                </div>
                
            </div><!-- end of outer < row > -->
        
        </div><!-- end of container -->
    </section>
    <br />
    <!-- feature_post end-->


    <!-- social_connect_part part end-->

    <!-- footer part start-->

</body>

</html>