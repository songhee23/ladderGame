  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.List"%>
<%@page import="DAO.DAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.DTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/list.css">
<!-- <script type="text/javascript" src="resources.ladderOperate.js"></script> -->
<script type="text/javascript">
function resultgo()
{
	
	var form = document.getElementById("myform");
	form.action = "result.htm";
	form.submit();	
}
 

function Point_t()
{
	var x;
	var y;
}

function PointDirection_t()
{
	var x;
	var y;
	var direction;//true: 오른쪽, false: 왼쪽
}

function PointTo_t()
{
	var startX;
	var startY;
	var endX;
	var endY;
}

// Data Structure 결과 좌표
function Result_t()
{
	var playerName;
	var playerPrize;
	var playerResult;
	var bgcolor;
	var drawPointList;  //유저의 라인 순서를 가지고 있는 변수(Point_t객체 사용) 
	var drawPointCount;
}



// 계속 사용하는 변수들은 전역으로 선언해 놓을 것! 
var PointList;
var ResultList;

var HLineGap;

var userName = []; 
var userItem = []; 


var playerOfNum =-1;
var HbarOfNum = -1;
var gTotalHBar = 0;

var CANVAS_WIDTH = 840;
var CANVAS_HEIGHT = 610;
var CANVAS_LABEL_WIDTH = 40;
var CANVAS_LABEL_HEIGHT = 20;
var CANVAS_LADDER_HMARGIN =80;
var CANVAS_LADDER_VMARGIN =5;
var CANVAS_LADDER_START_X = CANVAS_LADDER_HMARGIN;
var CANVAS_LADDER_START_Y = CANVAS_LABEL_HEIGHT+CANVAS_LADDER_VMARGIN;
var CANVAS_LADDER_WIDTH = CANVAS_WIDTH-(CANVAS_LADDER_HMARGIN*2);
var CANVAS_LADDER_HEIGHT = CANVAS_HEIGHT-((CANVAS_LABEL_HEIGHT+CANVAS_LADDER_VMARGIN)*2);

var gcontext = null;

var gDrawPointIndex = -1;
var gDrawPlayerIndex = -1;
var gDTimer = null;




//(인스턴스생성)
window.onload=function()
{
	
	 playerOfNum = parseInt(document.getElementById("join_num").value);
	 
	  HbarOfNum = parseInt(document.getElementById("nodes").value);
	  
	  
	  
	 Initialize();  // 초기화
	// alert("Initialize");
	 GeneratePointMap();
	// alert("GeneratePointMap");
	 ClimbLadder();
	// alert("ClimbLadder");
	 DrawLadder();
	// alert("DrawLadder");
	 
	 //ClimbLadderOnPerson(1);
	 //DrawLadderOnPerson(1);
	


};

// 메모리를 할당한 포인트 자료구조(FFFFFFFF로) 초기화 & 결과 자료구조 초기화
function Initialize()
{
	
	 var i=0; 
	 var j=0;
	
	 var user_name = document.getElementsByName("user_name");
	 var userItem = document.getElementsByName("user_item");
	 
	gTotalHBar = HbarOfNum+2;
	
	// 포인트 자료구조 초기화
	PointList = new Array(playerOfNum);
	
	for( i=0; i<playerOfNum; i++)
	{
		PointList[i] = new Array(gTotalHBar);
		for( j=0; j<gTotalHBar; j++)
		{
			PointList[i][j] = new PointTo_t();
			PointList[i][j].startX = -1;
			PointList[i][j].startY = -1;
			PointList[i][j].endX = -1;
			PointList[i][j].endY = -1;			
		}
	}
	
 	// 결과 자료구조 초기화 
	ResultList = new Array(playerOfNum);
	
	for( i=0; i<playerOfNum; i++)
	{
		
		ResultList[i] = new Result_t();
		ResultList[i].playerName = user_name[i].value;
		ResultList[i].playerPrize = userItem[i].value;
		ResultList[i].playerResult = -1;
/* 		switch(i)
		{
		case 0:
			ResultList[i].bgcolor = "#FF0000";
			break;
		case 1:
			ResultList[i].bgcolor = "#00FF00";
			break;
		case 2:
			ResultList[i].bgcolor = "#0000FF";
			break;	
		} */
		ResultList[i].bgcolor = MakeRandomColor();
		ResultList[i].drawPointList = new Array(100);
	    ResultList[i].drawPointCount = 0;
	} 
	
	HLineGap = CANVAS_LADDER_WIDTH/(playerOfNum-1);
	
	var canvas = document.getElementById("canvas");
	gcontext = canvas.getContext("2d");
	
}


//자료구조에 값을 할당(중복체크)
function GeneratePointMap()
{	
	//테스트용 배열 생성 
	//var test=[353,406,336];
	
	//alert("[GeneratePointMap] Enter...");
	
	var offsetX = CANVAS_LADDER_START_X; // offset에X열 시작점을 넣다
	var offsetY = CANVAS_LADDER_START_Y; //offset에 Y열 시작점을 넣는다
	
	for(var x=0; x<playerOfNum; x++){
		for(var y=0; y<gTotalHBar; y++){  
			
			//alert("[GeneratePointMap] Processing : ("+x+","+y+")");
			
			PointList[x][y].startX = offsetX;  // 
			PointList[x][y].endX = PointList[x][y].startX+HLineGap;
			
			if(y===0)//수직선의 시작점
			{
				PointList[x][y].startY = CANVAS_LADDER_START_Y;	
				PointList[x][y].endY = PointList[x][y].startY+CANVAS_LADDER_HEIGHT;
			}
			else if(y===gTotalHBar-1) //수직선의 종료점
			{
				PointList[x][y].startY = CANVAS_LADDER_START_Y+CANVAS_LADDER_HEIGHT;
				
			}
			else//나머지 랜덤
			{
				if(playerOfNum-1==x)
				{
					PointList[x][y].startY = PointList[x-1][y].endY;
					PointList[x][y].endY = -1;					
				}
				else
				{
					PointList[x][y].startY =MakeRandomY(x);
					PointList[x][y].endY = PointList[x][y].startY;
				}
											
			}
			
		}
		offsetX += HLineGap;
		
	}
	
	//alert("[GeneratePointMap] Leave...");
	
	return PointList;
}






//Y좌표의 랜덤 값을 만드는 함수 
function MakeRandomY(curVLine)
{
	var random_y;
	
	do {
		
		random_y = MakeRandomValue(CANVAS_LADDER_START_Y, CANVAS_LADDER_START_Y+CANVAS_LADDER_HEIGHT);
		
	} while (CheckDuplicationForY(curVLine, random_y)===true);
	// true인 동안 do{} 실행
	// false라면 do{} 실행 중지 -> 중복되지 않는 랜덤값 생성 완료  
	
	return random_y;
}

//수평선의 점(Y값)의 중복을 검사 후 값을 할당
function CheckDuplicationForY(curVLIndex, targetHY)
{
	var x = curVLIndex;
	var y;
	
	
	//2. 현재 수직선의 Y좌표에 대해서 중복검사.
	for(y=0; y<gTotalHBar; y++)
	{
		if(PointList[x][y] == targetHY)
			return true;
	}

	//1. 현재 수직선 이전선의 Y좌표에 대해서 중복검사
	if(x === 0)
		return false;
	
	for(y=0; y<gTotalHBar; y++)
	{
		if(PointList[x-1][y] == targetHY)
			return true;
	}
	
	return false; 
}


//랜덤 값을 만드는 함수 
function MakeRandomValue(min, max)
{
	var random;
	var choices= max - min + 1;

	random=Math.floor(Math.random()*choices+min);
	
	return random;
}



//유저이름과 상품이 저장된 자료구조 
function ClimbLadder()
{
	for (var i = 0; i <playerOfNum; i++) {
		
		ClimbLadderOnPerson(i);
	}
}



function ClimbLadderOnPerson(playeridx)
{

	var index=0;
	var curidx = playeridx;
	//alert("ClimbLadderOnPerson-2");
	var direction = true; //수직 1, 수평 0
	var vpt = new Point_t();
	var hpt = new PointDirection_t();
	//alert("ClimbLadderOnPerson-3");
	vpt.y = 0;

	 	
	for(;;)
    {
	
		ResultList[playeridx].drawPointList[index] = new Point_t();
		if(index == 0)
		{
			ResultList[playeridx].drawPointList[index].x = PointList[playeridx][0].startX;
			ResultList[playeridx].drawPointList[index].y = PointList[playeridx][0].startY;
			ResultList[playeridx].drawPointCount++;
			index++;
			continue;
							 
		}
		 
		if(direction==1) //수직일때
		{ 
			vpt = FindNextPoint_V(curidx, vpt.y);

			ResultList[playeridx].drawPointList[index].x = vpt.x;
			ResultList[playeridx].drawPointList[index].y = vpt.y;
			
		}
		else //수평일때 
		{ 			
			hpt = FindNextPoint_H(curidx, vpt.y);
			if(hpt === null)
			{
				return curidx;	
			}
/* 			alert("hpt.x : "+hpt.x
			     +"hpt.y : "+hpt.y
			     +"curidx  :  "+curidx
				 +"direction :"+direction);  */
			ResultList[playeridx].drawPointList[index].x = hpt.x;
			ResultList[playeridx].drawPointList[index].y = hpt.y;
			if(hpt.direction === false)
				curidx -= 1;
			else curidx += 1;	
			
			
			//alert("ClimbLadderOnPerson-5");
			
		}
		ResultList[playeridx].drawPointCount++;

				
		if(ResultList[playeridx].drawPointList[index].y >= (CANVAS_LADDER_START_Y+CANVAS_LADDER_HEIGHT))
		{	
			//alert("ClimbLadderOnPerson-리턴 2: "+curidx);
			if(curidx==(playerOfNum-1))
			{
	 
	 			for(var i=0; i<ResultList[playeridx].drawPointList[index].length; i++)
	 			{
	 				
					 console.log("[COORDX]["+playeridx+"]" + "[" +index+"]" + 
							 ResultList[playeridx].drawPointList[index].x + "," 
							 + ResultList[playeridx].drawPointList[index].y);
	 			}
	 
			}	
			//alert(" playeridx : "+ playeridx + ",    result index  : "+curidx);
			ResultList[playeridx].playerResult = curidx;
			return curidx;
		}
				
		if(direction===true)
			direction = false;
		else direction = true;
		index++;
		
		//alert("ClimbLadderOnPerson-6");
	} 
	 
	alert("ClimbLadderOnPerson : 에러발생 :"+"direction :"+direction+" playeridx :"+playeridx+" index : "+index+"curidx : "+curidx);
	
	return -1;
	
}


//현재 라인을 받아서 다음 Y 포인트를 찾는 메소드 
function FindNextPoint_V(curLine, curY)
{
	var oldgap = 99999, curgap;
    
    var tpt = new Point_t();
    //alert("FindNextPoint_V");
    //alert("FindNextPoint_V   curLine  :"+curLine);  
        			
	if(curLine!=playerOfNum)  //마지막 라인이 아닐때만
	{	
	    //현재라인
		for(var y=0; y<gTotalHBar; y++)
		{ 
			
			if(y==0) continue;
			
			curgap = PointList[curLine][y].startY - curY;
			if(curgap <= 0) continue;
			if(oldgap >= curgap)
			{
				tpt.x = PointList[curLine][y].startX;
				tpt.y = PointList[curLine][y].startY;
				oldgap = curgap;
			}
			
		}
    
	}
	

    
	if(curLine!==0)   // 첫번째 라인이 아닐때만
	{
	    //좌측라인
		for(y=0; y<gTotalHBar-1; y++)
		{ 		
			
			//이경우는 End가 없음
			if(y==0) continue;
			
			//End없음
			curgap = PointList[curLine-1][y].endY - curY; //
			if(curgap <= 0) continue;
			if(oldgap >= curgap)
			{
				tpt.x = PointList[curLine-1][y].endX;
				tpt.y = PointList[curLine-1][y].endY;
				//console.log(curLine);
				//console.log(tpt.x,tpt.y);
/* 				alert("FindNextPoint_V   curLine  :"+curLine+
						  "tpt.x : "+tpt.x+
						  "tpt.y : "+tpt.y); */ 
				oldgap = curgap;
			}
		
		}
	}
	else if(curLine==playerOfNum)
	{
		//좌측라인
		for(y=0; y<gTotalHBar-1; y++)
		{ 		
			if(y==0) continue;
			
			curgap = PointList[curLine-1][y].endY - curY; //
			if(curgap <= 0) continue;
			if(oldgap >= curgap)
			{
				tpt.x = PointList[curLine-1][y].endX;
				tpt.y = PointList[curLine-1][y].endY;
/* 				alert("FindNextPoint_V   curLine  :"+curLine+
						  "tpt.x : "+tpt.x+
						  "tpt.y : "+tpt.y); */ 
				oldgap = curgap;
			}
		
		}
		
	} 
		
	

	return tpt;
	
}

function FindNextPoint_H(curLine, curY)
{
	var iy; 
	var y;
    var tpt = new PointDirection_t();

    //alert("FindNextPoint_H");    
    if(curLine!==0)
    {
    	for(y=0; y<gTotalHBar; y++){ 	
    		
			if(y === 0)continue;
			if(y == (gTotalHBar-1))continue;
	    	
	        // 좌측라인
	    	if(PointList[curLine-1][y].startY == curY)
	    	{
	    		tpt.x = PointList[curLine-1][y].startX;
	    		tpt.y = PointList[curLine-1][y].startY;

	    		tpt.direction = false;
	    		return tpt;
	    		
	    	}
    	}
    }	

   
    if(curLine!=playerOfNum-1)  
    {
    	for(y=0; y<gTotalHBar; y++){ 		
				
			// if(y === 0)continue;
			//if(y == (gTotalHBar-1))continue;
			
	        // 우측라인
	    	if(PointList[curLine][y].endY == curY)
	    	{
	    		tpt.x = PointList[curLine][y].endX;
	    		tpt.y = PointList[curLine][y].endY;
	    		tpt.direction = true;
	    		return tpt;
	    	}
    	}
    }
    
	return null;
}



//색 랜덤 함수 
function MakeRandomColor()
{   
	var numeric = new Array('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');

	var MadeRandomColor="#F";
	var randomColorThreeOfMemberOne="";
	// R(00),G(00),B(00) 색상 조합
	for (var i = 0; i < 5; i++) {
		randomColorThreeOfMemberOne=MakeRandomValue(0, 15);
		MadeRandomColor+=numeric[randomColorThreeOfMemberOne];
	}
	return MadeRandomColor;
}


//그리기
function DrawLadder()
{
	//alert("DrawLadder-1");
	DrawVLine();
	//alert("DrawLadder-DrawVLine");
	DrawHLine();
	//alert("DrawLadder-DrawHLine");
	DrawUserNameLabel();
	//alert("DrawLadder-DrawUserNameLabel");
	//DrawUserItemLabel();
	//alert("DrawLadder-DrawUserItemLabel");
	DrawLadderAllPerson();
	//alert("DrawLadder-DrawLadderAllPerson");
	
}


//① 수직선 그리기 
function DrawVLine()
{	
	//alert("DrawVLine-1");
	var x;
	gcontext.strokeStyle="#FFFFFF";
	for(x=0; x<playerOfNum; x++)
	{
		gcontext.beginPath();
		gcontext.moveTo(PointList[x][0].startX, PointList[x][0].startY);
		gcontext.lineTo(PointList[x][0].startX, PointList[x][0].endY);
		gcontext.stroke();		
	}

}

//② 수평바 그리기 
function DrawHLine()
{
	var x;
	var y; 
	gcontext.strokeStyle="#FFFFFF";
	for(x=0; x<playerOfNum-1; x++)
	{
		for(y=0; y<gTotalHBar; y++)
		{	
			if(y===0 )
				continue;
			if(y==(gTotalHBar-1))
				continue;
			
			
			//alert("좌표:" + "ix: " + x + ", " +"iy: " + y);
			
/* 			alert("좌표:"
					+"ix: " + x + ", "
					+"iy: " + y + ", "
					+"sx: " + PointList[x][y].startX + ", " 
					+"sy: " + PointList[x][y].startY + ", "
					+"ex: " + PointList[x][y].endX   + ", "
					+"ey: " + PointList[x][y].endY); */
			
			gcontext.beginPath();
			gcontext.moveTo(PointList[x][y].startX, PointList[x][y].startY);
			gcontext.lineTo(PointList[x][y].endX, PointList[x][y].endY);
			gcontext.stroke();	
			
		}	
	}
	
}

//③ 라벨(이름)그리기
function DrawUserNameLabel()
{
	
	var x;
	for(x=0; x<playerOfNum; x++)
	{
		gcontext.fillStyle= ResultList[x].bgcolor;
		//alert("ResultList[x].bgcolor : "+ResultList[x].bgcolor);
		gcontext.textAlign= "center";
		gcontext.font = "15px serif";
		gcontext.fillText(ResultList[x].playerName,
						  PointList[x][0].startX,
						  CANVAS_LABEL_HEIGHT);  
		gcontext.stroke();
		
	}
}

//④ 라벨(아이템)그리기
function DrawUserItemLabel(PlayerIndex)
{
	var userItem = document.getElementsByName("user_item");
	var nameOfLabelPrize;
 	
    var result = ResultList[PlayerIndex].playerResult;	
    //alert("DrawUserItemLabel  -PlayerIndex : "+PlayerIndex+",   result : "+result+",   color : "+ResultList[PlayerIndex].bgcolor+",    playerPrize : "+ResultList[PlayerIndex].playerPrize);

    

	//nameOfLabelPrize = ResultList[result].playerPrize +"("+ ResultList[PlayerIndex].playerName+")";
	nameOfLabelPrize = ResultList[PlayerIndex].playerPrize
	
	gcontext.font = "15px serif";
	gcontext.fillStyle= ResultList[PlayerIndex].bgcolor;
	//alert("test[x] : "+test[x]);
	
	gcontext.fillText(nameOfLabelPrize, 
			          PointList[result][0].startX, 
			          CANVAS_LADDER_HEIGHT+(CANVAS_LABEL_HEIGHT*2));
	gcontext.stroke();
	
	
	// 화면에 붙이기
//	var tableNode = document.getElement.ById("resultTable");
//	var tbodyNode =null;
//	var trNode = document.createElement("tr");
//	var nameNode = document.createTextNode(name);
	
/* 	document.getElementById("itemresult").value +="<table>";
	for (var i = 0; i < nameOfLabelPrize.length; i++) 
	{
		document.getElementById("itemresult").value += nameOfLabelPrize;
		
	}
	document.getElementById("itemresult").value +="</table>"; */
	
	
}

function DrawLadderAllPerson()
{
	//alert("DrawLadderAllPerson");
	//var playercolor = MakeRandomColor();
	
	//alert("DrawLadderAllPerson playeridx:"+playeridx);

	gDrawPointIndex = 0;
	gDrawPlayerIndex = 0;
	gDTimer=setInterval(DrawBarAll, 500);
}

//-- <변수참조>위에 전역으로 이미 선언함
//var gDrawPointIndex;    
//var gDrawPlayerIndex;
//var gDTimer;

function DrawBarAll()
{
	var size =ResultList[gDrawPlayerIndex].drawPointCount;
	//alert("[DrawBarAll] Processing : (gDrawPlayerIndex  :"+gDrawPlayerIndex+",  PointIndex : "+ gDrawPointIndex +",  size"+size+")");

/* 	
   		alert("DrawBarAll"
	 		+"gDrawPlayerIndex : "+gDrawPlayerIndex
			+"gDrawPointIndex : "+gDrawPointIndex
			+"point size : "+size);    */
	
 	var color = ResultList[gDrawPlayerIndex].bgcolor;
	gcontext.strokeStyle=color; 
	gcontext.linewidth = 50;
	gcontext.beginPath();
	
	//alert("[DrawBarAll] Processing ---> 1");
	gcontext.moveTo(ResultList[gDrawPlayerIndex].drawPointList[gDrawPointIndex].x, ResultList[gDrawPlayerIndex].drawPointList[gDrawPointIndex].y);
	//alert("[DrawBarAll] Processing ---> 2");
	//fixme
	var drawPointIndex = Math.min(size-1, gDrawPointIndex+1);
	gcontext.lineTo(ResultList[gDrawPlayerIndex].drawPointList[drawPointIndex].x, ResultList[gDrawPlayerIndex].drawPointList[drawPointIndex].y);
	gcontext.stroke();	
	//alert("[DrawBarAll] Processing ---> 3");
 //alert("before-gDrawPointIndex :"+gDrawPointIndex);
	gDrawPointIndex++;
 //alert("after-gDrawPointIndex :"+gDrawPointIndex);
 
	if(size <= gDrawPointIndex)
	{
		//alert("[DrawBarAll] Processing ---> 4 gDrawPlayerIndex   : "+gDrawPlayerIndex);

		DrawUserItemLabel(gDrawPlayerIndex);
		//alert("after - gDrawPlayerIndex   : "+gDrawPlayerIndex);
		gDrawPlayerIndex++;    // 플레이어 인덱스가 한명 늘어나게 되면 

		gDrawPointIndex = 0;   // 포인트인덱스는 0이 된다. 
		//alert("[DrawBarAll] Processing ---> 5 gDrawPlayerIndex   : "+gDrawPlayerIndex);
		
/* 		alert("size  : "+size+
				  ",  playerOfNum : "+playerOfNum+
				  ",  gDrawPlayerIndex : "+gDrawPlayerIndex); */
		
		if(playerOfNum <= gDrawPlayerIndex)
		{
//			alert("bye!! bye!!")
			clearInterval(gDTimer);
		}
	}
}
 


function DrawLadderOnPerson(playeridx)
{
	//var playercolor = MakeRandomColor();
	//alert("DrawLadderOnPerson playeridx:"+playeridx);
	
	//alert("DrawLadderOnPerson");
	gDrawPointIndex = 0;
	gDrawPlayerIndex = playeridx;
	gDTimer=setInterval(DrawBar, 50);
}


//var gDrawPointIndex;
//var gDrawPlayerIndex;
//var gDTimer;

function DrawBar()
{
	/* alert("DrawBar"); */
	var size = ResultList[gDrawPlayerIndex].drawPointCount;
	
 	var color = ResultList[gDrawPlayerIndex].bgcolor;
	gcontext.strokeStyle=color; 
	gcontext.linewidth = 20;
	gcontext.beginPath();
	gcontext.moveTo(ResultList[gDrawPlayerIndex].drawPointList[gDrawPointIndex].x, ResultList[gDrawPlayerIndex].drawPointList[gDrawPointIndex].y);
	gcontext.lineTo(ResultList[gDrawPlayerIndex].drawPointList[gDrawPointIndex+1].x, ResultList[gDrawPlayerIndex].drawPointList[gDrawPointIndex+1].y);
	gcontext.stroke();	
	
	gDrawPointIndex++;
	
	if(size <= gDrawPointIndex)
		clearInterval(gDTimer);
	
}




/* //Y좌표의 값을 내림차순으로 정렬(스왑) 
function SortPointMap(playerOfNum, HbarOfNum)
{
	return PointList;
}
 */

</script>
<meta charset="UTF-8">
<title>사다리게임</title>
</head>
<body>

	<h2>사다리게임</h2>
	<hr/>

<form action="" method="get" id="myform">
	<canvas id="canvas" width="840" height="610"
		style="background-color: #000000"></canvas>
	<br/><br/>
	<input type="submit" class="button3" value="확인" onclick="resultgo()"/> 	
	
 <div style="visibility:hidden;">
	<input id="nodes" value="<%=request.getAttribute("nodes") %>"><br/>
	<input id="join_num" value="<%=request.getAttribute("join_num") %>"><br/>
	<input type="text" name="game_id" value="<%=request.getAttribute("game_id") %>"><br/>
 		<table>
			<c:forEach var="userlist" items="${list}">
				<tr>
					<td><input name="user_name" value="${userlist.user_name}"><td>
					<td><input name="user_item" value="${userlist.user_item}"></td>
				</tr>
			</c:forEach>
		 </table>
	
	 
	 <table border="1" id="resultTable">
		  <tbody>
			  <tr>
				   <td width="80">이름</td>
				   <td width="160">전화번호</td>
				   <td width="240">주소</td>
			  </tr>
		 </tbody>
	</table>  
</div>
 

</form>
</body>
</html>