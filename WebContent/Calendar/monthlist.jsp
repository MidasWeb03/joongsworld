<%@page import="sist.co.MyCalendar"%>
<%@page import="java.util.List"%>
<%@page import="sist.co.MemberDAO"%>
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
<% return;
}%>

<%
String id = request.getParameter("id");
String yyyy = request.getParameter("year");
String MM = request.getParameter("month");
MemberDAO dao = MemberDAO.getInstance();
int intMonth = Integer.parseInt(MM);
if(intMonth<10){
	MM = "0" + MM;
}
System.out.println(id+yyyy+MM);
List<MyCalendar> calendarlist = dao.getMyCalendarList_notFive(id, yyyy+MM);
%>


<div class="whole">
	<div class="header">
	<h1>중쓰의 세계</h1>
	</div>
	<div class="nav">
		<div class="nav_left">
			<p><a href="../main.jsp">처음으로</a></p>
			<p><a href="../BBS/bbslist.jsp">게시판</a></p>
			<p><a href="calendar.jsp">일정관리</a></p>
		</div>
		<div class="nav_right">
			<p><strong><%=mem.getName()%></strong> 님 반갑습니다</p>
			<p><a href="../logout.jsp">로그아웃</a></p>
		</div>
	</div>
	<div class="section">	
		<div class="aside">
			<button onclick="location.href='calendar.jsp?year=<%=yyyy%>&month=<%=MM%>'">달력 보기</button><br>
		</div>
		<div class="content">
			<h2><%=yyyy %>년 <span style="color:orange"><%=MM %>월</span> 일정</h2>
			<table border="1">
				<col width="50"/><col width="500"/><col width="150"/>
				<tr>
					<th>순서</th><th>제목</th><th>작성자</th><th>코멘트</th>
					<th>일정</th><th>작성날짜</th>
				</tr>
				<%
				if(calendarlist==null || calendarlist.size()==0){%>
					<tr>
						<td id="wantCenter" colspan=6 >작성된 일정이 없습니다.</td>
					</tr>
				<%}
				
				for(int i=0; i<calendarlist.size(); i++){
					MyCalendar mc = calendarlist.get(i);%>
					<tr <%=i%2==0?"class='tda'":"class='tdb'" %>>
						<td><%=i+1 %></td>
						<td><%=mc.getTitle() %></td>
						<td><%=mc.getId() %></td>
						<td><%=mc.getContent() %></td>
						<td><%=mc.getRdate() %></td>
						<td><%=mc.getWdate() %></td>	
					</tr>
				<%}%>
				</table>  
		</div>
	</div>
	<div class="footer">
	<h4>코피라이터 ⓒ 중쓰</h4>
	</div>
</div>

</body>
</html>