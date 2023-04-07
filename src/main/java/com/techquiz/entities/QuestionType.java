package com.techquiz.entities;

import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;

@Entity
@Table(name = "question_types")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class QuestionType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "que_type_id")
    private int id;
    @Column(name = "que_type_name", unique = true, nullable = false)
    private String name;

    public QuestionType(int id, String name) {
        this.id = id;
        this.name = name;
    }
    public QuestionType(String name) {
        this.name = name;
    }
    public QuestionType(int id) {
        this.id = id;
    }
    public QuestionType(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
