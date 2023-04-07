package com.techquiz.entities;

import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;

@Entity
@Table(name = "tech_categories")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class TechCategory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tech_cat_id")
    private int id;
    @Column(name = "tech_cat_name", unique = true, nullable = false)
    private String name;

    public TechCategory(int id, String name) {
        this.id = id;
        this.name = name;
    }
    public TechCategory(String name) {
        this.name = name;
    }
    public TechCategory(int id) {
        this.id = id;
    }
    public TechCategory(){}

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
