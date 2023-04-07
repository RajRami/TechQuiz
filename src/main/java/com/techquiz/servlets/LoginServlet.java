package com.techquiz.servlets;

import com.techquiz.entities.Message;
import com.techquiz.entities.User;
import com.techquiz.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = null;
        try {

            //Fetch email and password
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            session = FactoryProvider.getFactory().openSession();
            Query query = session.createQuery("from User where email=:e and password=:p");
            query.setParameter("e", email);
            query.setParameter("p", password);
            User user = (User) query.uniqueResult();
            HttpSession httpSession = request.getSession();
            if (user != null) {
                httpSession.setAttribute("currentUser", user);
                response.sendRedirect("profile.jsp");
            } else {
                Message msg = new Message("Invalid Credentials.. Try again!", "error", "alert-danger");
                httpSession.setAttribute("msg", msg);
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
