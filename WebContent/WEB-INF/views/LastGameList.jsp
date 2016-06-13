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
<title>지난게임</title>
<script type="text/javascript">	
	 function Article(game_id) 
	{ 
	       var form = document.getElementById("Articlego");
	       form.action = "result.htm"
	       form.game_id.value = game_id;
	       form.submit();

	} 
	 

</script>
<link rel="stylesheet" href="resources/list.css">
</head>

<body>

<h2>지난게임</h2>

<hr/>
<br>

	<div>
		<form action="" method="get" id="myform">
		    <div>
	    	<select name="searchKey" class="selectField">
					<option value="user_name">이름</option>
				</select> 
				
				<input type="text" id="searchValue" name="searchValue" class="textField" />
				<button type="submit" id="submitBtn">검 색</button>
				<input type="button" class="button1" value="게임하러가기" 
					   onclick="location.href='userlist.htm'" /> 
			</div>
			<div><br/>
				<table>
					<tr>
						<th>No.</th>
						<th>날짜</th>
					</tr>
					<c:forEach var="userlist" items="${list}">
					<tr>
						<td><c:out value="${userlist.game_id}"/></td>
						<td><a href="javascript:Article('${userlist.game_id}')">${userlist.game_date}</a>
					</tr>
					</c:forEach>
				</table><br>

			</div>
		</form>
	</div>
<div>
	<form id="Articlego" action="result.htm" method="get">
   		<p><input type="hidden" name="game_id"/></p>
   	</form>
</div>

</body>
</html>