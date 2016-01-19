package com.pure.quantWeb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pureblue.quant.dao.IOHLCPoint;
import com.pureblue.quant.dao.OHLCPointDao;
import com.pureblue.quant.dao.StockDatebaseFactory;
/**
 * Servlet implementation class SingleStock
 */
@WebServlet("/SingleStock")
public class SingleStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SingleStock() {
        super();
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet entries!!!");
		String stockId = request.getParameter("symbol");
		String dataJson = "[[]]";
		String data = "";
		Connection connection = StockDatebaseFactory.getInstance("test");
		OHLCPointDao ohlcPointDao = new OHLCPointDao(connection);
		System.out.println("doGet connect db!!!");
		try {
			LinkedList<IOHLCPoint> quotes = (LinkedList<IOHLCPoint>) ohlcPointDao.find(stockId);
			data = "[" + quotes.get(0).getAdjClose().toString() + ", " + quotes.get(0).getIndex().getTime() + "]";
			for(int i=1; i<quotes.size(); i++)
			{
				data = data + ", [" + quotes.get(i).getAdjClose().toString() + ", " + quotes.get(i).getIndex().getTime() + "]";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("doGet leave db!!!");
		dataJson = "[" + data + "]";
		request.setAttribute("stockId", stockId);
		request.setAttribute("stockQuote", dataJson);
		request.getRequestDispatcher("/View/singleStockQuote.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
