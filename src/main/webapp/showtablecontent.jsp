<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Flights</title>
    <link rel="icon" sizes="180x180" href="image/title.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;

        }
        h1 {
            padding: 30px;
            text-align: center;
            background: #34b4eb;
            color: white;
            font-size: 30px;
            border-radius: 10px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
            
            
        }
        th {
            background-color: #B8CD76;
            color: #2B96BB;
            border-radius: 10px;
        }
        button {
            padding: 8px 15px;
            background-color: #3498db;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            
        }
        button:hover {
            background-color: #2980b9;
        }
        .user-icon {
            position: absolute;
            top: 10px;
            right:10px
        }
        .rounded-button {
        background-color: #C1272D;
        color: white;
        padding: 10px 25px;
     	border: none;
    	border-radius: 8px;
    	cursor: pointer;
    	transition: background-color 0.3s, color 0.3s, border-color 0.3s;
		}

		/* Button styles on hover */
		.rounded-button:hover {
   		 background-color: white;
    	 color: #C1272D;
    	border: 1px solid #C1272D;
        }
        body

/* Center the button */
       .button-container {
       text-align: center;
       margin-top: 15px; /* Add some top margin */
       }
       </style>
    <script>
        function sendData(id) {
            document.getElementById('selectedId').value = id;
            document.getElementById('form').submit();
        }
    </script>
</head>
<body background="image/background.jpg" >
    <header style="background-color: #fff; padding: 20px; border-radius: 10px;">
        <div style="display: flex; align-items: center; justify-content: space-between;">
            <div>
                <!-- Logo -->
                <img src="image/Air_Trips1.png" alt="Logo" style="height: 50px; width: auto;">
            </div>
            <div>
                <!-- Username -->
                <span style="font-size: 20px;">Welcome, <%=(String)session.getAttribute("Username") %></span>
                <img src="image/icon.png" alt="Logo" style="height: 25px;">
            </div>
        </div>
    </header>
<h1>AVAILABLE FLIGHTS</h1>

 <%
    String FROM=(request.getParameter("from")).toUpperCase();
	String TO=(request.getParameter("to")).toUpperCase();
	String CLASS=request.getParameter("class");
	if(CLASS.equals("option1"))
		CLASS="ECONOMY";
	if(CLASS.equals("option2"))
		CLASS="PREMIUM_ECONOMY";
	if(CLASS.equals("option3"))
		CLASS="BUSINESS";	
	String DATE=request.getParameter("Date");
	session.setAttribute("yyyy_mm_dd",DATE);
	String month[]={"JAN"};
    String day=DATE.substring(8,10);
    int mon=Integer.parseInt(DATE.substring(5,7));
    String year=DATE.substring(0,4);
    String newdate=month[mon-1]+day+"_"+year;
	session.setAttribute("date",newdate);
	session.setAttribute("cl", CLASS);
	session.setAttribute("faretype",request.getParameter("faretype"));
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
		
		
		PreparedStatement ps = con.prepareStatement("select a.flight_number, a.flight_name, b.departure_time, b.arrival_time, b.journey_time , c.economy from flights a INNER JOIN flighttimetable b  on a.flight_number=b.flight_number inner JOIN flight_fares c on b.flight_number=c.flight_number inner Join "+CLASS+" d on c.flight_number=d.flight_number where a.source=? and a.destination=? and "+newdate+ ">0");
		ps.setString(1, FROM);
		ps.setString(2, TO);
		ResultSet rs=ps.executeQuery();
		ResultSetMetaData rsm=rs.getMetaData();
		int col=rsm.getColumnCount();
		if(rs.next())
		{
			%>
			<table>
			<thead>
			<tr>
			<th>FLIGHT NUMBER</th>
			<th>FLIGHT NAME</th>
			<th>DEPARTURE</th>
			<th>LANDING</th>
			<th>JOURNEY TIME</th>
			<th>FARE</th>
			</tr>
			</thead>
			<%
			do
			{%>
			<tbody>
			<tr>
				<%
				for(int i=1;i<=col;i++)
				{%>
					<td><b><%=rs.getString(i) %></b></td>
				<%}%>
				<td>
				<div class="button-container">
				 <button onclick="sendData('<%=rs.getString(1) %>')" class="rounded-button">BOOK</button>
				</div>
				</td>
			</tr>
			</tbody>
			<%}while(rs.next());
			%>
			</table>
			<form id="form" action="DetailExtract" method="post">
		        <input type="hidden" id="selectedId" name="selectedId">
		        <input type="hidden" id="class" name="class">
		    </form>
			<%
		}else{
			out.println("no flights available");
		}
	
	}

}
catch(Exception e)
{
	out.println(e);
}
%>
</body>
</html>