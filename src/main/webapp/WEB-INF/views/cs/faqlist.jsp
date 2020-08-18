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


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<style>
#searchbar {width: 90px;}
#inlineFormCustomSelect{outline-color: white;}

#category{text-align: center; }

#title{width: 90%; text-align: center;}

#accordion{ outline-color: white;
			border: none; background-color: white;}

#edit{font-size: 6px;}

#delete{font-size: 6px;}			
			
.card-header{background-color: white; vertical-align: middle;}

</style>

<script>
$('#accordion').collapse({
	  toggle: true
	})
</script>

</head>

<body>
    <!--::header part start::-->
   
    <!-- Header part end-->

    <!-- breadcrumb start-->
    
    
    <!-- breadcrumb start-->

    <!-- feature_post start-->
    <br />
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
        		<div class="col-md-12" align="center" style="font-size: 35px; padding-bottom: 20px;">FAQs</div>
        	</div>
        	<br />
        	
            <div class="row" style="vertical-align: middle;">
            
                <div class="col-lg-10" style="margin-right: auto; margin-left: auto;">
                    <div style="padding-left: 30px;"><!-- start of center-text -->
                    <!-- 게시물이 없다면 아무것도 안 나온다.-->
                    	<c:choose>
                    		<c:when test="${empty lists }">
                    			No Posts		
                    		</c:when>
                    		
                    		<c:otherwise>
                    			<c:forEach items="${lists }" var="row" varStatus="loop">
                    				
                    					<div id="accordion" class="col-lg-12">	
											<div class="card">
										    	<div class="card-header" style="text-align: left;">
										        	<a class="card-link" data-toggle="collapse" href="#${row.virtualNum }">
										          	${row.title}
										        	</a>
												</div>
												
										      	<div id="${row.virtualNum }" class="collapse"  data-parent="#accordion">
											        <div class="card-body">
										          		${row.contents }
											      	</div>
											    </div>
										  	</div>
										</div>
									
                    			</c:forEach>
                    		</c:otherwise>
                    	</c:choose>	
 
                    </div><!-- end of class="col-lg-12 -->
                    	<br />
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
	                    
                </div><!-- end of < div class="col-lg-12" > -->
                
            </div><!-- end of outer < row > -->
        
        </div><!-- end of container -->
    </section>
    <!-- feature_post end-->


    <!-- social_connect_part part end-->

    <!-- footer part start-->

</body>

</html>