package com.techquiz.entities;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;

@Entity
@Table(name = "options")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Option {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "opt_id")
    private int id;

    @Column(name = "option_value", nullable = false, length = 500)
    private String option;

    @ManyToOne
    @JoinColumn(name = "que_id")
    private Question question;

    public Option(int id, String option, Question question) {
        this.id = id;
        this.option = option;
        this.question = question;
    }

    public Option(String option, Question question) {
        this.option = option;
        this.question = question;
    }

    public Option(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }
}
