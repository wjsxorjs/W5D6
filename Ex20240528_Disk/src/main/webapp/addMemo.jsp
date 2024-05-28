<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="mybatis.service.FactoryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String content = request.getParameter("content");	// content
	String writer = request.getParameter("writer"); // writer
	String ip = request.getRemoteAddr(); // ip
	
	if(content != null && writer != null && ip != null){
		Map<String, String> m_map = new HashMap<>();
		m_map.put("content",content);
		m_map.put("writer",writer);
		m_map.put("ip",ip);
		
		
		SqlSession ss = FactoryService.getFactory().openSession();
		int chk = ss.insert("memo.add",m_map);
		
		if(chk == 1){
			ss.commit();
		} else{
			ss.rollback();
		}
		ss.close();
	}
	
	response.sendRedirect("memoList.jsp");
	
%>
</body>
</html>