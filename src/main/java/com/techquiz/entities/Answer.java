package com.techquiz.entities;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;

@Entity
@Table(name = "answers")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ans_id")
    private int id;

    @Column(nullable = false, length = 500)
    private String answer;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "que_id")
    private Question question;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "que_type_id")
    private QuestionType questionType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tech_cat_id")
    private TechCategory techCategory;


    public Answer(int id, String answer, Question question, QuestionType questionType, TechCategory techCategory) {
        this.id = id;
        this.answer = answer;
        this.question = question;
        this.questionType = questionType;
        this.techCategory = techCategory;
    }

    public Answer(String answer, Question question, QuestionType questionType, TechCategory techCategory) {
        this.answer = answer;
        this.question = question;
        this.questionType = questionType;
        this.techCategory = techCategory;
    }

    public Answer(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public QuestionType getQuestionType() {
        return questionType;
    }

    public void setQuestionType(QuestionType questionType) {
        this.questionType = questionType;
    }

    public TechCategory getTechCategory() {
        return techCategory;
    }

    public void setTechCategory(TechCategory techCategory) {
        this.techCategory = techCategory;
    }
}
