<%@page import="sist.co.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/border_layout.css">
<title>Insert title here</title>
</head>
<body>

<%request.setCharacterEncoding("UTF-8"); %>
<%
Member mem = (Member)session.getAttribute("login");
if(mem == null){%>
	<script>
	alert("다시 로그인 해주세요!");
	location.href="../index.jsp";
	</script>
<%}%>

<div class="whole">
	<div class="header">
	<h1>중쓰의 세계</h1>
	</div>
	<div class="nav">
		<div class="nav_left">
			<p><a href="bbslist.jsp">게시판</a></p>
			<p><a href="Calendar/calendar.jsp">일정관리</a></p>
		</div>
		<div class="nav_right">
			<p><strong><%=mem.getName()%></strong> 님 반갑습니다</p>
			<p><a href="../logout.jsp">로그아웃</a></p>
		</div>
	</div>
	<div class="section">	
		<div class="aside">
			<button onclick="location.href='bbslist.jsp'">목록</button>
		</div>
		<div class="content">
			<h2>게시 글 쓰기</h2>
			<form action="bbswriteAf.jsp" method="post">
			<table>
				<colgroup>
					<col width="100"><col width="600">
				</colgroup>
				<tr>
					<th>작성자</th>
					<td><%=mem.getId() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" size="100%"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" rows="20" cols="101"></textarea></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="글 쓰기"/></td>
				</tr>
			</table>
			</form>
		</div>
	</div>
	<div class="footer">
	<h4>코피라이터 ⓒ 중쓰</h4>
	</div>
</div>

</body>
</html>