<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Write</title>

<style>
#searchbar {width: 90px;}
#inlineFormCustomSelect{outline-color: white;}
</style>


<script>
//제목과 내용 작성했는지 확인
function checkForm(f) {
	if(f.title.value==""){
		alert("Write in the title, ye lazy cow!!!");
		f.title.focus();
		return false;
	}
	if(f.content.value==""){
		alert("Write in the content, ya donkey!!!");
		f.content.focus();
		return false;
	}
}
</script>
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

        	<div class="row">
        		<div class="col-lg-12" align="center" style="font-size: 35px;">Inquiry</div>
        	</div>
        	<br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="row" align="center">
                   	<form action="inquiryReply.do" method="post">   
						<table class="table table-hover" id="centerTable" style="width: 800px">
							<colgroup>
								<col width="20%" />
								<col colspan="3" />
							</colgroup>
							<!-- 작성일 -->
							<tr>
								<th style="text-align: center;">Posted</th>
								<td>${view.postdate }</td>			
							</tr>
							<!-- 조회수. 없어도 되나? -->
							<tr>
								<th style="text-align: center;">Views</th>
								<td>${view.hits }</td>						
							</tr>
							<!-- 작성자의 아이디(이멜) -->
							<tr>
								<th style="text-align: center;">Posted By</th>
								<td>${view.memberId }</td>
							</tr>
							<!-- 제목 -->
							<tr>
								<th style="text-align: center;">Title</th>
								<td colspan="3">
									${view.title }
								</td>
							</tr>
							<!-- 내용 -->
							<tr>
								<td colspan="4" style="text-align: left; margin: 100px;">
									${view.contents }
								</td>
							</tr>		
							
						</table>	                    
                    
                    </div><!-- end of inner row -->
                    <br /><br />
                    
						<div class="row">
						<!-- 수정, 삭제, 답변보내기 버튼.답변은 관리자만 가능! -->
							<c:if test="${empty sessionScope.siteUserInfo}">
								<button type="button" 
									onclick="location.href='inquirymodify.do?idx=${row.idx}';">
									Edit</button>
									
								<button type="button" onclick="javascript:deleteRow(${row.idx});">
									Delete</button>
									
								<button type="button" 
									onclick="location.href='./inquiry.do?nowPage=${param.nowPage}';">리스트보기</button>
							</c:if>
							
							<sec:authorize access="hasRole('ADMIN')">
								
									<button type="button" onclick="location.href='/admin/cs/inquiryReply.do';">
									답변전송
									</button>
									
							</sec:authorize>
													
						</div>
	                </form><!-- end of form -->     
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