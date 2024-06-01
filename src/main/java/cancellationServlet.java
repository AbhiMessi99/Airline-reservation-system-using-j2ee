

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class cancellationServlet
 */
@WebServlet("/cancellationServlet")
public class cancellationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cancellationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession hs=request.getSession();
		String cancel_id=(String)hs.getAttribute("cancel_id");
		RequestDispatcher rd=null;
		ServletContext sc=getServletContext();
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","leomessi");
			if(con==null)
			{
				out.println("Connection error");
			}
			else
			{
				CallableStatement cs = con.prepareCall("{call cancellation(?)}");
				cs.setString(1, cancel_id);
				int x=cs.executeUpdate();
				if(x>0)
				{
					rd=sc.getRequestDispatcher("/cancelRedirect.html");
				}
				else
				{
					rd=sc.getRequestDispatcher("/ShowFlights.html");
				}
				rd.forward(request, response);
			}
		}
		catch(Exception e)
		{
			out.print(e);
		}
	}

}
