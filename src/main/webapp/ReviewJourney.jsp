<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Journey</title>
<link rel="icon" sizes="180x180" href="image/title.png">
<link rel="stylesheet" href="all.css">
<link rel="stylesheet" href="bookedpage.css">
<style>
.pricing p {
            color: #666;
            text-align:center;
        }
.pricing {
            width: 400px;
            margin-top: 40px;
            border-radius: 16px;
            padding: auto;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(7.1px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 20px;
            text-align: center;
          }
.spanclass{
			font-size:14.0pt;
			color:green;
   
}
h4{
       font-size:30px;
       font-weight: bold;
       font-family: Georgia, serif;
        color: #C1272D;
}
           
</style>
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
    <h1>REVIEW JOURNEY</h1>
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
<div class="pricing" >
<h4>Passengers Details</h4>
<%
int passengerNum=(Integer)session.getAttribute("pass_num");
for(int i=1;i<=passengerNum;i++)
{
	String passengerName=request.getParameter("name_"+i);
	String passengerAge=request.getParameter("age_"+i);
	String gender=request.getParameter("gender_"+i);
%>
    <h3><%=i+". "+passengerName+" "+passengerAge+" "+gender%></h3>
    
    
<% 
session.setAttribute("name_"+i, passengerName);
session.setAttribute("age_"+i, passengerAge);
session.setAttribute("gender_"+i, gender);
}
int payable=(Integer)session.getAttribute("pay");
payable=payable*passengerNum;
session.setAttribute("paid",payable);
%>

<br>
<form method="post" action="paymentMethod.html">
  <p><%=(String)session.getAttribute("cl")%>( <%=(String)session.getAttribute("faretype") %>)</p>
  <p>Total Payable: <%="Rs "+payable%></p>
  <div class="button-container" >
  <input type="submit" value="Pay" class="rounded-button">
  </div>
</form>
</div>
</body>
</html>