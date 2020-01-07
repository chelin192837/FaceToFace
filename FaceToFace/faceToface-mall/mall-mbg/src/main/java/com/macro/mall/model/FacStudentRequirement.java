package com.macro.mall.model;

import java.util.Date;

public class FacStudentRequirement {
    private Long id;

    private String student_name;

    private String student_iphone;

    private String teach_flag;

    private String teach_sex;

    private String teach_major;

    private String teach_subject;

    private String teach_advantage;

    private String problem;

    //备注，其他问题
    private String other;

    //高中生年级
    private String other_one;

    //订单状态
    private String other_two;

    private Date create_time;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStudent_name() {
        return student_name;
    }

    public void setStudent_name(String student_name) {
        this.student_name = student_name == null ? null : student_name.trim();
    }

    public String getStudent_iphone() {
        return student_iphone;
    }

    public void setStudent_iphone(String student_iphone) {
        this.student_iphone = student_iphone == null ? null : student_iphone.trim();
    }

    public String getTeach_flag() {
        return teach_flag;
    }

    public void setTeach_flag(String teach_flag) {
        this.teach_flag = teach_flag == null ? null : teach_flag.trim();
    }

    public String getTeach_sex() {
        return teach_sex;
    }

    public void setTeach_sex(String teach_sex) {
        this.teach_sex = teach_sex == null ? null : teach_sex.trim();
    }

    public String getTeach_major() {
        return teach_major;
    }

    public void setTeach_major(String teach_major) {
        this.teach_major = teach_major == null ? null : teach_major.trim();
    }

    public String getTeach_subject() {
        return teach_subject;
    }

    public void setTeach_subject(String teach_subject) {
        this.teach_subject = teach_subject == null ? null : teach_subject.trim();
    }

    public String getTeach_advantage() {
        return teach_advantage;
    }

    public void setTeach_advantage(String teach_advantage) {
        this.teach_advantage = teach_advantage == null ? null : teach_advantage.trim();
    }

    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = problem == null ? null : problem.trim();
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other == null ? null : other.trim();
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
