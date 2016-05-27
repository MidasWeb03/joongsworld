<%@page import="java.util.Calendar"%>
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
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

Member user = (Member)session.getAttribute("login");
Calendar cal = Calendar.getInstance();

int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH);
int tday = cal.get(Calendar.DATE);
int thour = cal.get(Calendar.HOUR_OF_DAY);		// 24시간
int tmin = cal.get(Calendar.MINUTE);		
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
			<button onclick="location.href='monthlist.jsp'">이번 달<br>일정보기</button>
		</div>
		<div class="content">
			<h2>일정 쓰기</h2>
			<form action="calendarwriteAf.jsp" method="post">
			<table border="1">
			
			<col width="200"/><col width="500"/>
				<tr>
					<td>아이디</td>
					<td>
						<%=user.getId() %>
						<input type="hidden" name="id" value=<%=user.getId()%>>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" size="60" name="title"/>
					</td>
				</tr>
				<tr>
					<td>일정</td>
					<td>
						
						<select name="year">
						<%
							for(int i = tyear - 5; i<tyear+6; i++)
							{%>
								<option <%=year.equals(i+"") ? "selected='selected'":"" %> 
									value="<%=i %>"><%=i %></option>
							<%}
						%>
						</select>년
						<select name="month">
						<%
							for(int i = 1; i<=12; i++)
							{%>
								<option <%=month.equals(i+"") ? "selected='selected'":"" %> 
									value="<%=i %>"><%=i %></option>
							<%}
						%>
						</select>월
						<select name="day">
						<%	
							for(int i = 1; i<= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++)
							{%>
								<option <%=day.equals(i+"") ? "selected='selected'":"" %> 
									value="<%=i %>"><%=i %></option>
							<%}
						%>
						</select>일
						<select name="hour">
						<%
							for(int i = 0; i<24; i++)
							{%>
								<option <%=(thour+"").equals(i+"") ? "selected='selected'":"" %> 
									value="<%=i %>"><%=i %></option>
							<%}
						%>
						</select>시
						<select name="min">
						<%
							for(int i = 0; i<60; i++)
							{%>
								<option <%=(tmin+"").equals(i+"") ? "selected='selected'":"" %> 
									value="<%=i %>"><%=i %></option>
							<%}
						%>
						</select>분
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" rows="20" cols="60"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="글쓰기"/>
					</td>
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