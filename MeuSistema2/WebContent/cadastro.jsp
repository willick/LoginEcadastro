<%@page import="java.util.Locale"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastrar Produto</title>
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
		<%
		
		
		HttpSession sessao = request.getSession();
		if(sessao.getAttribute("login") == null){ //Condição para verificar se um usuario esta acessando a pagina sem ter uma sessao criada
			response.sendRedirect("http://localhost:8080/MeuSistema2/index.jsp");
		}
		
		String nome = request.getParameter("txtNome");
		String marca = request.getParameter("txtMarca");
		String preco1 = request.getParameter("txtPreco");
		String descricao = request.getParameter("txtDescricao");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String SQLInsert = "INSERT INTO produtos (nome, marca, preco, descricao) VALUES (?, ?, ?, ?)";
			
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
				PreparedStatement pstm = conn.prepareStatement(SQLInsert);
	
				//NumberFormat numberFormat = new DecimalFormat("###,##0.00");

				//String preco = numberFormat.format(12345.67);
				
				
				double preco2 = Double.parseDouble(preco1);
				
				//NumberFormat f = NumberFormat.getCurrencyInstance(Locale.KOREA);
				//out.println(f.format(preco4));
				
				pstm.setString(1, nome);
				pstm.setString(2, marca);
				pstm.setDouble(3, preco2);
				pstm.setString(4, descricao);
				pstm.execute();
				pstm.close();
				conn.close();
				
				response.sendRedirect("http://localhost:8080/MeuSistema2/cadastro.jsp");
			} catch (Exception ex) {
				ex.getMessage();
			} 
		} catch (Exception ex) {
			out.println("Erro ao carregar Driver de conexão" + ex.getMessage());
		}
		%>
		<h1 style="color: #003399">Preencha as informações do Produto</h1>
		<hr/>
		<form method='POST'>
		<p style="color: #002b80"><b>NOME:<br> <input type='text' style='width:500px;' maxlength='200' name='txtNome'>
		<br>
		<br>
		MARCA:<br> <input type='text'  style='width:500px;' maxlength='200' name='txtMarca'>
		<br>
		<br>
		PREÇO:<br> <input type='text' style='width:100px;' maxlength='20' name='txtPreco'>
		<br>
		<br>
		DESCRIÇÂO:<br> <textarea name='txtDescricao' rows='20' cols='100'></textarea>
		<br>
		<br>
		<input type='submit' value='Cadastrar Produto'>
		</form>
		<br>
		<a href='http://localhost:8080/MeuSistema2/litarProdutos.jsp'><br>LISTAR PRODUTOS</a>
		<br>
		<a href='http://localhost:8080/MeuSistema2/listarUsuarios.jsp'><br>LISTAR USUÀRIOS</a>
		<br>
		<br>
		<a href='http://localhost:8080/MeuSistema2/index.jsp?msg=SAIR'><br>SAIR</a></p>
</body>
</html>