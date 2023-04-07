package com.techquiz.servlets;

import com.techquiz.entities.Message;
import com.techquiz.entities.TechCategory;
import com.techquiz.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "TechCategoryServlet", value = "/TechCategoryServlet")
public class TechCategoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = null;
        PrintWriter out = response.getWriter();
        try {

            //fetch tech category
            String name = request.getParameter("techCat");
            session = FactoryProvider.getFactory().openSession();
            Transaction tx = session.beginTransaction();

            TechCategory techCategory = new TechCategory(name.trim());
            session.save(techCategory);
            out.println("success");
            tx.commit();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
