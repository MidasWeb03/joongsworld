<%@page import="sist.co.MyCalendar"%>
<%@page import="java.util.List"%>
<%@page import="sist.co.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sist.co.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/border_layout.css">
<title>Insert title here</title>
<%!
public String toDates(String mdate){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
	String s = mdate.substring(0,4) + "-" + mdate.substring(4,6) + "-"
			+ mdate.substring(6, 8) + " " + mdate.substring(8, 10) + ":"
			+ mdate.substring(10, 12) + ":00"; 
	Timestamp d = Timestamp.valueOf(s);
	
	return sdf.format(d);
}
public String two(String msg){
	return msg.trim().length()<2 ? "0"+msg : msg.trim();
}
%>  
</head>
<body>

<%request.setCharacterEncoding("UTF-8"); %>
<%
Member user = (Member)session.getAttribute("login");
if(user == null){%>
	<script>
	alert("다시 로그인 해주세요!");
	location.href="../index.jsp";
	</script>
<% return;
}%>

<%
// year, month, day
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String dates = year + two(month) + two(day);

MemberDAO cdao = MemberDAO.getInstance();
List<MyCalendar> cdtos = cdao.getDayList(user.getId(), dates);
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
			<p><strong><%=user.getName()%></strong> 님 반갑습니다</p>
			<p><a href="../logout.jsp">로그아웃</a></p>
		</div>
	</div>
	<div class="section">	
		<div class="aside">
			<button onclick="location.href='calendar.jsp'">달력 보기</button>
		</div>
		<div class="content">
			<h2>달력</h2>
			<table border="1">
				<col width="100"/><col width="225"/>
				<col width="450"/><col width="50"/>
				
				<tr bgcolor="#09bbaa">
					<td>번호</td>
					<td>시간</td>
					<td>제목</td>
					<td>삭제</td>
				</tr>
				
				<%
				for(int i=0; i<cdtos.size(); i++){
					MyCalendar cald = cdtos.get(i);%>
					<tr>
						<td><%=i+1 %></td>
						<td><%= toDates(cald.getRdate()) %></td>
						<td><a href='calendardetail.jsp?seq=<%=cald.getSeq()%>'><%=cald.getTitle() %></a></td>
						<td>
							<form action="calendardel.jsp" method="post">
								<input type="hidden" name="seq" value="<%=cald.getSeq()%>"/>
								<input type="submit" value="일정삭제"/>
							</form>
						</td>
					</tr>
				<%}
				%>
				
				</table>
		</div>
	</div>
	<div class="footer">
	<h4>코피라이터 ⓒ 중쓰</h4>
	</div>
</div>

</body>
</html>