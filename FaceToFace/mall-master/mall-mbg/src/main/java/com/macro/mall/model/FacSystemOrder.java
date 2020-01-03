package com.macro.mall.model;

import java.util.Date;

public class FacSystemOrder {
    private Long id;

    private Long user_id;

    private Long teach_id;

    private String status;

    private String other_one;

    private String other_two;

    private Date create_time;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUser_id() {
        return user_id;
    }

    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

    public Long getTeach_id() {
        return teach_id;
    }

    public void setTeach_id(Long teach_id) {
        this.teach_id = teach_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
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
