<%@page import="mybatis.vo.MemberVO"%>
<%@page import="mybatis.service.FactoryService"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.w3c.dom.css.CSSFontFaceRule"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.HashMap"%>
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
		String s_id = request.getParameter("u_id");
		String s_pw = request.getParameter("u_pw");
		
		
		HashMap<String, String> m_map = new HashMap<>();
		
		m_map.put("mid",s_id);
		m_map.put("mpw",s_pw);
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		MemberVO mvo = ss.selectOne("member.login",m_map);
		
		
		//index.jsp로 돌아갈 때 현재 로그인 상태를 mode라는 변수로 판단하기로 했다.
		
		int mode = 0;
		
		if(mvo != null){
			session.setAttribute("mvo", mvo);
		}
			mode = 1;
		
			
			response.sendRedirect("index.jsp?mode="+mode);
	%>
</body>
</html>