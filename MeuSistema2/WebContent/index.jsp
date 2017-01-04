<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Meu Sistema</title>

 </head>
	 <body bgcolor="#99bbff" align="center">
	
	 <style type="text/css">
		input[type=submit]{
        	background:#006699;
        	color:#ffffff;
        	border-radius:10px;
        	width:200px;
        	height:30px }
        	 
        input[type=text]{     
		    border-radius:4px;
		    -moz-border-radius:4px;
		    -webkit-border-radius:4px;
		    box-shadow: 1px 1px 2px #333333;    
		    -moz-box-shadow: 1px 1px 2px #333333;
		    -webkit-box-shadow: 1px 1px 2px #333333;
		    background: #cccccc; 
		    border:1px solid #000000;
		    width:200px
		}		
		input[type=password]{     
		    border-radius:4px;
		    -moz-border-radius:4px;
		    -webkit-border-radius:4px;
		    box-shadow: 1px 1px 2px #333333;    
		    -moz-box-shadow: 1px 1px 2px #333333;
		    -webkit-box-shadow: 1px 1px 2px #333333;
		    background: #cccccc; 
		    border:1px solid #000000;
		    width:200px
		}
		</style>

	<h1 style="color: #003399">Sistema de Cadastro de Produtos</h1>
	 <hr style="height:3px; border:none; color:#000; background-color:#000; margin-top: 0px; margin-bottom: 0px;">
	<%
		if(request.getParameter("msg") != null){
			if(request.getParameter("msg").equals("SAIR")){
				HttpSession sessao = request.getSession();
				sessao.invalidate();
				out.println("<span style='color: red'>Deslogado com Sucesso!</span>");
			}
		}
	
	
		String login = request.getParameter("txtLogin");
		String senha = request.getParameter("txtSenha");
		
		
		if(request.getParameter("txtLogin") != null || request.getParameter("txtSenha") != null){
			
			try{
				Class.forName("com.mysql.jdbc.Driver");
				String SQL = "SELECT * FROM usuarios WHERE login = ? AND senha = ?";
				
				try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
				
				PreparedStatement pstm = conn.prepareStatement(SQL);
				pstm.setString(1, login);
				pstm.setString(2, senha);
				
				ResultSet rs = pstm.executeQuery();   //Quando da Select
				//pstm.execute(); quando inclui
				
				if(rs.next()){
					HttpSession sessao = request.getSession();
					sessao.setAttribute("login", login);
					response.sendRedirect("http://localhost:8080/MeuSistema2/cadastro.jsp");
					
					
					
					pstm.close();
					conn.close();
					
				} else {
					out.println("<h2 style='color: #e60000'>Seu Login ou Senha não estão registrados</h2>");	
					pstm.close();
					conn.close();
					
					}
				} catch (Exception ex){
					out.println("Problema ao se conectar com Banco de Dados");
				}
				
			} catch (Exception ex){
				out.println("Problema conexão com o driver");
				
			}
		}
	%>

	
	<!--  Logar usuario -->
	<form method="POST">
		<p style="color: #002b80"><b>LOGIN:</b><br><input type="text" name="txtLogin"><br><br><b>SENHA:</b><br><input type="password" name="txtSenha"></p>
		<br>
		<br>	
		<input type="submit" value="Logar">
	</form>
	<br>
	 <hr style="height:6px; border:none; color:#000; background-color:#000; margin-top: 0px; margin-bottom: 0px;">
	<br><br> 
	
	<%
  	
	if(request.getParameter("txtLogin2") != null){
			out.println("OK!");
		
		
 	String login2 = request.getParameter("txtLogin2");
 	String senha2 = request.getParameter("txtSenha2");
 	
 	try{
 	Class.forName("com.mysql.jdbc.Driver");
 	String Logar = "INSERT INTO usuarios (login, senha) VALUES (?, ?)";
 	
 	try{
 	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
 	
 	PreparedStatement pstm = conn.prepareStatement(Logar);
 	
 	pstm.setString(1, login2);
 	pstm.setString(2, senha2);
 	
 	pstm.execute();
 	pstm.close();
 	conn.close();

	response.sendRedirect("http://localhost:8080/MeuSistema2/index.jsp");
 	
 	} catch (SQLException ex){
 		out.println("Problema ao conectar com Banco de Dados" + ex.getMessage());
 	}
 	}catch (ClassNotFoundException ex){
 		out.println("Erro ao Carregar Driver de Conexão" + ex.getMessage());
 	}
	}
	%>
	
	
	<!--  Cadastrar novo Cliente -->
	<form method="POST" action="index.jsp">
	<h2>Cadastrar Novo Cliente</h2>
		<p style="color: #002b80"><b>LOGIN:</b><br><input type="text" name="txtLogin2"><br><br><b>SENHA:</b><br><input type="password" name="txtSenha2"></p>
		<br>
		 <br>
		<input type="submit" value="Cadastrar Usuário">
	</form>
	<br>
	 <hr style="height:3px; border:none; color:#000; background-color:#000; margin-top: 0px; margin-bottom: 0px;">    
</body>
</html>