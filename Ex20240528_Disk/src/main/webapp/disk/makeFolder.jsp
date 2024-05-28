<%@page import="mybatis.vo.MemberVO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	// 파라미터 받기
	String cPath = request.getParameter("cPath"); // 위치
	String f_name = request.getParameter("f_name"); // 폴더명
	
	
	
	if(cPath == null || f_name==null){
		response.sendRedirect("myDisk.jsp");
		return;
	}
	//절대경로 생성
	String path = application.getRealPath("/members/"+cPath+"/"+f_name); // "/" < webapp
	
	
	// 절대경로를 가지고 File 객체생성
	File f = new File(path);
	
	if(!f.exists()){
		f.mkdirs(); // 폴더 생성
				
	}

	MemberVO mvo = (MemberVO) session.getAttribute("mvo");

	if(!cPath.equals(mvo.getM_id())){
	// [상위로...] 기능 부여
	// 예를 들어 현재 위치 값(dir)이 "test/abc/123"라고
	// 가정하면 [상위로...] 기능은 "test/abc"의 위치를 의미한다.
	
	// 이를 위해서 현재 위치값에서 가장 뒤에 있는 "/"의 index를
	// 얻어내어 맨 앞에서 그 index까지만 substring하면 된다.
	int idx = cPath.lastIndexOf("/");
	String upPath = cPath.substring(0,idx);
	
	
	
	%>
		<tr>
			<td>↑</td>
			<td colspan="2">
				<a href="javascript:goUp('<%=upPath %>')">
					상위로...
				</a>
			</td>
			
		</tr>
	<% }

	String realPath = application.getRealPath("/members/"+cPath);
	
	File ff = new File(realPath);
	
	File[] f_list = ff.listFiles();
	
	for(File sf: f_list){
%>			
		<tr>
			<td>
				<%if(sf.isFile()){ %>
					<img src="../images/file.png"/>
				<%}else{ %>
					<img src="../images/folder.png"/>
				<%} %>

			</td>
			<td>

				<%if(sf.isDirectory()){ %>
				<a href="javascript: gogo('<%=sf.getName() %>')">
					<%=sf.getName() %>
				</a>
				<%} else{ %>
				<a href="javascript:down('<%=sf.getName() %>')">
					<%=sf.getName() %>
				</a>
				<%} %>
			
			</td>
			<td></td>
		</tr>
<%			
	}
	
	
	// 원래 있던 위치(cPath)로 강제이동
	// response.sendRedirect("myDisk.jsp?cPath="+cPath);
	
%>    


<!-- 
<script>
	location.href = "myDisk.jsp?cPath=<%=cPath%>";
</script>
 -->