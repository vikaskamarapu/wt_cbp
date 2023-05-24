import java.io.*;
import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class register2 extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        String s1 = request.getParameter("username");
        String s2 = request.getParameter("password");
        String s3 = request.getParameter("emailid");
        String s4 = request.getParameter("contact");
        PrintWriter out = response.getWriter();
        out.println("<html><body><script>");
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/food", "root", "root");
            PreparedStatement ps = con.prepareStatement("insert into register values(?,?,?,?)");
            ps.setString(1, s1);
            ps.setString(2, s2);
            ps.setString(3, s3);
            ps.setString(4, s4);
            int res = ps.executeUpdate();
            String mes = "Registration unsuccesful";
            if (res == 1) {
                mes = "Registration Succesful";
                out.println("alert('" + mes + "');");
                response.sendRedirect("login2.html");
            }
            out.println("alert('" + mes + "');</script></body></html>");
        } catch (SQLException e) {
            throw new ServletException("Servlet Could not display records.", e);
        } catch (ClassNotFoundException e) {
            throw new ServletException("JDBC Driver not found.", e);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
            }
        }
        out.close();
    }
}
