<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.List"%>
<%@page import="DAO.DAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.DTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사다리 생성</title>
<link rel="stylesheet" href="resources/result&gameready.css">
<script type="text/javascript">


function laddergo()
{
	
	var form = document.getElementById("myform");
	var item = document.getElementsByName("user_item");	
	
	//alert("user_item");
	
	var user_item = new Array();
	for (var i = 0; i < item.length; i++) 
	{
		user_item[i] = item[i].value
		//alert("i : "+i+"item[i].value :"+item[i].value);
	}
	
	//console.log("로그");
	for (var j = 0; j < item.length; j++) 
	{
		if(user_item[j]=="")
		{
			
			alert("상품을 모두 입력해 주세요");
			form.action="redirect:gameready.htm";
			break;
		}
		else if(user_item[j].length>8)
		{
			//alert("user_item[j].length :"+user_item[j].length);
			alert("8글자 이하로 입력해주세요");
			form.action="redirect:gameready.htm";
			break;
		}
		else
		{
			form.action = "laddergo.htm"
			form.submit();
		}
		
	}
//	if(form.user_item.value=="")
//	{
		//form.action = "laddergo.htm"
		//form.submit();
/* 	}
 	else
	{
		alert("라인별 상품입력!");
		return false;
	}  
 
	*/

	
}
 
</script>
</head>
<body>

<h2>사다리 생성</h2>

<hr/>
<br>
<form action="" method="get" id="myform">
	<div>
		
			<div>
				
				수평바 수
				<select name="searchKey" class="selectField">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>										
				</select> 

				<input type="button" class="button2" value="사용자 재선택" 
					   onclick="location.href='userlist.htm'"/><br/>
			</div>

			<div><br/>
				<table>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>설명</th>
						<th>라인별 상품 입력</th>
					</tr>
					<c:forEach var="userlist" items="${list}">
					<tr>
						<td><c:out value="${userlist.rownum}"/></td>
						<td><c:out value="${userlist.user_name}"/></td>
						<td><c:out value="${userlist.user_des}"/></td>
						<td><input class="inputtext" type="text" name="user_item" value="${userlist.user_item}"></td>
					</tr>
					
					</c:forEach>
					
				</table><br>
			<%-- 	<p><c:out value="${}" default="" escapeXml="true"/></p> --%>
				
			</div>
		
	</div>
	<div><br>

		<input type="submit" class="button3" value="시작"
		       onclick="laddergo()" /> 
	</div>

	<div>
	<table style="visibility:hidden;">
	<c:forEach var="userlist" items="${list}">
		<tr>
			<td><input name="game_id" value="${userlist.game_id}"></td>
			<td><input name="user_id" value="${userlist.user_id}"/></td>
        </tr>
     </c:forEach>
	</table>		
	
	</div>
</form>

</body>
</html>