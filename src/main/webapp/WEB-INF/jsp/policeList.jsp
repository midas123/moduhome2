<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<title>first</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
</head>
<body>
<h1 class="page-header">신고된 스토리목록</h1>
<div class="row">
	<div class="panel panel-default">
		<div class="panel-heading">
                         신고된 스토리를 관리하는 페이지입니다.
        </div>
        
        <div class="panel-body">
			<div class="dataTable_wrapper">
				<div id="dataTables-example_wrapper"
					class="dataTables_wrapper form-inline dt-bootstrap no-footer">
					<div class="row" style="margin-bottom:5px;">
						<div class="col-sm-6">
							<a href="/ModuHome/policeList"><button type="button" class="btn btn-outline btn-default">전체</button></a>													
						</div>
						
						<%-- <div class="col-sm-6" style="text-align:right;">
							<div class="dataTables_info" id="dataTables-example_info" role="status" aria-live="polite">총 게시글 수 : ${totalCount}</div>
						</div> --%>
						
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table
								class="table table-striped table-bordered table-hover dataTable no-footer"
								id="dataTables-example" role="grid"
								aria-describedby="dataTables-example_info">
								<thead>
								<tr role="row">
										<th style="width: 7%; text-align: center;">선택</th>
										<th style="width: 7%; text-align: center;">번호</th>
										<th style="width: 7%; text-align: center;">신고자</th>
										<th style="width: 15%; text-align: center;">해당게시물</th>
										<th style="width: 35%; text-align: center;">신고내용</th>										
										<th style="width: 8%; text-align: center;">등록일자</th>
										
									</tr>
								</thead>
								<tbody>
        <c:choose>
            <c:when test="${fn:length(list) > 0}">
                <c:forEach items="${list}" var="row">
                    <tr>
                        <td><input type="checkbox" name="police_seq" value="${row.POLICE_SEQ}" /></td>
                        <td>${row.POLICE_SEQ }</td>
                        <td>${row.MEMBER_NUMBER }</td>     
                        <c:choose>
                       <c:when test="${row.POLICE_HIDE eq 1}">
                      <td>${row.SNS_NUMBER } [숨겨진 게시물]</td>
                      </c:when>
                      <c:otherwise>
                       <td>${row.SNS_NUMBER }</td>
                       </c:otherwise>
                        </c:choose>                        
                        
                        <td>${row.POLICE_CONTENT }</td>
                        <td>${row.POLICE_REGDATE }</td>
                        
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4">조회된 결과가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
         
    </tbody>
<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAll();" />전체선택
<!-- <button type="submit" name="check" id="th_check" onclick="deleteAction();" ><span class="btn btn-outline btn-default">삭제</span></button>
<button type="submit" name="hide" id="th_hide" onclick="hideAction();" ><span class="btn btn-outline btn-default">sns숨기기</span></button>
<button type="submit" name="hide_cancle" id="th_hidecancle" onclick="hide_cancleAction();" ><span class="btn btn-outline btn-default">sns숨기기취소</span></button> -->
<!-- <input type="button" name="check" id="th_check" onclick="deleteAction();" > -->

<%-- <table style="border:1px solid #ccc">
    <colgroup>
        <col width="10%"/>
        <col width="*"/>
        <col width="15%"/>
        <col width="20%"/>
    </colgroup>

    <thead>
        <tr>
            <th scope="col">선택</th>
            <th scope="col">번호</th>
            <th scope="col">신고자</th>
            <th scope="col">해당게시물</th>
            <th scope="col">신고내용</th>
            <th scope="col">등록일</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${fn:length(list) > 0}">
                <c:forEach items="${list}" var="row">
                    <tr>
                        <td><input type="checkbox" name="police_seq" value="${row.POLICE_SEQ}" /></td>
                        <td>${row.POLICE_SEQ }</td>
                        <td>${row.MEMBER_NUMBER }</td>     
                        <c:choose>
                       <c:when test="${row.POLICE_HIDE eq 1}">
                      <td>[숨겨진 스토리]${row.SNS_NUMBER }</td>
                      </c:when>
                      <c:otherwise>
                       <td>${row.SNS_NUMBER }</td>
                       </c:otherwise>
                        </c:choose>                        
                        <td>${row.SNS_NUMBER }</td>
                        <td>${row.POLICE_CONTENT }</td>
                        <td>${row.POLICE_REGDATE }</td>
                        <td></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4">조회된 결과가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
         
    </tbody>
</table> --%>
</table>
</div></div></div></div>
<button type="submit" name="check" id="th_check" onclick="deleteAction();" ><span class="btn btn-outline btn-default">삭제</span></button>
<button type="submit" name="hide" id="th_hide" onclick="hideAction();" ><span class="btn btn-outline btn-default">sns숨기기</span></button>
<button type="submit" name="hide_cancle" id="th_hidecancle" onclick="hide_cancleAction();" ><span class="btn btn-outline btn-default">sns숨기기취소</span></button>
</body>
<script>
function checkAll(){
    if( $("#th_checkAll").is(':checked') ){
      $("input[name=police_seq]").prop("checked", true);
    }else{
      $("input[name=police_seq]").prop("checked", false);
    }
}

function deleteAction(){
	  var checkRow = "";
	  $( "input[name='police_seq']:checked" ).each (function (){
	    checkRow = checkRow + $(this).val()+"," ;
	  });
	  checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기

	   $.ajax({
	        url:'./policedelete',
	        type:'POST',
	        data: ({check:"check", checkNum : checkRow}),
	        success:function(data){ /* 데이터를 받아오지 않으면 자바스크립터에서만 오류가 난다.. */
	            alert("삭제완료");
	            location.reload(); //새로고침
	            
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            alert('에러 발생~~ \n' + textStatus + ' : ' + errorThrown);
	        }
	    });
	  
	  
	}
	/* sns 숨기기 */
function hideAction(){
	  var checkRow = "";
	  $( "input[name='police_seq']:checked" ).each (function (){
	    checkRow = checkRow + $(this).val()+"," ;
	  });
	  checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기

	   $.ajax({
	        url:'./policeHide',
	        type:'POST',
	        data: ({check:"check", checkNum : checkRow}),
	        success:function(data){ /* 데이터를 받아오지 않으면 자바스크립터에서만 오류가 난다.. */
	            alert("숨기기 완료");
	            location.reload(); //새로고침
	            
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            alert('에러 발생~~ \n' + textStatus + ' : ' + errorThrown);
	        }
	    });
	  
	  
	}
	
	/* 숨기기취소 */
function hide_cancleAction(){
	  var checkRow = "";
	  $( "input[name='police_seq']:checked" ).each (function (){
	    checkRow = checkRow + $(this).val()+"," ;
	  });
	  checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기

	   $.ajax({
	        url:'./policeHideCancle',
	        type:'POST',
	        data: ({check:"check", checkNum : checkRow}),
	        success:function(data){ /* 데이터를 받아오지 않으면 자바스크립터에서만 오류가 난다.. */
	            alert("숨기기취소 완료");
	            location.reload(); //새로고침
	            
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            alert('에러 발생~~ \n' + textStatus + ' : ' + errorThrown);
	        }
	    });
	  
	  
	}




</script>
</html>

