package com.macro.mall.model;

import java.util.Date;

public class FacTeach {
    private Long id;

    private String name;

    private String iphone;

    private String user_id;

    private String sex;

    //文理科
    private String major;

    //北大/清华
    private String subject;

    private String flag;

    //座右铭
    private String advantage;

    // 价格
    private Integer active;

    // 地址
    private String other_one;

    // 大学时专业
    private String other_two;

    private Date create_time;


    private String icon;

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    private String file_url1;

    private String file_url2;

    private String file_url3;

    public void setFile_url1(String file_url1) {
        this.file_url1 = file_url1;
    }

    public void setFile_url2(String file_url2) {
        this.file_url2 = file_url2;
    }

    public void setFile_url3(String file_url3) {
        this.file_url3 = file_url3;
    }

    public String getFile_url1() {
        return file_url1;
    }

    public String getFile_url2() {
        return file_url2;
    }

    public String getFile_url3() {
        return file_url3;
    }

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


    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major == null ? null : major.trim();
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag == null ? null : flag.trim();
    }

    public String getAdvantage() {
        return advantage;
    }

    public void setAdvantage(String advantage) {
        this.advantage = advantage == null ? null : advantage.trim();
    }

    public Integer getActive() {
        return active;
    }

    public void setActive(Integer active) {
        this.active = active;
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
