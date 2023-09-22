package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import models.ConnectionBd;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/SupprimerContacts")
public class SupprimerContacts extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConnectionBd bd;

    public SupprimerContacts() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_user = request.getParameter("id_user");
        Connection con;
		try {
			con = ConnectionBd.getConnection();
            String query = "DELETE FROM contacts WHERE id_user=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, id_user);
            int rowsAffected = pstmt.executeUpdate();
            response.sendRedirect("AjouterContact");

        } catch (SQLException ex) {
            ex.printStackTrace();
            // Handle the exception and redirect to an error page
            response.sendRedirect("error.jsp");
        }
	    
    }
}
