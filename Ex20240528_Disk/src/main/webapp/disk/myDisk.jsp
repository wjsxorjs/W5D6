<%@page import="mybatis.vo.MemberVO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
	// 선언부: 멤버 변수, 멤버 메소드를 정의할 때 사용
	//	첫 호출시에만 수행
	
	// 개인이 사용한 용량을 측정하는 메서드 (File객체에서는 파일들만 용량을 얻어낼 수 있고,
	//							  폴더는 안에 파일들의 용량을 모두 더해야하기 때문에
	//								재귀함수를 이용한다.)
	
	public int useSize(File f){
		// 인자로 전달된 File객체가 폴더여야한다.
		// 이 폴더의 하위 요소들의 File용량을 모두 더해야 한다.
		// 우선 하위요소들을 모두 얻어내라.
		
		File[] list = f.listFiles();
		//하위 요소들 중 폴더이면 재귀호출, 파일이면 용량 수집!
		int size = 0;
		
		for(File sf : list){
			if(sf.isFile()){
				size += sf.length(); // 용량 누적
			} else {
				size += useSize(sf); // 재귀호출
			}
		} //for의 끝
	
		return size;
	}

%>

<% // 스크립트릿: 호출할 때마다 수행

	int totalSize = 1024*1024*10;
	int useSize = 0;
	
	Object obj = session.getAttribute("mvo");
	if(obj != null){
		MemberVO mvo = (MemberVO) obj;
%>

<!doctype html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		width: 600px;
		border: 1px solid #27a;
		border-collapse: collapse;
	}
	table th, table td{
		border: 1px solid #27a;
		padding: 4px;
	}
	table th{ background-color: #bcbcbc; }
	.title { background-color: #bcbcbc; width: 25%; }
	
	.btn{
		display: inline-block;
		width: 70px;
		height: 20px;
		text-align: center;
		padding:0px;	
		margin-right: 20px;	
	}
	.btn a{
		display: block;
		width: 100%;
		padding: 4px;
		height: 20px;
		line-height: 20px;
		background: #27a;
		color: #fff;
		border-radius: 3px;
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
	}
	.btn a:hover{
		background: #fff;
		color: #27a;
		border: 1px solid #27a;
	}
	
	#f_win{
		width: 220px;
		height: 80px;
		padding: 20px;
		border: 1px solid #27a;
		border-radius: 8px;
		background-color: #efefef;
		text-align: center;
		position: absolute;
		top: 150px;
		left: 250px;
		display: none;
	}
	#f_win2{
		width: 300px;
		height: 80px;
		padding: 20px;
		border: 1px solid #27a;
		border-radius: 8px;
		background-color: #efefef;
		text-align: center;
		position: absolute;
		top: 150px;
		left: 250px;
		display: none;
	}
</style>
</head>
<body>
	<h1>My Disk service</h1>
	<hr/><%=mvo.getM_name() %>
	(<span class="m_id"><%=mvo.getM_id() %></span>)님의 디스크
	&nbsp;[<a href="javascript:home()">Home</a>]
	<hr/>
	
	<table summary="사용량을 표시하는 테이블">
		<tbody>
			<tr>
				<th class="title">전체용량</th>
				<td><%=totalSize/1024 %>KB</td>
			</tr>
			<tr>
				<th class="title">사용량</th>
				<td>KB</td>
			</tr>
			<tr>
				<th class="title">남은용량</th>
				<td>KB</td>
			</tr>
		</tbody>
	</table>
	<hr/>
		<div id="btn_area">
			<p class="btn">
				<a href="javascript:selectFile()">
					파일올리기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:makeFolder()">
				
					폴더생성
				</a>
			</p>
			<p class="btn">
				<a href="javascript:exe()">
					파일생성
				</a>
			</p>
		</div>		
	<hr/>
	
	<label for="dir">현재위치:</label>
	<span id="dir"></span>
	
	<table summary="폴더의 내용을 표현하는 테이블">
		<colgroup>
			<col width="50px"/>
			<col width="*"/>
			<col width="80px"/>
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>폴더 및 파일명</th>
				<th>삭제여부</th>
			</tr>
		</thead>
		<tbody>
		
			<tr>
				<td>↑</td>
				<td colspan="2">
					<a href="javascript:goUp('')">
						상위로...
					</a>
				</td>
				
			</tr>

			<tr>
				<td>

						<img src="../images/file.png"/>

						<img src="../images/folder.png"/>

				</td>
				<td>

					<a href="javascript: gogo('')">
						
					</a>

					<a href="javascript:down('')">
						
					</a>
				
				</td>
				<td></td>
			</tr>

		</tbody>
	</table>
	
	<form name="ff" method="post">
		<input type="hidden" name="f_name"/>
		<input type="hidden" name="cPath" value=""/>
	</form>
	
	
	<div id="f_win">
		<form action="makeFolder.jsp" method="post" name="frm">
			<input type="hidden" name="cPath" value=""/>
			<label for="f_name">폴더명:</label>
			<input type="text" id="f_name" name="f_name"/><br/>
			<p class="btn">
				<a href="javascript:newFolder()">
					만들기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:closeWin()">
					닫 기
				</a>
			</p>
		</form>
	</div>
	

	
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		
</body>
</html>
<%
	} else{
		response.sendRedirect("../index.jsp");
	}
%>

