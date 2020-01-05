package com.macro.mall.model;

import java.util.Date;

public class FacStudent {
    private Long id;

    private String name;

    private String iphone;

    private String password;

    private String sex;

    private String grade;

    //other_one -> 变成 fac_teach表的外建
    private String other_one;

    // other_two -> 存储 token
    private String other_two;

    private Date create_time;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getIphone() {
        return iphone;
    }

    public void setIphone(String iphone) {
        this.iphone = iphone == null ? null : iphone.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getOther_one() {
        return other_one;
    }

    public void setOther_one(String other_one) {
        this.other_one = other_one == null ? null : other_one.trim();
    }

    public String getOther_two() {
        return other_two;
    }

    public void setOther_two(String other_two) {
        this.other_two = other_two == null ? null : other_two.trim();
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }
}
