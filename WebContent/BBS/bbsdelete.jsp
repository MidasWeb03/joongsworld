<%@page import="sist.co.MemberDAO"%>
<%@page import="sist.co.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<%

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

MemberDAO dao = MemberDAO.getInstance();
boolean isS = dao.BBSDelete(seq);

if(isS){%>
	<script>
		alert("글이 삭제 되었습니다.");
		location.href= "bbslist.jsp";
	</script>
<%} else { %>
	<script>
		alert("글 삭제를 실패 하였습니다.");
		location.href= "bbslist.jsp";
	</script>
<%} %>


</body>
</html>