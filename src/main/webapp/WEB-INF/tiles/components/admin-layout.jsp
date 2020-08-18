<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>

	<tiles:insertAttribute name="head" />
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<tiles:insertAttribute name="sidebar" />
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<tiles:insertAttribute name="navi" />

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<tiles:insertAttribute name="content" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>