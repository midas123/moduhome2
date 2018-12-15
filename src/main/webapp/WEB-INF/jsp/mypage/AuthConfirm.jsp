<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<title>정보수정</title>
</head>

<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	var check = $(".check").attr("id"); 
	if(check == "1"){
		 location.href = "/ModuHome/memModify";
	  
	}else{
		alert("비밀번호를 확인해주세요.");
		location.href = "/ModuHome/MemberAuthForm";
	}
	
	
});
</script>
<body>
<div style="display:none;" class="check" id="${check}" ></div>
</body>
</html>