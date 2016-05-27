<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/border_layout.css">
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<div class="whole">
	<div class="header">
	<h1>Joong's World</h1>
	</div>
	<div class="nav">
	</div>
	<div class="section">
		<div class="aside">
		</div>
		<div class="content">
			<h2>SIGN UP</h2>
			<form action="signupAf.jsp" method="post">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="id" value=""/></td>
				</tr>
				<tr>
					<td>PASSWORD</td>
					<td><input type="password" name="pwd" value=""/></td>
				</tr>
				<tr>
					<td>NAME</td>
					<td><input type="text" name="name" value=""/></td>
				</tr>
				<tr>
					<td>EMAIL</td>
					<td><input type="text" name="email" value=""/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="SIGN UP"/></td>
				</tr>
				<tr>
					<td colspan="2"><a href="index.jsp">BACK TO HOME</a></td>
				</tr>
			</table>
			</form>
		</div>
	</div>
	<div class="footer">
	<h4>Copyright ⓒ Joong's</h4>
	</div>
</div>

</body>
</html>