<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/list.css">
<!-- include: "type": "js", "files": "resources/util.js" -->
<script src="resources/util.js"></script>
<!-- /include -->


<script type="text/javascript">
		
function insertgo()
{
	var form = document.getElementById("insertform");
	
	str = form.user_name.value;
	str = str.trim();
	
	if (!str) 
	{
		alert("\n이름을 입력하세요");
		form.user_name.focus();
		return false;
	}
	
	str = form.user_tel.value;
	str = str.trim();
	
	if (!str) 
	{
		alert("\n전화번호을 입력하세요");
		form.user_tel.focus();
		return false;
	}
	/* 	else if (isValidPhone(str)) 
	{
		alert("\n올바른 전화번호 형식으로 입력! '예)XXX-XXXX-XXXX'");	
		form.name.focus();
		return;
	} */
	
	str = form.user_email.value;
	str = str.trim();
	
	if (!str) 
	{
		alert("\n이메일을 입력하세요");
		form.user_email.focus();
		return false;
	}
	/*	if (isValidEmail(str)) 
	{
		alert("\n올바른 이메일 형식으로 입력! '예)abcd@aksys.com'");	
		form.name.focus();
		return;
	} */
	
	//location.href="insert.htm";
	
	alert("입력하시겠습니까?");
	form.action = "insert.htm"; //아래 비어있는 액션속성을 채움! 
	f.submit();
	
};

		
		
		
		
</script>
</head>
<body>
<h2>사용자 추가</h2>

<hr/>
<form action="" method="post" id="insertform">

<table style="width:400px">
		<tr>
			<td>성명</td>
			<td><input type="text" name="user_name" id="user_name" placeholder="이름" /></td>
		</tr>
	    <tr>
			<td> 전화번호</td>
			<td><input type="text" name="user_tel" id="user_tel"  placeholder="예) XXX-XXXX-XXXX" /></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="user_email" id="user_email" placeholder="예) abcd@abcd.com" /></td>
		</tr>
		<tr>
			<td>설명</td>
			<td><input type="text" name="user_des" id="user_des"  placeholder="직위 및 별명"  /></td>
		</tr>
</table>
<br>
				 
 <input class="button3" type="submit" onclick="insertgo()"  style="margin-left: 150px;">
 
</form> 
</body>
</html>