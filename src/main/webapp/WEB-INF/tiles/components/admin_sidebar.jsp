<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    
    
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

  <!-- Sidebar - Brand -->
  <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath }/admin">
    <div class="sidebar-brand-icon rotate-n-15">
      <i class="fas fa-laugh-wink"></i>
    </div>
    <div class="sidebar-brand-text mx-3">ALouer Admin</div>
  </a>

  <!-- Divider -->
  <hr class="sidebar-divider my-0">



  <!-- Divider -->
  <hr class="sidebar-divider">

  <!-- Heading -->
  <div class="sidebar-heading">
    관리자 모드
  </div>

  <!-- Nav Item - Pages Collapse Menu -->
  <li class="nav-item">
    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
      <i class="fas fa-fw fa-cog"></i>
      <span>게시판관리</span>
    </a>
    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <h6 class="collapse-header">게시판:</h6>
        
        <a class="collapse-item" href="${pageContext.request.contextPath }/admin/board?bname=notice">공지사항</a>
        <a class="collapse-item" href="${pageContext.request.contextPath }/admin/board?bname=faq">FAQ</a>
        <a class="collapse-item" href="${pageContext.request.contextPath }/admin/board?bname=inquiry">1:1문의</a>
      </div>
    </div>
  </li>
  <li class="nav-item">
    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
      <i class="fas fa-fw fa-cog"></i>
      <span>작품거래</span>
    </a>
    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <h6 class="collapse-header">작품거래:</h6>
        <a class="collapse-item" href="${pageContext.request.contextPath }/admin/arts">작품관리</a>
        <a class="collapse-item" href="${pageContext.request.contextPath }/admin/rental">렌탈관리</a>
        <a class="collapse-item" href="${pageContext.request.contextPath }/admin/auction">지분경매</a>
      </div>
    </div>
  </li>

  <!-- Divider -->
  <hr class="sidebar-divider">




</ul>
<!-- End of Sidebar -->