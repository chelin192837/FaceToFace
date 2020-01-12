package com.macro.mall.api.service;

import com.macro.mall.model.FacSendCode;

public interface FacSendCodeService {


    int sendCode(String iphone);


    /**
     *
     * @param
     * @return 1 表示 手机号不存在 ；2 表示 时间已经过期 ; 3 表示 登录成功；
     */
    int getCodeByIphone(String iphone,String code);


    void setCodeStatus(String iphone);



}
