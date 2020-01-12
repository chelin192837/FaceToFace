package com.macro.mall.api.controller;


import com.macro.mall.api.component.JwtAuthenticationTokenFilter;
import com.macro.mall.api.dto.FacRegisterParam;
import com.macro.mall.api.service.FacSendCodeService;
import com.macro.mall.api.service.FacStudentService;
import com.macro.mall.api.util.JwtTokenUtil;
import com.macro.mall.common.api.CommonResult;
import com.macro.mall.model.FacStudent;

import io.swagger.annotations.Api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@Api(tags = "LoginController", description = "Face API 接口")
@RequestMapping("/api")
public class LoginController {

    @Autowired
    private FacStudentService facStudentService;

    @Autowired
    private FacSendCodeService facSendCodeService;


    private static final Logger LOGGER = LoggerFactory.getLogger(JwtAuthenticationTokenFilter.class);

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Value("${jwt.tokenHeader}")
    private String tokenHeader;
    @Value("${jwt.tokenHead}")
    private String tokenHead;


    @PostMapping(value = "login")
    @ResponseBody
    public CommonResult<FacRegisterParam> login(@RequestBody FacRegisterParam registerParam, HttpServletRequest request)
    {

        String iphone = registerParam.getIphone();

        String code = registerParam.getCode();

        int result = facSendCodeService.getCodeByIphone(iphone,code);

        if (result == 1)
        {
            return CommonResult.failed("验证码不存在");
        }else if (result == 2)
        {
            return CommonResult.failed("验证码已经过期");
        }else if (result == 3)
        {
            return CommonResult.failed("验证码不正确");
        }else if (result == 4) //手机号对应验证码正确 ， 存在就登录 ， 不存在就注册
        {
            FacStudent facStudent = facStudentService.selectByIphone(iphone);

            if (facStudent == null) //注册
            {
                FacStudent facStudentReg = new FacStudent();
                int count = facStudentService.getCount();
                String nickName = "同学"+String.valueOf(count);
                facStudentReg.setIphone(iphone);
                facStudentReg.setName(nickName);
                int reg =  facStudentService.insert(facStudentReg);
                if (reg > 0)
                {
                    FacStudent facStudent1 = facStudentService.selectByIphone(iphone);
                    String token = jwtTokenUtil.generateTokenBera(String.valueOf(facStudent1.getId()));
                    registerParam.setToken(token);
                    registerParam.setName(nickName);

                }else {
                    return CommonResult.failed("登录失败");
                }

            }else { //查出userid 返回给前端

                registerParam.setName(facStudent.getName());
                String token = jwtTokenUtil.generateTokenBera(String.valueOf(facStudent.getId()));
                registerParam.setToken(token);
            }

//            facSendCodeService.setCodeStatus(iphone);

            return CommonResult.success(registerParam);
        }

        return CommonResult.success(registerParam);

    }

    @PostMapping(value = "sendCode")
    @ResponseBody
    public CommonResult<String> sendCode(@RequestBody FacRegisterParam facRegisterParam)
    {

       int result =  facSendCodeService.sendCode(facRegisterParam.getIphone());

       if (result > 0)
       {
           return CommonResult.success("验证码发送成功");
       }

       return CommonResult.failed("验证码发送失败");

    }


}
