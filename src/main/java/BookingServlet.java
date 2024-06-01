

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		int passengerNum=(Integer)session.getAttribute("pass_num");
		ServletContext sc=getServletContext();
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
				String uid=(String)session.getAttribute("Username");
				int passnum=(Integer)session.getAttribute("pass_num");
				String f_num=(String)session.getAttribute("flightNumber");
				String f_name=(String)session.getAttribute("flightName");
				String dest=(String)session.getAttribute("destination");
				String src=(String)session.getAttribute("source");
				String cls=(String)session.getAttribute("cl");
				String btime=(String)session.getAttribute("departure");
				String orDate=(String)session.getAttribute("yyyy_mm_dd");
				String newDate=(String)session.getAttribute("date");
				String payMethod=request.getParameter("paymentMethod");
				String faretype=(String)session.getAttribute("faretype");
				int amount=(Integer)session.getAttribute("paid");
				CallableStatement cs=con.prepareCall("{call BookFlight(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.registerOutParameter(1, Types.VARCHAR);
				cs.setString(2, uid);
				cs.setDouble(3, passnum);
				cs.setString(4, f_num);
				cs.setString(5, f_name);
				cs.setString(6, dest);
				cs.setString(7, src);
				cs.setString(8, cls);
				cs.setString(9, btime);
				cs.setString(10, orDate);
				cs.setString(11, newDate);
				cs.setDouble(12, amount);
				cs.setString(13, payMethod);
				cs.setString(14, faretype);
				int x=cs.executeUpdate();
				cs.setString(9, f_num);
				session.setAttribute("book_id", cs.getString(1));
				for(int i=1;i<=passengerNum;i++)
				{
					String passengerName=(String)session.getAttribute("name_"+i);
					String passengerAge=(String)session.getAttribute("age_"+i);
					String gender=(String)session.getAttribute("gender_"+i);
					PreparedStatement ps = con.prepareStatement("insert into flightpassengerdetails values(?,?,?,?)");
					ps.setString(1, (String)cs.getString(1));
					ps.setString(2, passengerName);
					ps.setString(3, passengerAge);
					ps.setString(4, gender);
					int x1=ps.executeUpdate();
				}
				RequestDispatcher rd= sc.getRequestDispatcher("/redirect.html");
				rd.forward(request, response);
			}
		}
		catch(Exception e) {out.print(e);}
	}

}
