<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
			<div class="main_footer">	
			<tiles:insertAttribute name="header"/>
            <!-- 메인container-->
           	   </div>
             <div class="main_footer">	
           	<tiles:insertAttribute name="body"/>
            <!-- // container -->
              </div>
            
            
       
       	 <div class="main_footer">
            <tiles:insertAttribute name="footer" />
        	</div>
  


</html>