<%@page import="sist.co.Member"%>
<%@page import="sist.co.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDAO dao = MemberDAO.getInstance();
Member mem = dao.Login(new Member(id,pwd,null,null,0));
if(mem != null && !mem.getId().equals("")){
	session.setAttribute("login", mem);
	session.setMaxInactiveInterval(30*60);%>
	<script>
	alert("로그인 되었습니다!")
	location.href="main.jsp";
	</script>
<%} else {%>
	<script>
	alert("아이디 및 패스워드를 확인해주세요!");
	location.href="index.jsp";
	</script>
<%}%>

</body>
</html>