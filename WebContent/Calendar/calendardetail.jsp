<%@page import="sist.co.MyCalendar"%>
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
<script>
function modifydate(seq){
	location.href= 'calendarupdate.jsp?seq=' + seq;
}
</script>
</head>
<%!
public String toDates(String mdate){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
	String s = mdate.substring(0,4) + "-" + mdate.substring(4,6) + "-"
			+ mdate.substring(6,8) + " " + mdate.substring(8,10) + ":"
			+ mdate.substring(10,12) + ":00"; 
	Timestamp d = Timestamp.valueOf(s);
	
	return sdf.format(d);
}

public String toOne(String msg){
	return msg.charAt(0)=='0' ? msg.charAt(1)+"" : msg.trim(); 
}
%>
<style>
span{
	color:lightgreen;
}
</style>
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

<jsp:useBean id="cmb" class="sist.co.CalManBean"/>	
<jsp:setProperty name="cmb" property="seq"/>		

<%
//CalManBean cmb = new CalManBean();
//cmb.setSeq(Integer.parseInt(request.getParameter("seq")));

MemberDAO dao = MemberDAO.getInstance();
MyCalendar dto = dao.getDay(cmb.getSeq());
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
			<%
			String year = dto.getRdate().substring(0,4);
			String month = dto.getRdate().substring(4,6);
			String day = dto.getRdate().substring(6,8);
			String url = String.format("%s?year=%s&month=%s", 
					"calendar.jsp", year, month);
			%>
			<button onclick="location.href='<%=url%>'">달력 보기</button>
		</div>
		<div class="content">
			<h2><%=year %>년 <%=month %>월 <span><%=day %></span>일</h2>
			<table border="1">
				<col width="200"/><col width="500"/>
				
				<tr>
					<td>아이디</td>
					<td><%=dto.getId() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><%=dto.getTitle() %></td>
				</tr>
				<tr>
					<td>일정</td>
					<td><%=toDates(dto.getRdate()) %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name='content' rows='20' cols='60' 
					readonly='readonly'><%=dto.getContent() %></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="수정" onclick="modifydate('<%=dto.getSeq()%>')"/>
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