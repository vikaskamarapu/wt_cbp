<html>
<body>
<%@ page import="java.sql.*" %>
<%
String uid=(String)session.getAttribute("userId");
String pid= request.getParameter("pid");
String query="insert into cart values(?,?,?)";
Class.forName("com.mysql.jdbc.Driver");
Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/food","root","root");
PreparedStatement pst=conn.prepareStatement(query);
pst.setString(1,uid);
pst.setString(2,pid);
pst.setInt(3,1);
pst.executeUpdate();
%>
</body>
</html>