<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>작품관리</title>

<script>
function deleteRow(code, imageUrl) {
   if(confirm("정말로 삭제하시겠습니까?")) {
      location.href="${pageContext.request.contextPath}/admin/arts/deleteAction.do?code="+ code+"&imageUrl="+ imageUrl;
   }
}
</script>

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



<!-- <<<<<<< HEAD -->
               <!-- DataTales Example -->
               <div class="card shadow mb-4">
                  <div class="card-header py-3">
                     <h6 class="m-0 font-weight-bold text-primary">작품 관리</h6>
                  </div>
                  <div class="card-body">
                     <div class="table-responsive">
                     
                                          
                        <!-- 작품 신규 등록 버튼 -->
                        <form class="form-inline float-right" name="searchFrm" method="get">
                           <button type="button" class="btn btn-primary" 
                                 onclick="window.location.href='${pageContext.request.contextPath}/admin/arts/register';">
                                 신규 등록
                           </button>
                        </form>
                        
                        <!-- 검색부분 -->
                        <form class="form-inline ml-auto" name="searchFrm" method="get">
                           <div class="form-group">
                              <!-- Select Box -->
                              <select name="searchField" class="form-control">
                                 <option value="">전체</option>
                                 <option value="name">작가명</option>
                                 <option value="title">작품명</option>
                                 <option value="code">작품코드</option>
                              </select>&nbsp;
                              <!-- 검색어 입력부분 -->
                              <div class="input-group">
                                 <input type="text" name="searchTxt" id="searchfrm" placeholder="검색어를 입력하세요"
                                    class="form-control">
                                 <div class="input-group-append">
                                    <button type="submit" class="btn btn-primary" type="button" href="#">
                                       <i class="fas fa-search fa-sm"></i>
                                    </button>
                                 </div>
                              </div>
                           </div>
                        </form>
                                       
                        
                        
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <colgroup>
                           <col width="60px">
                           <col width="100px">
                           <col width="150px">
                           <col width="*">
                           <col width="200px">
                           <col width="100px">
                           <col width="80px">
                           <col width="85px">
                        </colgroup>
                           <thead>
                              <tr>
                                 <th>번호</th>
                                 <th>썸네일</th>
                                 <th>작품코드</th>
                                 <th>작품제목</th>
                                 <th>작가명</th>
                                 <th>현재상태</th>
                                 <th>수정</th>
                                 <th>삭제</th>
                              </tr>
                           </thead>
                           <tbody>
                           
                           
                           <!-- 작품목록 반복 부분 -->
                           <c:forEach items="${artlist }" var="artlist">      
                              
                             <c:choose>
                             	<c:when test="${artlist.status eq '준비중'}">
                             	<tr style="background-color: #efffee">
                             	</c:when>
                             	<c:otherwise>
	                            <tr>                             	
                             	</c:otherwise>
                             </c:choose>
                              
                                 <td width="60px">${artlist.virtualNum }</td>
                                 <td width="100px">
                                 
                                 <c:choose>
                                    <c:when test="${ fn:contains(artlist.imageUrl, 'https')}">
                                       <a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">
                                          <img src="${artlist.imageUrl }" style="width: 80px; height: auto;" />
                                       </a>
                                    </c:when>
                                    <c:otherwise>
                                       <a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">
                                          <img src="${pageContext.request.contextPath }/${artlist.imageUrl }" style="width: 80px; height: auto;" />
                                       </a>
                                    </c:otherwise>
                                 
                                 </c:choose>
                                 </td>
                                 <td><a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">${artlist.code }</a></td>
                                 <td><a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">${artlist.title }</a></td>
                                 <td>${artlist.name }</td>
                                 <td>${artlist.status }</td>
                                 <td width="85px">
                                    <button type="button" class="btn btn-primary" 
                                    onclick="window.location.href='${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }';">
                                    수정
                                 </button>
                                 </td>
                                 <td width="85px">
                                    <button type="button" class="btn btn-primary" 
                                    onclick="javascript:deleteRow('${artlist.code }', '${artlist.imageUrl }');">
                                    삭제
                                 </button>
                                 </td>
                              </tr>
                           </c:forEach>
                                 
                           
                           
                           
                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
               
               <!-- Pagination -->
               <div class="d-flex justify-content-center">
                  <ul class="pagination">
                     ${pagingStr }
                  </ul>
               </div>
<%-- =======
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">작품 관리</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
							
														
								<!-- 작품 신규 등록 버튼 -->
								<form class="form-inline float-right" name="searchFrm" method="get">
									<button type="button" class="btn btn-primary" 
											onclick="window.location.href='${pageContext.request.contextPath}/admin/arts/register';">
											신규 등록
									</button>
								</form>
								
								<!-- 검색부분 -->
								<form class="form-inline ml-auto" name="searchFrm" method="get">
									<div class="form-group">
										<!-- Select Box -->
										<select name="searchField" class="form-control">
											<option value="">전체</option>
											<option value="name">작가명</option>
											<option value="title">작품명</option>
											<option value="code">작품코드</option>
										</select>&nbsp;
										<!-- 검색어 입력부분 -->
										<div class="input-group">
											<input type="text" name="searchTxt" id="searchfrm" placeholder="검색어를 입력하세요"
												class="form-control">
											<div class="input-group-append">
												<button type="submit" class="btn btn-primary" type="button" href="#">
													<i class="fas fa-search fa-sm"></i>
												</button>
											</div>
										</div>
									</div>
								</form>
													
								
								
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
								<colgroup>
									<col width="60px">
									<col width="100px">
									<col width="150px">
									<col width="*">
									<col width="200px">
									<col width="100px">
									<col width="80px">
									<col width="85px">
								</colgroup>
									<thead>
										<tr>
											<th>번호</th>
											<th>썸네일</th>
											<th>작품코드</th>
											<th>작품제목</th>
											<th>작가명</th>
											<th>현재상태</th>
											<th>수정</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody>
									
									
									<!-- 작품목록 반복 부분 -->

									<c:forEach items="${artlist }" var="artlist">      
									   <tr>
									      <td width="60px">${artlist.virtualNum }</td>
									      <td width="100px">
									      
									      <c:choose>
									         <c:when test="${ fn:contains(artlist.imageUrl, 'https')}">
									      		<a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">
									            	<img src="${artlist.imageUrl }" style="width: 80px; height: auto;" />
									         	</a>
									         </c:when>
									         <c:otherwise>
									         	<a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">
									         		<img src="${pageContext.request.contextPath }/${artlist.imageUrl }" style="width: 80px; height: auto;" />
									         	</a>
									         </c:otherwise>
								         
									      </c:choose>
									      </td>
									      <td><a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">${artlist.code }</a></td>
									      <td><a href="${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }">${artlist.title }</a></td>
									      <td>${artlist.name }</td>
									      <td>${artlist.status }</td>
									      <td width="85px">
									      	<button type="button" class="btn btn-primary" 
												onclick="window.location.href='${pageContext.request.contextPath}/admin/arts/modify?code=${artlist.code }';">
												수정
											</button>
									      </td>
									      <td width="85px">
		                                    <button type="button" class="btn btn-primary" 
		                                    onclick="javascript:deleteRow('${artlist.code }', '${artlist.imageUrl }');">
		                                    삭제
		                                 </button>
									   </tr>
									</c:forEach>
		                           
									
									
									
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<!-- Pagination -->
					<div class="d-flex justify-content-center">
						<ul class="pagination">
							${pagingStr }
						</ul>
					</div>
>>>>>>> refs/remotes/origin/psi --%>



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