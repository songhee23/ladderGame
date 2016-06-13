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
<title>사용자 관리</title>
<link rel="stylesheet" href="resources/list.css">

<!-- bower:js -->
<script src="../../resources/bower_components/jquery/dist/jquery.js"></script>
<script src="../../resources/bower_components/angular/angular.js"></script>
<!-- endbower -->

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.1.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	

	
	$("#check_all").click(function(){
	    var chk = $(this).is(":checked");//.attr('checked');
	    if(chk) $(".select_subject input").attr('checked', true);
	    else  $(".select_subject input").attr('checked', false);
	});
		
	 
	$("#count_check").click(function() {
		
		var count_chk = $("input[name=participantgroup]:checkbox:checked").length;
		
		
		if(count_chk>=2 && count_chk<=10 ) 
		{
			var form = document.getElementById("myform");
			form.action = "gameready.htm"
			form.submit();
		}
		else
		{
			alert("인원을 다시 선택해주세요!(2~10명선택)");
		}
		
	});
	
	
/* 	$("#namesort").click(function() {
		$('#myTable').each(function () {
            var $table = $(this);
            // 플러그인 호출                    
            $table.alternateRowColors();
            // start table sort 
            $('th', $table).each(function (column) {
                // 헤더의 CSS 클래스가 sort-alpha로 설정되어있다면, ABC순으로 정렬
                if ($(this).is('.sort-alpha')) {
                    // 클릭시 정렬 실행
                    var direction = -1; // 
                    $(this).click(function () {
                        direction = -direction; // 
                        var rows = $table.find('tbody > tr').get(); // 현재 선택된 헤더관련 행 가져오기
                        // 자바스크립트의 sort 함수를 사용해서 오름차순 정렬
                        rows.sort(function (a, b) {
                            var keyA = $(a).children('td').eq(column).text().toUpperCase();
                            var keyB = $(b).children('td').eq(column).text().toUpperCase();
 
                            if (keyA < keyB) return -direction; // 
                            if (keyA > keyB) return direction; // 
                            return 0;
                        });
                        // 정렬된 행을 테이블에 추가 
                        $.each(rows, function (index, row) { $table.children('tbody').append(row) });
                        $table.alternateRowColors(); // 재정렬
                    });
                }
            }); // end table sort                     
        }); // end each()                
	}); */


});



function deletego()
{
	var count_chk = $("input[name=participantgroup]:checkbox:checked").length;
	if(count_chk>=1 ) 
	{
		if(confirm("지난 게임 내역도 사라집니다!!! 정말 삭제하시겠습니까? ")==true)
		{
			//alert("삭제");
			var form = document.getElementById("myform");
			form.action = "delete.htm"
			form.submit();
		}
		else
		{
			return;
		}
	}
	else
	{
		alert("삭제할 유저를 선택해 주세요");
	}
}
 
//인원 추가 버튼 클릭시
function insert()
{
 	location.href ="insertform.htm";
}


// 이름 정렬
function NameSortDesc()
{
	var form = document.getElementById("myform");
	form.action = "namesort.htm"
	form.submit();

}

function NameSort()
{
	var form = document.getElementById("myform");
	form.action = "userlist.htm"
	form.submit();

}


</script>
</head>
<body>

<h2>사용자 관리</h2>

<hr/>
	<br>

	<div>
		<form action="" method="get" id="myform">
			<div>
				<select name="searchKey" class="selectField">
					<option value="user_name">이름</option>
					<option value="user_tel">전화번호</option>
					<option value="user_email">이메일</option>
				</select> <input type="text" id="searchValue" name="searchValue"
					class="textField" />
				<button type="submit" id="submitBtn">검 색</button>
				<input type="button" class="button1" value="사용자추가" onclick="insert()"/> 
				<input type="submit" class="button2" value="삭제"  onclick="deletego()"/><br/>
			
			</div>

			<div>
				<br/>
				
				<table >
					
					<tr>
						<th>번호</th>
						<th>이름<input type="submit" class="lineupbutton" value="▼" onclick="NameSortDesc()">
						        <input type="submit" class="lineupbutton" value="▲" onclick="NameSort()"></th>
						<th>전화번호</th>
						<th>이메일</th>
						<th>설명</th>
						<th><input type='checkbox' id='check_all' class='input_check' />전체선택</th>
					</tr>
				<tbody id="myTbody">	
				<c:forEach var="userlist" items="${list}">
					<tr class='select_subject'>
						<td><c:out value="${userlist.rownum}"/></td>
						<td><c:out value="${userlist.user_name}"/></td>
						<td><c:out value="${userlist.user_tel}"/></td>
						<td><c:out value="${userlist.user_email}"/></td>
						<td><c:out value="${userlist.user_des}"/></td>
						<td><input type="checkbox" id="myCheck" name="participantgroup" value="${userlist.user_id}"></td>
					</tr>
				</c:forEach>
				</tbody>
				</table>
				<br> <input type="button" class="button4" value="지난게임"
					        onclick="location.href='lastgamelist.htm'" />
			</div>
		</form>
<!-- 		<form action="delete.htm" method="get" id="delete">
				<input type="submit" class="button2" value="삭제"  onclick="deletego()"/><br/>
		</form> -->
	</div>
	<div>
		<br> <input type="submit" class="button3" value="사다리사기" id='count_check'/>
		<p class="notifyptag">※ 사용자는 2~10명까지 가능합니다.</p>

	</div>
	


</body>
</html>