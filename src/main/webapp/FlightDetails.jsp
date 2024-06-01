<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.Enumeration" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight Details</title>
<link rel="icon" sizes="180x180" href="image/title.png">
<link rel="stylesheet" href="all.css">
<link rel="stylesheet" href="bookedpage.css">

<style>
.glass-container {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
    backdrop-filter: blur(7.1px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    padding: 20px;
}
        form {
            width: 300px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 8px;
            text-align: center;
        }
        input[type="number"] {
            padding: 4px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
         .pricing {
            width: 400px;
            margin-top: 40px;
            margin: auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: left;
        }
        .pricing h2 {
            margin-bottom: 10px;
            color: #333;
        }
        .pricing p {
            color: #666;
        }
        .main > div {
    flex:1;
    text-align: center; /* To center align the content within each div */
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
 
<%
String faretype=(String)session.getAttribute("faretype");
int discount_price=0;
%>
 <div class="pricing" >
 <h2>Pricing Information</h2>
 <p>
<%
if(faretype.equals("Armed Forces Fares"))
{
	String fare=(String)session.getAttribute("Fare");
	discount_price=(int)(0.75*Integer.parseInt((String)session.getAttribute("Fare")));
	%>
	<br>Base Price Per Person:      <del>Rs. <%=fare%></del>
	<br>ArmedForce discounted price:Rs. <%=discount_price %>
	<%
}
if(faretype.equals("Student Fares"))
{
	String fare=(String)session.getAttribute("Fare");
	discount_price=(int)(0.85*Integer.parseInt((String)session.getAttribute("Fare")));
	%>
	<br>Base Price Per Person:      <del>Rs. <%=fare%></del>
	<br>Student discounted price:Rs. <%=discount_price %>
	<%
}
if(faretype.equals("Senior Citizen Fares"))
{
	String fare=(String)session.getAttribute("Fare");
	discount_price=(int)(0.60*Integer.parseInt((String)session.getAttribute("Fare")));
	%>
	<br>Base Price Per Person:      <del>Rs. <%=fare%></del>
	<br>Senior Citizen discounted price:Rs. <%=discount_price %>
	<%
}
if(faretype.equals("Doctor & Nurses Fares"))
{
	String fare=(String)session.getAttribute("Fare");
	discount_price=(int)(0.90*Integer.parseInt((String)session.getAttribute("Fare")));
	%>
	<br>Base Price Per Person:      <del>Rs. <%=fare%></del>
	<br>Doctor & Nurses discounted price:Rs. <%=discount_price %>
	<%
}
if(faretype.equals("Regular Fare"))
{
	String fare=(String)session.getAttribute("Fare");
	discount_price=(int)(Integer.parseInt((String)session.getAttribute("Fare")));
	%>
	<br>Base Price Per Person:Rs. <%=fare%>
	<%
}
%>
<br> Taxes and Surcharges:Rs. <%=1500 %>
<%
   int totalFare=discount_price+1500;
%>
<br><p>Total payable per person:Rs. <%=totalFare %>
</p>
</div>
<% session.setAttribute("pay",totalFare); %>
<br>
    <form  method="post" action="FlightPassengerDetail.jsp" class="glass-container">
        <label for="numPassengers" ></label>
        <p><center><b>Number of Passengers&nbsp&nbsp</b><input type="number" id="numPassengers" name="numPassengers" value="1" min="1" max="9" required></center></p>
        <div class="button-container">
        <input type="submit" value="Submit" class="rounded-button">
        </div>
    </form>
    
</body>
</html>