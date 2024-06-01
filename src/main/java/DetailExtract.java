

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DetailExtract
 */
@WebServlet("/DetailExtract")
public class DetailExtract extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailExtract() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		response.setContentType("Text/html");
		String selectedId = request.getParameter("selectedId");
		RequestDispatcher rd=null;
		ServletContext sc=getServletContext();
		HttpSession hs=request.getSession(true);
        try
        {
        	Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","leomessi");
			if(con==null)
			{
				out.println("Connection not built");
			}
			else
			{
				PreparedStatement ps = con.prepareStatement("SELECT * FROM FLIGHTS WHERE FLIGHT_NUMBER=?");
				PreparedStatement ps1 = con.prepareStatement("SELECT * FROM FLIGHTTIMETABLE WHERE FLIGHT_NUMBER=?");
				PreparedStatement ps2 = con.prepareStatement("SELECT * FROM FLIGHT_FARES WHERE FLIGHT_NUMBER=?");
				ps.setString(1, selectedId);
				ps1.setString(1, selectedId);
				ps2.setString(1, selectedId);
				ResultSet rs=ps.executeQuery();
				ResultSet rs1=ps1.executeQuery();
				ResultSet rs2=ps2.executeQuery();
				if(rs.next())
				{
					hs.setAttribute("flightNumber", selectedId);					
					hs.setAttribute("flightName", rs.getString(2));
					hs.setAttribute("source", rs.getString(3));
					hs.setAttribute("destination", rs.getString(4));
				}
				if(rs1.next())
				{
					hs.setAttribute("arrival", rs1.getString(3));
					hs.setAttribute("departure", rs1.getString(2));
					hs.setAttribute("jTime", rs1.getString(4));
				}
				if(rs2.next()) 
				{
					hs.setAttribute("Fare", rs2.getString((String)hs.getAttribute("cl")));
				}
				rd=sc.getRequestDispatcher("/FlightDetails.jsp");
				rd.forward(request, response);
			}
        }
        catch(Exception e){	
        }
	}
}