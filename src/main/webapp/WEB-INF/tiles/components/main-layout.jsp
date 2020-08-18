<%@ page pageEncoding="utf-8" session="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<html>
    <head>
        <tiles:insertAttribute name="head" />
    </head>
    <body>
      <tiles:insertAttribute name="navi" />
      
		<section>
       		<tiles:insertAttribute name="carousel" />
		</section>
		
        <div class="container">
       		<tiles:insertAttribute name="content" />
        </div>
        
       <tiles:insertAttribute name="footer" />
    </body>
</html>