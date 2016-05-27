<%@page import="sist.co.MyCalendar"%>
<%@page import="sist.co.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%!
public String makeTwo(String str){
	if(str.trim().length()<2){
		str =  "0" + str;
	}
	return str.trim();
}
%>
</head>
<body>

<%-- id title content --%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");
%>
<%-- year month day hour min --%>
<% 
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String hour = request.getParameter("hour");
String min = request.getParameter("min");

String wdate = year + makeTwo(month) + makeTwo(day) + makeTwo(hour) + makeTwo(min);
System.out.println(wdate);
%>
<%-- DB --%>
<%
MemberDAO dao = MemberDAO.getInstance();
boolean isS = dao.addMyCalendar(new MyCalendar(0, id, title, content, wdate, null));
%>

<%-- 성공/실패 --%>

<%
if(isS){ %>
	<script>
		alert("일정 입력 성공");
		location.href="calendar.jsp?year="+<%=year%>+"&month="+<%=month%>;
	</script>
<% } else { %>
	<script>
		alert("다시 입력 하세요");
		location.href="calwrite.jsp?year="+<%=year%>+"&month="+<%=month%>+"&day="+<%=day%>;
	</script>
<%}
%>

</body>
</html>