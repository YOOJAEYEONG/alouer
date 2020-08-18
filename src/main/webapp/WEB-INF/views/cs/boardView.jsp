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
    <title></title>

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
	        
			</div><!-- end of class="row" -->
        
        	<!-- end of search bars, login, logout, write buttons -->
			<br /><br />
        	<div class="row">
        	<c:if test="${params.bname eq 'notice'}">
        		<div class="col-lg-12" align="center" style="font-size: 35px;">공지사항</div>
       		</c:if>

        	</div>
        	<br /><br />
            <div class="row">
                <div class="col-lg-10" style="margin-right: auto; margin-left: auto;">

                    
				<form:form method="get">
				  
					<table class="table table-hover" >
						<colgroup>
							<col width="10%" />
							<col width="60%"/>
							<col width="*%" />
							<col width="10%"/>
						</colgroup>
						
						<tr>
							<th style="text-align: left; padding-left: 30px;">Posted</th>
							<td style="text-align: left; padding-left: 30px;">${list.postdate }</td>			
						
							<th style="text-align: right;">Views</th>
							<td style="text-align: left; padding-left: 30px;">${list.hits }</td>						
						</tr>
						<tr>
							<th style="text-align: left; padding-left: 30px;">Title</th>
							<td colspan="3" style="text-align: left; padding-left: 30px; padding-right: 30px">
								${list.title }
							</td>
						</tr>
						
						<tr>
							<td></td>
							<td colspan="3" style="text-align: left; padding-left: 30px;">
								${list.contents }
							</td>
						</tr>
						<tr>
							<td colspan="4" style="text-align: right;">
								<a class="btn btn-outline-secondary" 
								href="board.do?bname=${params.bname}&nowPage=${nowPage}&searchField=${params.searchField}&searchTxt=${params.searchTxt}">
									리스트보기
								</a>
							</td>
							
						</tr>		
					</table>

				</form:form>  	                    

					
                </div><!-- end of < div class="col-lg-12" > -->
                
            </div><!-- end of outer < row > -->
        
        </div><!-- end of container -->
    </section>
    <!-- feature_post end-->
	
	<br /><br />
  
    <!-- social_connect_part part end-->

    <!-- footer part start-->

</body>

</html>