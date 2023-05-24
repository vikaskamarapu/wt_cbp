import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Authenticate4 extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Load the database driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/food", "root", "root");

            // Prepare a SQL statement to retrieve the user with the specified username and
            // password
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM register WHERE username=? AND password=?");
            stmt.setString(1, username);
            stmt.setString(2, password);

            // Execute the SQL statement and retrieve the result set
            ResultSet rs = stmt.executeQuery();

            // If the result set has a row, the user exists and the password is correct
            if (rs.next()) {
                // Authenticate the user and display a welcome message
                HttpSession session = request.getSession(true);
                session.setAttribute("userId", username);
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body><h2>Welcome " + username + "!</h2><br></body></html>");
                response.sendRedirect("catframe4.html");

            } else {
                // Display an error message and allow the user to try again
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body><h2>Invalid username or password</h2></body></html>");
            }
            // Close the database connection
            conn.close();
        } catch (ClassNotFoundException e) {
            // Handle database driver loading errors
            e.printStackTrace();
        } catch (SQLException e) {
            // Handle database connection errors
            e.printStackTrace();
        }
    }
}