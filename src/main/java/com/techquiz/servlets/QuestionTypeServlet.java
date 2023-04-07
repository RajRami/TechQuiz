package com.techquiz.servlets;

import com.techquiz.entities.QuestionType;
import com.techquiz.entities.TechCategory;
import com.techquiz.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "QuestionTypeServlet", value = "/QuestionTypeServlet")
public class QuestionTypeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = null;
        PrintWriter out = response.getWriter();
        try {

            //fetch tech category
            String name = request.getParameter("queType");
            session = FactoryProvider.getFactory().openSession();
            Transaction tx = session.beginTransaction();

            QuestionType questionType = new QuestionType(name.trim());
            session.save(questionType);
            out.println("success");
            tx.commit();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
