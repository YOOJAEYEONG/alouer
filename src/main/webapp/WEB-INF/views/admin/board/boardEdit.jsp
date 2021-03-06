<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>관리자 게시글 수정</title>


</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">



		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">


				<!-- Begin Page Content -->
				<div class="container-fluid">


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">글 수정하기</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
							<form:form action="boardEditAction.do" method="post">
								<input type="hidden" name="bname" value="${params.bname }"/>


						<!-- 작성자의 아이디(이메일) -->
                        <input type="hidden" name="to" size="70" value="${list.memberId }">
                        
                        <!-- 관리자의 아이디(이메일) -->
                        <input type="hidden" name="from" size="70" value="jjeong1992@naver.com" class="form-control">



								<table class="table mr-auto" style="width:70%;">
									<tr>
									
									
									</tr>
									<td>
									<input type="text" name="idx" value="${list.idx }" readonly/>
									
									</td>
									<td>
									<input type="text" name="postdate" value="${list.postdate }" readonly/>
									
									</td>
									
									<tr>
										<td colspan="2" style="text-align: left; padding-left: 30px;">
											title 
											<input style="width:100%;" name="title" type="text" value="${list.title} "/>
											
											</td>
									</tr>

									<tr>										
										<td colspan="2" style="text-align: left; padding-left: 30px;">
											contents
											<textarea name="contents" id="" style="width:100%;" rows="10">${list.contents }</textarea>
										</td>
									</tr>
									<tr>
									<c:if test="${list.replyOX eq 0}">
									 	<td colspan="2" style="text-align: left; padding-left: 30px;">
											<textarea name="reply" id="reply" style="width:100%;" rows="10">${list.reply }</textarea>
										</td>
									 </c:if>
									 </tr>
									 	
									<tr>
										<td style="text-align: right;">
											
									<c:if test="${list.replyOX eq 1}">
									<button type="submit" class="btn btn-outline-secondary">
												수정 완료</button> &nbsp;
									 </c:if>
									<c:if test="${list.replyOX eq 0}">
									<button type="submit" class="btn btn-outline-secondary">
												답변 완료</button> &nbsp;
									 </c:if>
											
 
										</td>

									</tr>

								</table>
						</form:form>

							</div>
						</div>
					</div>

					<!-- Pagination -->
					<div class="d-flex justify-content-center">
						<ul class="pagination">${pagingStr }
						</ul>
					</div>



				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->



		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->


</body>

</html>
