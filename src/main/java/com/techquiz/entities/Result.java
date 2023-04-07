package com.techquiz.entities;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "results")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Result {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "result_id")
    private int id;

    @Column(name = "score_obtained", nullable = false)
    private int scoreObtained;

    @Column(name = "score_total", nullable = false)
    private int scoreTotal;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "que_type_id")
    private QuestionType questionType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tech_cat_id")
    private TechCategory techCategory;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @Temporal(TemporalType.DATE)
    private Date resultDate;

    public Result(int id, int scoreObtained, int scoreTotal, QuestionType questionType, TechCategory techCategory, User user, Date resultDate) {
        this.id = id;
        this.scoreObtained = scoreObtained;
        this.scoreTotal = scoreTotal;
        this.questionType = questionType;
        this.techCategory = techCategory;
        this.user = user;
        this.resultDate = resultDate;
    }

    public Result(int scoreObtained, int scoreTotal, QuestionType questionType, TechCategory techCategory, User user, Date resultDate) {
        this.scoreObtained = scoreObtained;
        this.scoreTotal = scoreTotal;
        this.questionType = questionType;
        this.techCategory = techCategory;
        this.user = user;
        this.resultDate = resultDate;
    }

    public Result() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getScoreObtained() {
        return scoreObtained;
    }

    public void setScoreObtained(int scoreObtained) {
        this.scoreObtained = scoreObtained;
    }

    public int getScoreTotal() {
        return scoreTotal;
    }

    public void setScoreTotal(int scoreTotal) {
        this.scoreTotal = scoreTotal;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getResultDate() {
        return resultDate;
    }

    public void setResultDate(Date resultDate) {
        this.resultDate = resultDate;
    }
}
