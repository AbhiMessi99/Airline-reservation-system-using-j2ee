

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
 * Servlet implementation class AddFlightServlet
 */
@WebServlet("/AddFlightServlet")
public class AddFlightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFlightServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		ServletContext sc=getServletContext();
		RequestDispatcher rd=null;
		String fno=request.getParameter("flightcode")+request.getParameter("serial");
		String fname=request.getParameter("flightname");
		String source=request.getParameter("Source");
		String destination=request.getParameter("destination");
		
		String departure=request.getParameter("departure");
		String landing=request.getParameter("arrival");
		String jtime=request.getParameter("time");
		
		String eco=request.getParameter("economy");
		String premeco=request.getParameter("premeco");
		String bus=request.getParameter("business");
		
		
		String ecoSeats=request.getParameter("ecoseat");
		String premecoSeats=request.getParameter("premecoseat");
		String busSeat=request.getParameter("busiseat");
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","leomessi");
			if(con==null)
			{
				out.println("Connection not established");
			}	
			else
			{
				
				PreparedStatement ps=con.prepareStatement("SELECT * FROM FLIGHTS where FLIGHT_NUMBER=?");
				ps.setString(1, fno.toUpperCase());
				ResultSet rs=ps.executeQuery();
				if(rs.next())
				{
					rd=sc.getRequestDispatcher("/cannotaddflight.html");
					rd.forward(request, response);
				}
				else
				{
					ps=con.prepareStatement("INSERT INTO flights VALUES(?,?,?,?)");
					ps.setString(1, fno.toUpperCase());
					ps.setString(2, fname);
					ps.setString(3, source.toUpperCase());
					ps.setString(4, destination.toUpperCase());
					int x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO flighttimetable VALUES(?,?,?,?)");
					ps.setString(1, fno.toUpperCase());
					ps.setString(2, departure);
					ps.setString(3, landing);
					ps.setString(4, jtime);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO flight_fares VALUES(?,?,?,?)");
					ps.setString(1, fno.toUpperCase());
					ps.setString(2, eco);
					ps.setString(3, bus);
					ps.setString(4, premeco);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO economy VALUES(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, fno.toUpperCase());
					ps.setString(2, ecoSeats);
					ps.setString(3, ecoSeats);
					ps.setString(4, ecoSeats);
					ps.setString(5, ecoSeats);
					ps.setString(6, ecoSeats);
					ps.setString(7, ecoSeats);
					ps.setString(8, ecoSeats);
					ps.setString(9, ecoSeats);
					ps.setString(10, ecoSeats);
					ps.setString(11, ecoSeats);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO business VALUES(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, fno.toUpperCase());
					ps.setString(2, busSeat);
					ps.setString(3, busSeat);
					ps.setString(4, busSeat);
					ps.setString(5, busSeat);
					ps.setString(6, busSeat);
					ps.setString(7, busSeat);
					ps.setString(8, busSeat);
					ps.setString(9, busSeat);
					ps.setString(10, busSeat);
					ps.setString(11, busSeat);
					x=ps.executeUpdate();
					
					ps=con.prepareStatement("INSERT INTO premium_economy VALUES(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, fno.toUpperCase());
					ps.setString(2, premecoSeats);
					ps.setString(3, premecoSeats);
					ps.setString(4, premecoSeats);
					ps.setString(5, premecoSeats);
					ps.setString(6, premecoSeats);
					ps.setString(7, premecoSeats);
					ps.setString(8, premecoSeats);
					ps.setString(9, premecoSeats);
					ps.setString(10, premecoSeats);
					ps.setString(11, premecoSeats);
					
					x=ps.executeUpdate();
					rd=sc.getRequestDispatcher("/added.html");
					rd.forward(request, response);
				}
			}
		}
		catch(Exception e) {out.println(e);}
	}

}
