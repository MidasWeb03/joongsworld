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
String name = request.getParameter("name");
String email = request.getParameter("email");

MemberDAO dao = MemberDAO.getInstance();
boolean isS = dao.addMember(new Member(id, pwd, name, email, 0));

if(isS){%>
	<script>
	alert("You are our member.\nWelcome to the Joong's World");
	location.href="index.jsp";
	</script>
<%} else { %>
	<script>
	alert("You can't join us.\nplease check your form");
	location.href="signup.jsp";
	</script>
<%} %>

</body>
</html>