<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>사용자 관리</title>
</head>
  
<body>
<h1>
	Hello world!  
</h1>


${user.user_name}
${user.user_email}
${user.user_tel}


			<select name="searchKey" class="selectField">
				<option value="ename">제목</option>
				<option value="econtent">내용</option>
				<option value="estatus">진행상태</option>
			</select>
			
			<input type="text"  id="searchValue" name="searchValue" class="textField"/>
			<button type="submit" id="submitBtn" >검  색</button>


<P>The time on the server is ${serverTime}. </P>




</body>
</html>
