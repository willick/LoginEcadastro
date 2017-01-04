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
<title>Produtos Cadastrados</title>
</head>
<body bgcolor="#99bbff" align="center">
	
	<table border="0" cellspacing="10" cellpadding="4" bgcolor="gray">
   	<caption><h1 style="color: #002b80">Lista de Usuários</h1></caption>
	<tr align="center" bgcolor="white">
	<td width="5%">ID</td>
	<td width="20%">NOME</td>
	<td width="20%">MARCA</td>
	<td width="10%">PREÇO</td>
	<td width="40%">DESCRIÇÂO</td>
	<td width="10%">EDITAR</td>
	<td width="10%">APAGAR</td>
	</tr>
	
	<%
		 HttpSession sessao = request.getSession();
	if(sessao.getAttribute("login") == null){
		response.sendRedirect("http://localhost:8080/MeuSistema2/index.jsp");
	}
	
	if(request.getParameter("id") != null){
		
		int ID = Integer.parseInt(request.getParameter("id"));
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String SQLDelete = "DELETE FROM produtos WHERE id = ?";
			
		try{
			Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
			PreparedStatement pstm = conn2.prepareStatement(SQLDelete);
			
			
			pstm.setInt(1, ID);
			pstm.execute();
			pstm.close();
			conn2.close();
			
		} catch(Exception ex){
			out.println("Erro ao Deletar!");
		}
		} catch(Exception ex){
			out.println("Erro ao carregar driver!");
		}
	}
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		String SQLSelect = "SELECT * FROM produtos";
		
		try{
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
			
			Statement stm = conn.prepareStatement(SQLSelect);
			ResultSet rs = stm.executeQuery(SQLSelect);
			
			while(rs.next()){
				%>
			<tr bgcolor="white">
				<td><% out.println(rs.getInt("id")); %></td>
				<td><% out.println(rs.getString("nome")); %></td>
				<td><% out.println(rs.getString("marca")); %></td>
				<td><% out.println(rs.getDouble("preco")); %></td>
				<td><% out.println(rs.getString("descricao")); %></td>
				<td><a href='http://localhost:8080/MeuSistema2/editarProdutos?id=<%out.println(rs.getInt("id"));%>'>[EDITAR]</a></td>
				<td><a href='http://localhost:8080/MeuSistema2/litarProdutos.jsp?id=<%out.println(rs.getInt("id"));%>'>[APAGAR]</a></td>
			</tr>
				<%
			}
			
			stm.close();
			conn.close();
			
		} catch(Exception ex){
			out.println("Erro na conexão!");
		}
	} catch(Exception ex){
		out.println("Erro no Driver!");
	}
	%>
	</table>
	<td><a href='http://localhost:8080/MeuSistema2/cadastro.jsp'>VOLTAR</a></td>
</body>
</html>