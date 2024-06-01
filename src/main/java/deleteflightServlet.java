

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Types;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class deleteflightServlet
 */
@WebServlet("/deleteflightServlet")
public class deleteflightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteflightServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out= response.getWriter();
		String fno=request.getParameter("selectedId");
		out.print(fno);
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","leomessi");
			if(con==null)
			{
				out.print("Connection not established");
			}
			else
			{
				CallableStatement cs = con.prepareCall("{call deleteFlight(?)}");
				cs.setString(1, fno);
				int x=cs.executeUpdate();
				if(x>0)
				{
					RequestDispatcher rd=getServletContext().getRequestDispatcher("/flightdeleted.html");
					rd.forward(request, response);
				}
				else
				{
					out.print("Flight no added");
				}
			}
		}
		catch(Exception e) {
			
		}
	}

}
