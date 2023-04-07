package com.techquiz.entities;

import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "users")
@Cacheable
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int id;
    @Column(name = "user_name", nullable = false)
    private String name;
    @Column(name = "user_email", unique = true, nullable = false)
    private String email;
    @Column(name = "user_password", nullable = false)
    private String password;
    @Column(nullable = false)
    private String gender;
    @Column(columnDefinition = "varchar(500) default 'Hey there, I am using TechQuiz'")
    private String about;
    private Date reg_date;
    @Column(columnDefinition = "varchar(50) default 'default.png'")
    private String profile;

    public User(int id, String name, String email, String password, String gender, String about, Date reg_date, String profile) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.reg_date = reg_date;
        this.profile = profile;
    }

    public User(){}

    public User(String name, String email, String password, String gender, String about, Date reg_date, String profile) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.reg_date = reg_date;
        this.profile = profile;
    }

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }
}
