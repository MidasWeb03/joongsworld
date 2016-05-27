<%@page import="sist.co.MyCalendar"%>
<%@page import="java.util.List"%>
<%@page import="sist.co.MemberDAO"%>
<%@page import="sist.co.Member"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%!
 // calllist.jsp 이동시킬 메소드 = "href"
 public String callist(int year, int month, int day)
 {
	 String s = "";
	 
	 s+= String.format("<a href='%s?year=%d&month=%d&day=%d'>",
			 "daylist.jsp", year, month, day);
	 
	 s+= String.format("%2d", day);
	 s+= "</a>";
	 return s;
 }
 // 일정을 작성하기 위한 메소드
 public String showPen(int year, int month, int day)
 {
	 String s = "";
	 String url = "calendarwrite.jsp";
	 String image = "<img src='../image/pen.gif'>";
	 
	 s = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>",
			 url, year, month, day, image);
	 return s;
 }
 public String two(String msg){
	 return msg.trim().length()<2 ? "0" + msg : msg.trim();
 }
 // 15지 이상이면..... 를 이용하여 표시
 public String dot3(String msg){
	 String s = "";
	 if(msg.length() >= 15){
		 s = msg.substring(0, 15);
		 s += "...";
	 } else {
		 s = msg.trim();
	 }
	 return s;
 }
 public String makeTable(int year, int month, int day, List<MyCalendar> lcdtos){
	 String s = "";
	 String dates = (year + "") + two(month + "") + two(day + "");
	 
	 s = "<table>";
	 s += "<col width='98'>";
	 
	 for(MyCalendar lcd:lcdtos){
		 if(lcd.getRdate().substring(0, 8).equals(dates)){
			 s += "<tr bgcolor='pink'>";
			 s += "<td>";
			 s += "<a href='calendardetail.jsp?seq=" + lcd.getSeq() + "'>";
			 s += "<font style='font-size:8; color:red'>";
			 s += dot3(lcd.getTitle());
			 s += "</font>";
			 s += "</td>";
			 s += "</tr>";
		 }
	 }
	 s += "</table>";
	 return s;
 }
 %>    
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
String days[] = {"일","월","화","수","목","금","토"};

MemberDAO dao = MemberDAO.getInstance();
Member user = (Member)session.getAttribute("login");

String syear = request.getParameter("year");
String smonth = request.getParameter("month");

Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);
if(!(syear==null || syear.trim().equalsIgnoreCase(""))){
	year = Integer.parseInt(syear);
}
int month = cal.get(Calendar.MONTH) + 1;
if(!(smonth==null || smonth.trim().equalsIgnoreCase(""))){
	month = Integer.parseInt(smonth);
}

if(month<1){
	month = 12;
	year--;
}
if(month>12){
	month = 1;
	year++;
}
cal.set(year, month-1, 1);		// 첫 날로 세팅

List<MyCalendar> cdtos = dao.getMyCalendarList(user.getId(), year+two(month+""));

int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

String pp = String.format("<a href='%s?year=%d&month=%d'><img src='../image/left.gif'></a>",
							"calendar.jsp", year-1, month);
String p = String.format("<a href='%s?year=%d&month=%d'><img src='../image/prec.gif'></a>",
							"calendar.jsp", year, month-1);
String n = String.format("<a href='%s?year=%d&month=%d'><img src='../image/next.gif'></a>",
							"calendar.jsp", year, month+1);
String nn = String.format("<a href='%s?year=%d&month=%d'><img src='../image/last.gif'></a>",
							"calendar.jsp", year+1, month);
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
			<button onclick="location.href='monthlist.jsp?id=<%=mem.getId()%>&year=<%=year%>&month=<%=month%>'">
			이번 달<br>일정보기</button>
		</div>
		<div class="content">
			<h2>달력</h2>
			<table border="1">
				<col width="100"><col width="100"><col width="100"><col width="100">
				<col width="100"><col width="100"><col width="100">
				<tr height="100">
					<td colspan="7" align="center"><%=pp %><%=p %><font color="red" 
					style="font-size:20"><%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %>
					</font><%=n %><%=nn %>
					</td>
				</tr>
				<tr height="100">
				  <%for(int i=0; i<7; i++){ %>
					<td><%=days[i] %></td>
					<%} %>
			  </tr>
			  <tr height="100" align="left" valign="top">
			  <%// 공백 부분
			  for(int i=1; i<dayOfWeek; i++){%>
			  		<td>&nbsp;</td>
			  <%}
			 	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			 	for(int i=1; i<=lastDay; i++){%>
			 		<td><%=callist(year, month, i)%>&nbsp;<%=showPen(year, month, i) %>
			 		<%=makeTable(year, month, i, cdtos) %>
			 		</td>
			 		<%
			 		if((i + dayOfWeek - 1)%7 == 0){%>
			 			</tr>
			 			<tr height="100" align="left" valign="top">
			 		<%}		
			 	}
			 	for(int i=0; i<(7-(dayOfWeek + lastDay - 1)%7)%7; i++){%>
			 		  		<td>&nbsp;</td>
			 	<%}%>
			 	</tr>
			</table>
		</div>
	</div>
	<div class="footer">
	<h4>코피라이터 ⓒ 중쓰</h4>
	</div>
</div>

</body>
</html>