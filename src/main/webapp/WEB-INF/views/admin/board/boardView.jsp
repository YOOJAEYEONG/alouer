<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Dashboard</title>


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
							<h6 class="m-0 font-weight-bold text-primary">게시판 관리</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-hover col-lg-10">
									<colgroup>
										<col width="100px" />
										<col width="120px" />
										<col width="100px" />
										<col width="*%" />
									</colgroup>

									<tr>
										<th style="text-align: left; padding-left: 30px;">Posted</th>
										<td style="text-align: left; padding-left: 30px;">${list.postdate }</td>

										<th style="text-align: left; padding-left: 30px;">Views</th>
										<td style="text-align: left; padding-left: 30px;">${list.hits }</td>
									</tr>
									<tr>
										<th style="text-align: left; padding-left: 30px;">Title</th>
										<td colspan="3" style="text-align: left; padding-left: 30px;">
											${list.title }</td>
									</tr>
									

									<tr>
										<th style="text-align: left; padding-left: 30px;">Contents</th>
										<td colspan="3" style="text-align: left; padding-left: 30px;">
											${list.contents }</td>
									</tr>
									
									
									<c:if test="${list.reply != null }">
		                             <tr>
		                            	 <th style="text-align: left; padding-left: 30px;">Reply Date</th>
	                    	        	<td style="text-align: left; padding-left: 30px;">${list.replydate }</td>	
		                             </tr>
		                             <tr>
		                             	<th style="text-align: left; padding-left: 30px;">Reply</th>
		                    	        <td colspan="3" style="text-align: left; padding-left: 30px;">
		                    	        	${list.reply }</td>
		                    	        <td><input type="hidden" name="replyOX" id="replyOX" value="${list.replyOX }"/></td>
		                    	        
		                             </tr>
									</c:if>
									
									
									
									
									
									<tr>
										<td colspan="4" style="text-align: right;">
									<c:if test="${list.replyOX eq 1}">
									<button class="btn btn-outline-secondary"
												onclick="location.href='boardEdit.do?idx=${params.idx}&bname=${params.bname}&memberId=${list.memberId }';">
												답변 수정하기</button> &nbsp;
									 </c:if>
									<c:if test="${list.replyOX eq 0}">
									<button class="btn btn-outline-secondary"
												onclick="location.href='boardEdit.do?idx=${params.idx}&bname=${params.bname}';">
												답변하기</button> &nbsp;
									 </c:if>
											<button class="btn btn-outline-secondary"
												onclick="location.href='delete.do?idx=${params.idx}&bname=${params.bname}';">
												지우기</button> &nbsp; 
										</td>

									</tr>

								</table>


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
