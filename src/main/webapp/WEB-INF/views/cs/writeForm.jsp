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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<style>
#searchbar {width: 90px;}
#inlineFormCustomSelect{outline-color: white;}

</style>


<script>
//제목과 내용 작성했는지 확인
function checkForm(f) {
	if(f.title.value==""){
		alert("Write in the title!!!");
		f.title.focus();
		return false;
	}
	else if(f.contents.value==""){
		alert("Write in the content!!!");
		f.contents.focus();
		return false;
	}
	else {
		return true;
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
        	
        	<br />
            <div class="col-lg-10" style="margin-left: auto; margin-right: auto;">
                <!-- <div> -->

                        
	                    <form name="theform" method="post" action="writeAction.do"  onsubmit="return checkForm(this);">
	                    
	           				<input type="hidden" name="bname" value="${params.bname }" />
	           				<%-- <input type="hid den" name="memberId" value="${params.memberId }" /> --%>
	                    				
		                   	<table class="table table-hover" style="margin-left: auto; margin-right: auto;">
								<colgroup>
									<col width="15%"/>
									<col width="85%"/>
								</colgroup>

								<tr>
									<th class="text-center" style="vertical-align:middle;">Title</th>
									<td>
										<input type="text" class="form-control" name="title" value="${lists.title}"/>
									</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align:middle;">Author</th>
									<td>
										<input type="text" class="form-control" name="memberId" value="${params.memberId}"/>
									</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align:middle;">Contents</th>
									<td class="text-left">
										<textarea rows="10" class="form-control" name="contents" value="${lists.contents}">
										
										</textarea>
									</td>
								</tr>
								
								<tr>
									<td colspan="2" class="text-right" style="text-align: right; padding-top: 20px;">
									<button type="button" class="btn btn-outline-secondary"
					            	onclick="location.href='board.do?bname=${params.bname}';">Back</button>&nbsp;	
					            	
					            	<button type="reset" class="btn btn-outline-secondary">Reset</button>&nbsp;
					            	
					            	<button type="submit" class="btn btn-outline-secondary"
					            	onsubmit="checkForm(this);">Submit</button>		
									</td>
								</tr>
							
							</table>
							
                    	</form>
                    

	                    
                <!-- </div> --><!-- end of < div class="col-lg-12" > -->
                
            </div><!-- end of outer < row > -->
        
        </div><!-- end of container -->
    </section>
    <!-- feature_post end-->

  
    <!-- social_connect_part part end-->

    <!-- footer part start-->

</body>

</html>