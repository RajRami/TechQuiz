package com.techquiz.servlets;

import com.techquiz.entities.*;
import com.techquiz.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "QuestionServlet", value = "/QuestionServlet")
public class QuestionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Session session = null;
        PrintWriter out = response.getWriter();
        try {
            //Fetch question data and assign them to a question object
            Question questionObj = new Question();

            //Creating a TechCategory object
            int techCatId = Integer.parseInt(request.getParameter("techCatId"));
            TechCategory techCategory = new TechCategory(techCatId);

            //Creating a QuestionType object
            int queTypeId = Integer.parseInt(request.getParameter("queTypeId"));
            QuestionType questionType = new QuestionType(queTypeId);

            //question
            String question = request.getParameter("question");

            //Creating options based on queTypeId and add them to an optionList
            List<Option> optionList = new ArrayList<>();

            if (queTypeId == 2) {
                String optT = "True";
                String optF = "False";
                Option optionT = new Option(optT, questionObj);
                Option optionF = new Option(optF, questionObj);
                optionList.add(optionT);
                optionList.add(optionF);

            } else {
                String opt1 = request.getParameter("option1");
                String opt2 = request.getParameter("option2");
                String opt3 = request.getParameter("option3");
                Option option1 = new Option(opt1, questionObj);
                Option option2 = new Option(opt2, questionObj);
                Option option3 = new Option(opt3, questionObj);
                optionList.add(option1);
                optionList.add(option2);
                optionList.add(option3);
            }

            //Creating an Answer object
            String answer = request.getParameter("answer");
            Answer answerObj = new Answer(answer, questionObj, questionType, techCategory);

            //Setting the values to question object
            questionObj.setQuestion(question);
            questionObj.setOptions(optionList);
            questionObj.setAnswer(answerObj);
            questionObj.setQuestionType(questionType);
            questionObj.setTechCategory(techCategory);

            //Open session
            session = FactoryProvider.getFactory().openSession();

            //Begin Transaction
            Transaction tx = session.beginTransaction();

            //Save the question object (Connected entities will be saved automatically because we have set up CascadeType.ALL)
            session.save(questionObj);
            out.println("success");

            //commit the changes in the database
            tx.commit();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
