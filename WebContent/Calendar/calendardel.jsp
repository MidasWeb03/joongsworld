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
public String two(String msg){
	return msg.trim().length()<2 ? "0" + msg : msg;
}

public String toOne(String msg){
	return msg.charAt(0)=='0' ? msg.charAt(1)+"" : msg.trim(); 
}
%>
</head>
<body>

<%
int seq = Integer.parseInt(request.getParameter("seq"));

MemberDAO calDao = MemberDAO.getInstance();
MyCalendar dto = calDao.getDay(seq);

boolean isS = calDao.deleteCalendar(seq);

String year = dto.getRdate().substring(0,4);
String month = toOne(dto.getRdate().substring(4,6));
String day = toOne(dto.getRdate().substring(6,8));

String url = String.format("%s?year=%s&month=%s&day=%s",
						"daylist.jsp", year, month, day);

if(isS){%>
	<script>
	alert('성공적으로 삭제했습니다');
	location.href='<%=url%>';
	</script>
<% } else {%>
	<script>
	alert('삭제되지 않았습니다');
	location.href='<%=url%>';
	</script>
<% }%>


</body>
</html>