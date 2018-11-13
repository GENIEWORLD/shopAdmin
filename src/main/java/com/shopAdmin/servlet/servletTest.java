package com.shopAdmin.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class servletTest
 */
public class servletTest extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletTest() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try        
        {
            Thread.sleep(0);
            
            // TODO Auto-generated method stub
            response.setContentType("text/html;charset=euc-kr");
            PrintWriter printWriter = response.getWriter();

            int randomNum = (int)(Math.random() * 100) + 1;
            
            String randomHtml = "<html><head></head><body><div><input type=\"text\" id=\"randomNum\" value="+ randomNum + "></div></body></html>";
            
            System.out.println("randomNum : " + randomNum);
            printWriter.print(randomHtml);
            printWriter.close();
        } 
        catch(InterruptedException ex) 
        {
            Thread.currentThread().interrupt();
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
