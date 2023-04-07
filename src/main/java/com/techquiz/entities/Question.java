package com.techquiz.entities;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "questions")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "que_id")
    private int id;

    @Column(nullable = false, length = 1500)
    private String question;

    @OneToMany(mappedBy = "question", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Option> options;

    @OneToOne(mappedBy = "question", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Answer answer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "que_type_id")
    private QuestionType questionType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tech_cat_id")
    private TechCategory techCategory;

    public Question(int id, String question, List<Option> options, Answer answer, QuestionType questionType, TechCategory techCategory) {
        this.id = id;
        this.question = question;
        this.options = options;
        this.answer = answer;
        this.questionType = questionType;
        this.techCategory = techCategory;
    }

    public Question(String question, List<Option> options, Answer answer, QuestionType questionType, TechCategory techCategory) {
        this.question = question;
        this.options = options;
        this.answer = answer;
        this.questionType = questionType;
        this.techCategory = techCategory;
    }

    public Question() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public List<Option> getOptions() {
        return options;
    }

    public void setOptions(List<Option> options) {
        this.options = options;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
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
