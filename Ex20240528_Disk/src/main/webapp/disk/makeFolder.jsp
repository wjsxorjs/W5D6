<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	// 파라미터 받기
	String cPath = request.getParameter("cPath"); // 위치
	String f_name = request.getParameter("f_name"); // 폴더명
	
	//절대경로 생성
	String path = application.getRealPath("/members/"+cPath+"/"+f_name); // "/" < webapp
	
	
	// 절대경로를 가지고 File 객체생성
	File f = new File(path);
	
	if(!f.exists()){
		f.mkdirs(); // 폴더 생성
		
	}
	
	
	// 원래 있던 위치(cPath)로 강제이동
	response.sendRedirect("myDisk.jsp?cPath="+cPath);
	
%>    

<script>
	location.href = "myDisk.jsp?cPath=<%=cPath%>";
</script>