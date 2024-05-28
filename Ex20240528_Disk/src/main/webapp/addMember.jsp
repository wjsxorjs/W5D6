<%@page import="java.io.File"%>
<%@page import="mybatis.vo.MemberVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="mybatis.service.FactoryService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");


	String m_id = request.getParameter("m_id");
	String m_pw = request.getParameter("m_pw");
	String m_name = request.getParameter("m_name");
	String m_email = request.getParameter("m_email");
	String m_phone = request.getParameter("m_phone");

	int chk = 0;
	

	SqlSession ss = FactoryService.getFactory().openSession();
	MemberVO mvo = new MemberVO();

	if(m_id != null){
		
		Map<String, String> m_map = new HashMap<>();
		
		// m_map.put("m_id",m_id);
		// m_map.put("m_pw",m_pw);
		// m_map.put("m_name",m_name);
		// m_map.put("m_email",m_email);
		// m_map.put("m_phone",m_phone);
		// int chk = ss.insert("member.add",m_map);
		
		mvo.setM_id(m_id);
		mvo.setM_pw(m_pw);
		mvo.setM_name(m_name);
		mvo.setM_email(m_email);
		mvo.setM_phone(m_phone);
		
		chk = ss.insert("member.add",mvo);
	}
	
	if(chk==1){
%>
			<span class="success">저장 완료!</span>
<%

		// 회원가입에 성공한 회원의 아이디로 된 폴더를
		// members라는 폴더 하위에 생성해야 한다.
		String path = application.getRealPath("/members/"+mvo.getM_id()); // 사이트 절대경로
		// System.out.println(path);		// 절대경로 : root(Drive)부터 접근
											// 상대경로 : 현재 파일부터 접근

		// 앞서 절대경로를 이용하여 File 객체를 생성한다.
		File f = new File(path);
		
		// 가상으로 만든 File 객체가 실제 존재하지 않을 때만
		// 물리적으로 폴더를 생성한다.
		if(!f.exists()){
			f.mkdirs();
		}
						
		// 해당 웹 사이트(어플리케이션)에 속성 저장
		// 사이트 접속자 모두가 사용할 수 있음


		ss.commit();
	} else{
%>
		<span class="success">저장 오류!</span>
<%
		ss.rollback();
	}

	ss.close();
%>