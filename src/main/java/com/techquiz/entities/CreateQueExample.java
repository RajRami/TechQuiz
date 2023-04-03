package com.techquiz.entities;

import com.techquiz.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.List;

public class main {
    public static void main(String[] args) {
        Question q1 = new Question();
        q1.setQuestion("does java supports OOPS?");

        Option opt1 = new Option("True", q1);
        Option opt2 = new Option("False", q1);
        List<Option> opts = new ArrayList<>();
        opts.add(opt1);
        opts.add(opt2);
        q1.setOptions(opts);

        Answer answer = new Answer("True", q1);
        q1.setAnswer(answer);

        QuestionType questionType = new QuestionType(2);
        q1.setQuestionType(questionType);

        TechCategory techCategory = new TechCategory(1);
        q1.setTechCategory(techCategory);

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        session.persist(q1);

        tx.commit();
        session.close();
    }
}
