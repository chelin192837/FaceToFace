package com.macro.mall.model;

import java.util.Date;

public class FacSendCode {


    public static Integer STATUS_YES  = 2 ;

    public static Integer STATUS_NO  = 1 ;

    //币种数据库id
//    public static int COIN_TYPE_LTC = 1;
//
//    public static int COIN_TYPE_BTC = 2;
//
//    public static int COIN_TYPE_ETH = 3;

    private Long id;

    private String user_id;

    private Integer code;

    private Integer status;

    private Date create_time;

    private Date expiration_time;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id == null ? null : user_id.trim();
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public Date getExpiration_time() {
        return expiration_time;
    }

    public void setExpiration_time(Date expiration_time) {
        this.expiration_time = expiration_time;
    }
}
