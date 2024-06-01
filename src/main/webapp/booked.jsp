<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booked Successfully</title>
<link rel="icon" sizes="180x180" href="image/title.png">
<link rel="stylesheet" href="all.css">
<link rel="stylesheet" href="bookedpage.css">

</head>
<body background="image/background.jpg">

<div class= download>
    <div class=booked>
    <p>Your Ticket is Booked.....</p>
    </div>
    <div class=print>
    <div class="button-container">
    <button onclick="window.print()" class="rounded-button">Print</button> 
    </div>
    </div>
</div>

<div class= main>
    <div class=flightnameid>
    <%
    String FlightName=(String)session.getAttribute("flightName");
    String src="logo/"+FlightName.toLowerCase()+".png";
    %>
    <div class="flightlogo"><img src=<%=src%> alt="Logo" style="height: 50px; width: auto;"></div>
    <div class="flights"><%=(String)session.getAttribute("flightNumber")%>-<%=(String)session.getAttribute("flightName")%></div>
    </div>
    <div class=tofrom>
    <%=(String)session.getAttribute("source")%>&#8594<%=(String)session.getAttribute("destination")%>
    <br>
    <%=(String)session.getAttribute("departure")%> --<span class="spanclass"><%=(String)session.getAttribute("jTime")%></span>--><%=(String)session.getAttribute("arrival")%>
    </div>
    <div class=date>
    <%=(String)session.getAttribute("yyyy_mm_dd") %> 
    </div>
</div>
    
<div class= main style="margin-bottom:50px">
    <div class=flightnameid>
    <%=(String)session.getAttribute("cl")%>
    </div>
    <div class=tofrom>
    Book id: <%=(String)session.getAttribute("book_id")%>
    <br>
    </div>
    <div class=date>
    Fare Quota: <%=(String)session.getAttribute("faretype")%> 
    </div>
</div>
<%
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","leomessi");
	if(con==null)
	{
%>
Connection not created...
<%}
	else
	{
		
		
		PreparedStatement ps = con.prepareStatement("SELECT * FROM FLIGHTPASSENGERDETAILS WHERE BOOK_ID=?");
		ps.setString(1, (String)session.getAttribute("book_id"));
		ResultSet rs=ps.executeQuery();
		ResultSetMetaData rsm=rs.getMetaData();
		int col=rsm.getColumnCount();
		if(rs.next())
		{
			%>
			<table border=9>
			<%
			for(int i=2;i<=col;i++)
			{%>
				<th><%=rsm.getColumnName(i)%></th>
			<%}%>
			<%
			do
			{%>
			<tr>
				<%
				for(int i=2;i<=col;i++)
				{%>
					<td><b><%=rs.getString(i) %></b></td>
				<%}%>
			</tr>
			<%}while(rs.next());
			%>
			</table>
			<%
		}
	}

}
catch(Exception e)
{
	out.println(e);
}
%>
<br>


<div class= buttons>
    <div class=button1>
        <form class = "buttonone" action="ShowFlights.jsp" method="post">
        <div class="button-container">
	    <input type="submit" value="Home" class="rounded-button">
	    </div>
        </form>
    </div>
    <div class=button2>
    <form class = "buttontow" action="AccountSignIn.html" method="post">
	<div class="button-container">
                <input type="submit" value="Sign out" class="rounded-button">
    </div>
    </form>
    </div>
</div>
</body>
</html>