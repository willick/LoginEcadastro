

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/editarProdutos")
public class editarProdutos extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessao = request.getSession();
		if(sessao.getAttribute("login") == null){
			response.sendRedirect("http://localhost:8080/MeuSistema2/index.jsp");
		}
		
		PrintWriter out = response.getWriter();

			try{
				Class.forName("com.mysql.jdbc.Driver");
				String SQLSelect = "SELECT * FROM produtos WHERE id = ?";
				
				try{
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
					PreparedStatement pstm = conn.prepareStatement(SQLSelect);
					
					int ID = Integer.parseInt(request.getParameter("id"));
					
					pstm.setInt(1, ID);
					ResultSet rs = pstm.executeQuery();
					
		if(rs.next()){
		out.println("<body bgcolor='#99bbff' align='center'>");
		out.println("<h1 style='color: #003399'>Preencha as informações do Produto</h1>");
		out.println("<hr/>");
		out.println("<form method='POST'>");
		out.println("<p style='color: #002b80'><b>ID:<br> <input type='text' style='width:30px;' readonly='readonly' nome='ID' value='"+rs.getInt("id")+"'>");
		out.println("<br>");
		out.println("<br>");
		out.println("NOME:<br> <input type='text' style='width:500px;' maxlength='200' name='txtNome' value='"+rs.getString("nome")+"'>");
		out.println("<br>");
		out.println("<br>");
		out.println("MARCA:<br> <input type='text'  style='width:500px;' maxlength='200' name='txtMarca' value='"+rs.getString("marca")+"'>");
		out.println("<br>");
		out.println("<br>");
		out.println("PREÇO:<br> <input type='text' style='width:100px;' maxlength='20' name='txtPreco' value='"+rs.getDouble("preco")+"'>");
		out.println("<br>");
		out.println("<br>");
		out.println("DESCRIÇÂO:<br> <textarea name='txtDescricao' rows='20' cols='100'>"+rs.getString("descricao")+"</textarea>");
		out.println("<br>");
		out.println("<br>");
		out.println("<input type='submit' value='Atualizar Produto'>");
		out.println("</form>");
		out.println("<br>");
		out.println("<a href='http://localhost:8080/MeuSistema2/litarProdutos.jsp'><br>LISTAR PRODUTOS</a>");
		out.println("<br>");
		out.println("<a href='http://localhost:8080/MeuSistema2/listarUsuarios.jsp'><br>LISTAR USUÀRIOS</a>");
		out.println("<br>");
		out.println("<br>");
		out.println("<a href='http://localhost:8080/MeuSistema2/index.jsp?msg=SAIR'><br>SAIR</a></p>");
		out.println("<td><a href='http://localhost:8080/MeuSistema2/litarProdutos.jsp'>VOLTAR</a></td>");
		out.println("</body>");
		} else {
			out.println("Parametro não encontrado!");
		}
				pstm.close();
				conn.close();
				
				} catch(Exception ex){
					out.println("Erro Conexão!" + ex.getMessage());
				}
			} catch(Exception ex){
				out.println("Erro Driver!" + ex.getMessage());
			}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		if(request.getParameter("id") != null){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String SQLUpdate = "UPDATE produtos SET nome = ?, marca = ?, preco = ?, descricao = ? WHERE id = ?";
			
			String nome = request.getParameter("txtNome");
			String marca = request.getParameter("txtMarca");
			double preco = Double.parseDouble(request.getParameter("txtPreco"));
			String descricao = request.getParameter("txtDescricao");
			int ID = Integer.parseInt(request.getParameter("id"));
			
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
				PreparedStatement pstm = conn.prepareStatement(SQLUpdate);
				
				pstm.setString(1, nome);
				pstm.setString(2, marca);
				pstm.setDouble(3, preco);
				pstm.setString(4, descricao);
				pstm.setInt(5, ID);
				pstm.execute();
				
				pstm.close();
				conn.close();
				response.sendRedirect("http://localhost:8080/MeuSistema2/litarProdutos.jsp");
				
				out.println("<h1>Atualizado com Sucesso!</h1>");
				
			} catch(Exception ex){
				out.println("erro na conexão"
						+ "");
			}
		} catch(Exception ex){
			out.println("erro no drive");
		}
	
		}
	}

}
