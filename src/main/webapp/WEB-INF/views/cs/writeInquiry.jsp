<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                    <div class="row justify-content-center">
                        
                    <form action=<c:url value="/cs/writeAction.do"/>  name="theform"
                    				onsubmit="return checkForm(this);" method="post" >
                    				
	                   	<table class="table table-hover">
						<colgroup>
							<col width="100px"/>
							<col width="500px"/>
						</colgroup>
						<tbody>
							<tr>
								<th class="text-center" style="vertical-align:middle;">Title</th>
								<td>
									<input type="text" class="form-control" name="title"/>
								</td>
							</tr>
							<tr>
								<th class="text-center" style="vertical-align:middle;">Content</th>
								<td>
									<textarea rows="10" class="form-control" name="contents"></textarea>
								</td>
							</tr>
						</tbody>
						</table>
						
						<!-- submit, return botton -->
			            <div class="row">
							<div class="col text-right">
				            	<button type="button" class="btn btn-outline-secondary"
				            	onclick="location.href='inquiry.do';">Back</button>	
				            	&nbsp;
				            	<button type="reset" class="btn btn-outline-secondary">Reset</button>
				            	&nbsp;
				            	<button type="submit" class="btn btn-outline-secondary"
				            	onsubmit="checkForm(this);">Submit</button>
				            	&nbsp;&nbsp;&nbsp;
			            	</div>            
			            </div>
			            <!-- submit, return botton -->
						
                    </form>
                    
                    </div><!-- end of inner row -->
	                    
                </div><!-- end of < div class="col-lg-12" > -->
                
            </div><!-- end of outer < row > -->
        
        </div><!-- end of container -->
    </section>
    <!-- feature_post end-->

    <!-- social_connect_part part start-->

    <!-- social_connect_part part end-->

    <!-- footer part start-->

</body>

</html>