<html>
<body>
<%@ page import="java.sql.*" %>
<%
String uid=(String)session.getAttribute("userId");
String query="delete from cart where uid=?";
Class.forName("com.mysql.jdbc.Driver");
Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/food","root","root");
PreparedStatement pst=conn.prepareStatement(query);
pst.setString(1,uid);
pst.executeUpdate();
%>
<h4>Order placed Successfully</h4>
</body>
</html>