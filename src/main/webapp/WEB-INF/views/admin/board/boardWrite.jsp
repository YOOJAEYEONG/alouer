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
							<h6 class="m-0 font-weight-bold text-primary">글쓰기</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
							<form:form action="boardWriteAction.do" method="post">
								<input type="hidden" name="bname" value="${bname }"/>
								<table class="table mr-auto" style="width:70%;">

									
									<tr>
										<td  style="text-align: left; padding-left: 30px;">
											title <input style="width:100%;" name="title" type="text" />
											
											</td>
									</tr>

									<tr>										
										<td  style="text-align: left; padding-left: 30px;">
											<textarea name="contents" id="" style="width:100%;" rows="20"></textarea>
											</td>
									</tr>
									<tr>
										<td  style="text-align: right;">
											<%-- <c:if test="${sessionScope.siteUserInfo.memberId eq row.memberId}"> --%>
											<button type="submit" class="btn btn-outline-secondary">
												글쓰기</button> &nbsp;
 
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
