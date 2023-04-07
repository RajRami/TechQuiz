package com.techquiz.servlets;

import com.techquiz.entities.Message;
import com.techquiz.entities.User;
import com.techquiz.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Date;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = null;
        HttpSession httpSession = request.getSession();

        try {
            //fetch all data
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");
            String gender = request.getParameter("gender");
            String about = request.getParameter("about");
            if(about.trim().length()<=0){
                about="Hey there, I am using TechQuiz";
            }
            String profile = "default.png";

            User user = new User(name, email, password, gender, about, new Date(), profile);

            session = FactoryProvider.getFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.save(user);

            tx.commit();

            httpSession.setAttribute("currentUser", user);
            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            Message msg = new Message("Oops..! Email already in use", "error", "alert-danger");
            httpSession.setAttribute("msg", msg);
            response.sendRedirect("register.jsp");
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
