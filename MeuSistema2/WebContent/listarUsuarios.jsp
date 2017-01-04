<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Lista de Usuários</title>
</head>
<body bgcolor="#99bbff" align="center">
	
	<table width="100%" border="0" cellspacing="10" cellpadding="4" bgcolor="gray">
   	<caption><h1 style="color: #002b80">Lista de Usuários</h1></caption>
	<tr align="center" bgcolor="white">
	<td>ID</td>
	<td>LOGIN</td>
	<td>SENHA</td>
	<td>EDITAR</td>
	<td>APAGAR</td>
	</tr>

	<%
	
	HttpSession sessao = request.getSession();
	if(sessao.getAttribute("login") == null){
		response.sendRedirect("http://localhost:8080/MeuSistema2/index.jsp");
	}
	

	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		
		String SQLDelete = "DELETE FROM usuarios WHERE id = ?";
		String SQLSelect = "SELECT * FROM usuarios";
		
		if(request.getParameter("id") != null){
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
				
				PreparedStatement pstm = conn.prepareStatement(SQLDelete);
				
				int id = Integer.parseInt(request.getParameter("id"));
				
				pstm.setInt(1, id);
				pstm.execute();
				pstm.close();
				conn.close();
				
				
			}catch(Exception ex){
				
			}
		}

		try{
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
			
			Statement stm = conn.prepareStatement(SQLSelect);
			ResultSet rs = stm.executeQuery(SQLSelect);
			
			while(rs.next()){
				%>
				<tr align=100%" bgcolor="white">
				<td><%out.println(rs.getInt("id")); %></td>
				<td><%out.println(rs.getString("login")); %></td>
				<td><%out.println(rs.getString("senha")); %></td>
				<% out.println("<td><a href='http://localhost:8080/MeuSistema2/editarUsuarios2?id=" + rs.getInt("id")+"'>[EDITAR]</a></td>"); %>
				<% out.println("<td><a href='http://localhost:8080/MeuSistema2/listarUsuarios.jsp?id=" + rs.getInt("id")+"'>[APAGAR]</a></td>"); %>
				</tr>
				<%
			}	
			stm.close();
			conn.close();
			
		} catch(Exception ex){
			ex.getMessage();
		}
	}catch(Exception ex) {
		ex.getMessage();
	}
	%>
	</tr>
	</table>
	<td><a href='http://localhost:8080/MeuSistema2/index.jsp'>VOLTAR</a></td>
</body>
</html>