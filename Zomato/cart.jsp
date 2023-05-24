<html>
  <head>
    <title>Cart</title>
    <style>
      table {
        border-collapse: collapse;
        margin-top: 10px;
        background-image: url("https://t3.ftcdn.net/jpg/01/09/28/48/360_F_109284813_ygrDS98PXPinBd9gq9xcHjkd0fnhw7Sl.jpg");
        background-repeat: no-repeat;
        background-size: cover;
      }

      button {
        margin: 50px;
        margin-bottom: 100px;
      }
      body {
        background-image: url("https://i.pinimg.com/736x/f1/c3/ed/f1c3ed5cc23753056349b4b98f45cf91.jpg");
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
      }
      a{
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <%@ page import="java.sql.*" %> 
    <% 
    String bt=(String)session.getAttribute("userId"); 
    if(bt==null){ %>
    <h1 style="color: red; text-align: center">Login to view Cart</h1>
    <% 
    } else{ 
    String query="select pname,pprice,quantity from product p inner join (select * from cart where uid=?)c on c.pid=p.pid";
    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/food","root","root");
    PreparedStatement pst=conn.prepareStatement(query);
    pst.setString(1,bt);
    ResultSet rs=pst.executeQuery(); 
    if(rs.next()){ %>
    <table width="100%" border="3" align="center" id="cartt">
      <tr>
        <th>PRODUCT NAME</th>
        <th>PRICE(for 250g)</th>
        <th>QUANTITY</th>
        <th>AMOUNT</th>
      </tr>
      <% do{ String n=rs.getObject(1).toString(); String
      p=rs.getObject(2).toString(); String q=rs.getObject(3).toString(); %>
      <tr>
        <td><%=n%></td>
        <td id="name"><%=p%></td>
        <td id="price"><%=q%></td>
        <td></td>
      </tr>
      <% } while(rs.next());%>
      <tr>
        <td colspan="2">Total amount</td>
        <td id="total" colspan="2"></td>
      </tr>
    </table>
    <br />

    <button onclick="myFunction()">AMOUNT</button>
    <button onclick="calc()">TOTAL AMOUNT</button>
    <button>
      <a href="http://localhost:8080/TEAM-11Myapp/order.jsp" target="body"
        >Place Order</a>
    </button>
    <br />
    <br />

    <script>
      function myFunction() {
        var x = document.getElementById("cartt").rows.length;
        let tamount = 0;
        for (let i = 1; i <= x - 1; i++) {
          pr = document.getElementById("cartt").rows[i].cells[1].innerHTML;
          qu = document.getElementById("cartt").rows[i].cells[2].innerHTML;
          document.getElementById("cartt").rows[i].cells[3].innerHTML = pr * qu;
        }
      }

      function calc() {
        let amt = 0;
        var x = document.getElementById("cartt").rows.length;
        for (let i = 1; i < x - 1; i++) {
          amt += parseInt(
            document.getElementById("cartt").rows[i].cells[3].innerHTML
          );
        }
        var y = document.getElementById("cartt").rows[x - 1].cells;
        y[1].innerHTML = amt;
      }
    </script>

    <% }else{ bt = (String) session.getAttribute("userId");%>
    <center>
      <h1 style="color: red; text-align: center">Cart is Empty</h1>
    </center>
    <% } } %>
  </body>
</html>
