package com.macro.mall.api.service.impl;

import com.macro.mall.api.service.FacSendCodeService;
import com.macro.mall.api.util.SendCodeUtil;
import com.macro.mall.mapper.FacSendCodeMapper;
import com.macro.mall.model.FacSendCode;
import com.macro.mall.model.FacSendCodeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


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

       String code = SendCodeUtil.sendCode(iphone);

       facSendCode.setCode(Integer.valueOf(code));

       facSendCode.setStatus(FacSendCode.STATUS_YES);

       Date expireDate = new Date((new Date()).getTime() + expireTime * 60 * 1000);

       facSendCode.setExpiration_time(expireDate);

       facSendCode.setCreate_time(new Date());

       if (StringUtils.isEmpty(code))
       {
           return 0 ;
       }
       return facSendCodeMapper.insert(facSendCode);

   }



   @Override
   public int getCodeByIphone(String iphone,String code)
   {
       FacSendCodeExample example = new FacSendCodeExample();
       example.createCriteria().andUser_idEqualTo(iphone);
       example.createCriteria().andStatusEqualTo(FacSendCode.STATUS_YES);
       example.setOrderByClause("expiration_time desc");
       List<FacSendCode> facSendCodeList = facSendCodeMapper.selectByExample(example);
       if (facSendCodeList.size() > 0)
       {
           FacSendCode facSendCode = facSendCodeList.get(0);

           //验证码已经过期  2
           if (facSendCode.getExpiration_time().after(new Date())) //没有过期
           {
               if (facSendCode.getCode().equals(Integer.valueOf(code)))
               {
                   return 4;
               }else {
                   return 3;
               }
           }else {
               return 2;
           }
       }else { //手机号不存在
           return 1;
       }

   }


    @Override
    public void setCodeStatus(String iphone)
    {

        FacSendCodeExample example = new FacSendCodeExample();

        example.createCriteria().andUser_idEqualTo(iphone);

        example.createCriteria().andStatusEqualTo(FacSendCode.STATUS_YES);

        example.setOrderByClause("expiration_time desc");

        List<FacSendCode> facSendCodeList = facSendCodeMapper.selectByExample(example);

        if (facSendCodeList.size() > 0)
        {
            FacSendCode facSendCode = facSendCodeList.get(0);

            facSendCode.setStatus(FacSendCode.STATUS_NO);

            facSendCodeMapper.updateByExample(facSendCode,example);

        }

    }



}
