<%@page import="java.util.List"%>
<%@page import="sist.co.MemberDAO"%>
<%@page import="sist.co.Member"%>
<%@page import="sist.co.BBS"%>
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
MemberDAO dao = MemberDAO.getInstance();
List<BBS> bbs = dao.BBSList();
%>

<div class="whole">
	<div class="header">
	<h1>중쓰의 세계</h1>
	</div>
	<div class="nav">
		<div class="nav_left">
			<p><a href="../main.jsp">처음으로</a></p>
			<p><a href="bbslist.jsp">게시판</a></p>
			<p><a href="../Calendar/calendar.jsp">일정관리</a></p>
		</div>
		<div class="nav_right">
			<p><strong><%=mem.getName()%></strong> 님 반갑습니다</p>
			<p><a href="../logout.jsp">로그아웃</a></p>
		</div>
	</div>
	<div class="section">	
		<div class="aside">
			<button onclick="location.href='bbswrite.jsp'">글쓰기</button>
		</div>
		<div class="content">
			<h2>게시판</h2>
			<table>
				<colgroup>
					<col width="50"><col width="450"><col width="150"><col width="200"><col width="50">
				</colgroup>
				<tr style="background-color:SeaShell">
					<th></th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
				</tr>
				<%if(bbs.size()==0){%> 
				<tr>
					<td colspan="5">작성된 게시글이 없습니다.</td>
				</tr>
				<% } else {
					for(int i=0; i<bbs.size(); i++){
						BBS t_bbs = bbs.get(i);%>
						<tr <%=i%2==0 ? "class='even'":"class='odd'" %>>
							<td><%=t_bbs.getSeq() %></td>
							<td style="text-align:left">
							<a href="bbsdetail.jsp?seq=<%=t_bbs.getSeq()%>">
								<%=t_bbs.getTitle() %></a></td>
							<td><%=t_bbs.getId() %></td>
							<td><%=t_bbs.getWdate() %></td>
							<td><%=t_bbs.getReadcount()%></td>
						</tr>
					<%}
					} %>
			</table>
		</div>
	</div>
	<div class="footer">
	<h4>코피라이터 ⓒ 중쓰</h4>
	</div>
</div>

</body>
</html>