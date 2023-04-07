package com.techquiz.servlets;

import com.techquiz.entities.*;
import com.techquiz.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "ResultServlet", value = "/ResultServlet")
public class ResultServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session1 = null;
        PrintWriter out = response.getWriter();
        try {
            //Fetch all queId, answers, TCId and QTId

            int qtId = Integer.parseInt(request.getParameter("qtId"));
            QuestionType questionType = new QuestionType(qtId);

            int tcId = Integer.parseInt(request.getParameter("tcId"));
            TechCategory techCategory = new TechCategory(tcId);

            int queIdForQueNo1 = Integer.parseInt(request.getParameter("queNo1"));
            String selectedAnsForQue1 = request.getParameter("selectedAnsForQue1");

            int queIdForQueNo2 = Integer.parseInt(request.getParameter("queNo2"));
            String selectedAnsForQue2 = request.getParameter("selectedAnsForQue2");

            int queIdForQueNo3 = Integer.parseInt(request.getParameter("queNo3"));
            String selectedAnsForQue3 = request.getParameter("selectedAnsForQue3");

            int queIdForQueNo4 = Integer.parseInt(request.getParameter("queNo4"));
            String selectedAnsForQue4 = request.getParameter("selectedAnsForQue4");

            int queIdForQueNo5 = Integer.parseInt(request.getParameter("queNo5"));
            String selectedAnsForQue5 = request.getParameter("selectedAnsForQue5");

            HashMap<Integer, String> QAndAFromUser = new HashMap<>();
            QAndAFromUser.put(queIdForQueNo1, selectedAnsForQue1);
            QAndAFromUser.put(queIdForQueNo2, selectedAnsForQue2);
            QAndAFromUser.put(queIdForQueNo3, selectedAnsForQue3);
            QAndAFromUser.put(queIdForQueNo4, selectedAnsForQue4);
            QAndAFromUser.put(queIdForQueNo5, selectedAnsForQue5);

            // Fetch actual queId and ans from database
            session1 = FactoryProvider.getFactory().openSession();
            Query query = session1.createQuery("from Answer where questionType.id=:qt and techCategory.id=:tc");
            query.setParameter("qt", qtId);
            query.setParameter("tc", tcId);
            List<String> selectedAns = new ArrayList<>();
            List<String> actualAns = new ArrayList<>();
            HashMap<Integer, String> QAndAFromDB = new HashMap<>();
            List<Answer> list = query.setHint("org.hibernate.cacheable", true).list();
            for (Answer value : list) {
                QAndAFromDB.put(value.getQuestion().getId(), value.getAnswer());
            }
            int rightAns = 0;
            int wrongAns = 0;
            if (QAndAFromUser.size() == QAndAFromDB.size()) {
                QAndAFromUser.forEach((key, value) -> {
                    selectedAns.add(QAndAFromUser.get(key));
                });
                QAndAFromDB.forEach((key, value) -> {
                    actualAns.add(QAndAFromDB.get(key));
                });
                for (int i = 0; i < selectedAns.size(); i++) {
                    if (selectedAns.get(i).trim().equals(actualAns.get(i).trim())) {
                        rightAns++;
                    } else {
                        wrongAns++;
                    }
                }
            }
            int scoreTotal = rightAns + wrongAns;
            HttpSession httpSession = request.getSession();
            User user = (User) httpSession.getAttribute("currentUser");

            Transaction tx = session1.beginTransaction();

            Result result = new Result(rightAns, scoreTotal, questionType, techCategory,user, new Date());
            session1.save(result);
            out.println("success");
            tx.commit();
            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session1.close();
        }
    }
}
