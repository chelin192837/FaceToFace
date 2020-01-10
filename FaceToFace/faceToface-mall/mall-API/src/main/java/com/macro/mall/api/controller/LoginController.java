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







        return CommonResult.success(registerParam);


//        return CommonResult.failed("登录失败");


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
