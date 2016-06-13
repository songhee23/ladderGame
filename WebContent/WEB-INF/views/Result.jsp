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
<title>게임 결과</title>
<link rel="stylesheet" href="resources/result&gameready.css">
</head>
<body>

<h2>결과</h2>

<hr/>
<br>

	<div>
		<form>
		
			<div>
			<%=request.getAttribute("date") %>
				
			</div>

			<div><br/>
				<table>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>설명</th>
						<th>상품 결과</th>
					</tr>
				<c:forEach var="userlist" items="${list}">
					<tr>
						<td><c:out value="${userlist.rownum}"/></td>
						<td><c:out value="${userlist.user_name}"/></td>
						<td><c:out value="${userlist.user_des}"/></td>
						<td><c:out value="${userlist.user_item}"/></td>
					</tr>
				</c:forEach>
				</table><br>
			</div>
		</form>
	</div>
	<div><br>

		<input type="button" class="button3" value="확인" 
			   onclick="location.href='lastgamelist.htm'"/> 
			   
		

	</div>

</body>
</html>