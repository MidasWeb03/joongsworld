<%@page import="sist.co.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/border_layout.css">
<title>Insert title here</title>
</head>
<body>

<%request.setCharacterEncoding("UTF-8"); %>
<%
Member mem = (Member)session.getAttribute("login");
if(mem == null){%>
	<script>
	alert("다시 로그인 해주세요!");
	location.href="index.jsp";
	</script>
<%}%>

<div class="whole">
	<div class="header">
	<h1>중쓰의 세계</h1>
	</div>
	<div class="nav">
		<div class="nav_left">
			<p><a href="BBS/bbslist.jsp">게시판</a></p>
			<p><a href="Calendar/calendar.jsp">일정관리</a></p>
		</div>
		<div class="nav_right">
			<p><strong><%=mem.getName()%></strong> 님 반갑습니다</p>
			<p><a href="logout.jsp">로그아웃</a></p>
		</div>
	</div>
	<div class="section">	
		<div class="aside">
		</div>
		<div class="content">
			<h2>환영합니다</h2>
			<img src="image/welcome.png">
		</div>
	</div>
	<div class="footer">
	<h4>코피라이터 ⓒ 중쓰</h4>
	</div>
</div>

</body>
</html>