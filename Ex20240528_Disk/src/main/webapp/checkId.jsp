<%@page import="mybatis.vo.MemberVO"%>
<%@page import="mybatis.service.FactoryService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String s_id = request.getParameter("m_id");


	SqlSession ss = FactoryService.getFactory().openSession();
	MemberVO mvo = ss.selectOne("member.check_id", s_id);
	ss.close();
	
	if(s_id.equals("-1")){
%>
		<span class="fail">너무 짧음</span>
<%
	}
	else{
		if(mvo==null){
%>
			<span class="success">사용가능</span>
<%
		} else {
%>
			<span class="fail">사용불가</span>
<%	
		}
	}
%>