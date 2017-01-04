

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


@WebServlet("/editarUsuarios2")
public class editarUsuarios2 extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();		
		
		HttpSession sessao = request.getSession();
		if(sessao.getAttribute("login") == null){ //Condição para verificar se um usuario esta acessando a pagina sem ter uma sessao criada
			response.sendRedirect("http://localhost:8080/MeuSistema2/index.jsp");
		}
		
			try{
			Class.forName("com.mysql.jdbc.Driver");
			
			String SQLSelect = "SELECT * FROM usuarios WHERE id = ?";
			
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
				
				int id = Integer.parseInt(request.getParameter("id"));
				PreparedStatement pstm = conn.prepareStatement(SQLSelect);
				pstm.setInt(1, id);
				
				ResultSet rs = pstm.executeQuery();
				
				if(rs.next()){
				out.println("<body bgcolor='#99bbff' align='center'>");
				out.println("<h1 style='color: #003399'>Preencha as informações do Usuario</h1>");
				out.println("<hr/>");
				out.println("<form method='POST'>");
				out.println("<p style='color: #002b80'>");
				out.println("<b>ID:<br> <input type='text' style='width:30px;' readonly='readonly' name='txtId' value='"+ rs.getInt("id")+"'>");
				out.println("<br>");
				out.println("<br>");
				out.println("<b>LOGIN:<br> <input type='text' style='width:500px;' maxlength='200' name='txtLogin' value='"+ rs.getString("login")+"'>");
				out.println("<br>");
				out.println("<br>");
				out.println("SENHA:<br> <input type='text'  style='width:500px;' maxlength='200' name='txtSenha' value='"+ rs.getString("senha")+"'>");
				out.println("<br>");
				out.println("<br>");
				out.println("<input type='submit' value='Atualizar Usuario'>");
				out.println("</form>");
				out.println("<br>");
				out.println("<a href='http://localhost:8080/MeuSistema2/litarProdutos.jsp'><br>LISTAR PRODUTOS</a>");
				out.println("<br>");
				out.println("<a href='http://localhost:8080/MeuSistema2/listarUsuarios.jsp'><br>LISTAR USUÀRIOS</a>");
				out.println("<br>");
				out.println("<br>");
				out.println("<a href='http://localhost:8080/MeuSistema2/index.jsp?msg=SAIR'><br>SAIR</a></p>");
				out.println("<td><a href='http://localhost:8080/MeuSistema2/listarUsuarios.jsp'>VOLTAR</a></td>");
				out.println("</body>");
				} else {
					out.println("parametro nao é valido!");
				}
				
				pstm.close();
				conn.close();
				
			} catch(Exception ex){
				out.println("Erro na Conexão");
			}
				
			} catch(Exception ex){
				out.println("Driver");
			}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
PrintWriter out = response.getWriter();
		
		if(request.getParameter("id") != null){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String SQLUpdate = "UPDATE usuarios SET login = ?, senha = ? WHERE id = ?";
			
			int ID = Integer.parseInt(request.getParameter("id"));
			String login = request.getParameter("txtLogin");
			String senha = request.getParameter("txtSenha");
			
			try{
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/meusistema", "root", "");
				PreparedStatement pstm = conn.prepareStatement(SQLUpdate);

				pstm.setString(1, login);
				pstm.setString(2, senha);
				pstm.setInt(3, ID);
				
				pstm.execute();
				pstm.close();
				conn.close();
				
				response.sendRedirect("http://localhost:8080/MeuSistema2/listarUsuarios.jsp");
				out.println("<h1>Editado com Sucesso!</h1>");
			} catch (Exception ex) {
				ex.getMessage();
			} 
		} catch (Exception ex) {
			out.println("Erro ao carregar Driver de conexão" + ex.getMessage());
		} 
	}
	}
}