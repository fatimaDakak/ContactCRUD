package servlets;

import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import models.Contact;
import models.ConnectionBd;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet implementation class AjouterContact
 */
public class AjouterContact extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(AjouterContact.class.getName());

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjouterContact() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = ConnectionBd.getConnection();

            if (con != null) {
                String sql = "SELECT * FROM contacts";
                PreparedStatement pstmt = con.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();
                ArrayList<Contact> contacts = new ArrayList<>();

                while (rs.next()) {
                    Contact contact = new Contact();
                    contact.setId(rs.getInt("id_user"));
                    contact.setNom(rs.getString("nom"));
                    contact.setPrenom(rs.getString("prenom"));
                    contact.setAdresse(rs.getString("adresse"));
                    contact.setTel(rs.getInt("tel"));
                    contact.setEmail(rs.getString("email"));
                    contacts.add(contact);
                }

                rs.close();
                pstmt.close();

                request.setAttribute("contacts", contacts);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/AjouterContacts.jsp");
                dispatcher.forward(request, response);
            } else {
                response.getWriter().write("Database connection is null. Check your connection setup.");
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "SQL Exception", ex);
            throw new ServletException(ex);
        }
    }

    
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 Connection con = null;
		try {
			con = ConnectionBd.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 String nom = request.getParameter("nom");
	    String prenom = request.getParameter("prenom");
	    String email = request.getParameter("email");
	    String tel = request.getParameter("tel");
	    String adresse = request.getParameter("adresse");

	    try {
	        String stm = "INSERT INTO contacts (nom, prenom, email, tel, adresse) " +
	                     "VALUES (?, ?, ?, ?, ?)";
	        PreparedStatement ps = con.prepareStatement(stm);
	        ps.setString(1, nom);
	        ps.setString(2, prenom);
	        ps.setString(3, email);
	        ps.setString(4, tel);
	        ps.setString(5, adresse);
	        int rowsAffected = ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    response.sendRedirect("AjouterContact");

	}
}

