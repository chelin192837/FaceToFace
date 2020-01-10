package com.macro.mall.api.service.impl;

import com.macro.mall.api.service.FacSendCodeService;
import com.macro.mall.mapper.FacSendCodeMapper;
import com.macro.mall.model.FacSendCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;


@Service
public class FacSendCodeServiceImpl implements FacSendCodeService {

    @Value("${student.expireTime}")
    private int expireTime;

    @Autowired
    private FacSendCodeMapper facSendCodeMapper;

    @Override
   public int sendCode(String iphone)
   {
       FacSendCode facSendCode = new FacSendCode();

       facSendCode.setUser_id(iphone);

       facSendCode.setCode((int)((Math.random()*9+1)*100000));

       Date expireDate = new Date((new Date()).getTime() + expireTime * 60 * 1000);

       facSendCode.setExpiration_time(expireDate);

       facSendCode.setCreate_time(new Date());

       return facSendCodeMapper.insert(facSendCode);

   }




}
