package com.techquiz.servlets;

import com.techquiz.entities.Message;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Remove current user
        HttpSession httpSession = request.getSession();
        httpSession.removeAttribute("currentUser");

        //redirecting to login page
        Message msg = new Message("Logout Successfully..!", "success", "alert-success");
        httpSession.setAttribute("msg", msg);
        response.sendRedirect("login.jsp");
    }
}
