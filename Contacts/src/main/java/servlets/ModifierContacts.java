package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ConnectionBd;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ModifierContacts")
public class ModifierContacts extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConnectionBd bd;

    public ModifierContacts() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/views/ModifierContacts.jsp");
        view.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con;
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        int tel = Integer.parseInt(request.getParameter("tel")); // Parse tel as an int
        String adresse = request.getParameter("adresse");
        int id_user = Integer.parseInt(request.getParameter("id_user")); 

        try {
			con = ConnectionBd.getConnection();
            String query = "UPDATE contacts SET nom=?, prenom=?, email=?, tel=?, adresse=? WHERE id_user=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, nom);
            pstmt.setString(2, prenom);
            pstmt.setString(3, email);
            pstmt.setInt(4, tel);
            pstmt.setString(5, adresse);
            pstmt.setInt(6, id_user);

            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect("AjouterContact");
            } else {
                // Handle the case where no rows were updated
                response.sendRedirect("error.jsp"); // Redirect to an error page
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            // Handle the exception and redirect to an error page
            response.sendRedirect("error.jsp");
        }
    }
}
