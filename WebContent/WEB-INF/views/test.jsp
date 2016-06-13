<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<p>test 1 : ${test1} </p>
	<p>test 2 : ${test2} </p>
	
	<form action="/test" method="post">
		<input type="text" name="data"/>
		<input type="submit"/>
	</form>

</body>
</html>