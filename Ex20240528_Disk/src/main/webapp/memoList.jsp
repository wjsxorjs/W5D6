<%@page import="mybatis.vo.MemberVO"%>
<%@page import="mybatis.service.FactoryService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="mybatis.vo.MemoVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<style>
	#list_table{
		border-collapse: collapse;
		width: 400px;
	}
	#list_table th, #list_table td{
		border: 1px solid #27a;
		padding: 3px;
	}
	#list_table thead th{
		background: #5ad;
		color: #fff;
	}
	#list_table caption{
		font-size: 30px;
		font-weight: bold;
		padding-bottom: 20px;
	}
	
	.btn{
		width: 70px;
		height: 20px;
		text-align: center;
		padding:0px;		
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
	
	#list_table thead tr:first-child td{
		border: none;
	}
	
	#write_win{ display: none; }
	
	#writer{
		background-color: #dedede;
		border: 1px solid #ababab;
	}
</style>
</head>
<body>
<%
	// 로그인이 되었을 때만 수행한다.
	Object obj = session.getAttribute("mvo");
	if(obj != null){
		MemberVO mvo = (MemberVO) obj;
%>
	<div id="wrap">
		<table id="list_table">
			<caption>메모 리스트</caption>
			<colgroup>
				<col width="50px">
				<col width="*">
				<col width="80px">
				<col width="90px">
			</colgroup>
			<thead>
				<tr>
					<td colspan="3" >
						<p class="btn">
							<a href="javascript:writeMemo()">
								글쓰기
							</a>
						</p>	
					</td>
					<td>
						<p class="btn">
							<a href="javascript:location.href='index.jsp?mode=1'">
								뒤로
							</a>
						</p>
					</td>
				</tr>
				<tr>
					<th>번호</th>
					<th>내용</th>
					<th>글쓴이</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
			<%
				// 메모리스트
				SqlSession ss = FactoryService.getFactory().openSession();
				List<MemoVO> m_list = ss.selectList("memo.all");
				if(m_list.size() >0){
					for(MemoVO mevo: m_list){
						%><tr>
							<td><%=mevo.getM_idx() %></td>
							<td><%=mevo.getContent() %></td>
							<td><%=mevo.getWriter() %></td>
							<td><%=mevo.getWrite_date() %></td>
						</tr><%
					}
				} else { // 등록된 메모가 없을 때
				%>
					<tr>
						<td colspan="4">
							등록된 메모가 없습니다.
						</td>
					</tr>		
				<%
				}
				ss.close();
				
			%>
			</tbody>
		</table>
	</div>
	
	
	<div id="write_win" title="글쓰기">
		<form>
			<table>
				<tbody>
				
					<tr>
						<td><label for="writer">작성자:</label></td>
						<td>
							<input type="text" id="writer" 
							name="writer" 
							value="<%=mvo.getM_name()%>"
							readonly/>
						</td>
					</tr>
					<tr>
						<td><label for="content">내용:</label></td>
						<td>
							<textarea cols="40" rows="6" 
							id="content" name="content"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<p class="btn">
							<%--
								아래의 a태그에 exe함수 호출 시
								this.form을 인자로 전달하지만
								전달되지 않는다. 이유는
								a태그는 form의 하위요소로 인식되지
								않는다 그래서 this.form이 
								적용되지 않는다.
							 --%>
								<a href="javascript:exe(this.form)">
									저장
								</a>
							</p>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		<%--
			String svChk = request.getParameter("svChk");
			if(svChk != null){
				%>
				alert("저장 성공!");
				location.href="memoList.jsp";
				<%
			}
		--%>
	
	
		function writeMemo(){
			// 안 보이던 div가 보이도록 하는 부분
			$("#write_win").dialog({
				width:450, 
				height:280
			});
		}
		
		function exe(ff){ 	// 해당 ff는 a태그에서 this.form을 해주었기에
							// 선택된 form이 없으므로 document.forms[0]을 이용함
			ff = document.forms[0];
			let str = $("#content").val();
			if(str.trim().length < 1){
				alert("내용을 입력하세요");
				$("#content").val("");//청소
				$("#content").focus();
				return;
			}
			ff.action = "addMemo.jsp";
			ff.method = "post";
			ff.submit();//서버로 보내기
		}
	</script>
<% } else {
	response.sendRedirect("index.jsp");
}
%>	
</body>
</html>









    