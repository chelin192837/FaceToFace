package com.macro.mall.api.controller;


import com.macro.mall.api.component.JwtAuthenticationTokenFilter;
import com.macro.mall.api.dto.FacRegisterParam;
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
@RequestMapping("/api/loginreg")
public class LoginController {

    @Autowired
    private FacStudentService facStudentService;

    @Autowired
    private FacStudentService facStudentService;

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

        //判断 fac_student 中是否含有用户名和密码

//        private String iphone;
//
//        private String password;

        String name = registerParam.getName();











        if (registerParam.getType().equals("student"))
        {
            FacStudent facStudent = new FacStudent();

            facStudent.setIphone(registerParam.getIphone());

            String password = registerParam.getPassword();

            try {

                password = DigestUtils.md5DigestAsHex(registerParam.getPassword().getBytes("UTF-8"));

            }catch (Exception e)
            {

            }

            facStudent.setPassword(password);

            String tokenStr = jwtTokenUtil.getCurrentUserId();

            int count = facStudentService.getCount();

            facStudent.setName(("同学"+String.valueOf(count)));

            registerParam.setName(facStudent.getName());

            int value = facStudentService.insert(facStudent);

            int userId = facStudentService.getIdByIphone(registerParam.getIphone());

            String token = jwtTokenUtil.generateTokenBera(String.valueOf(userId));

            registerParam.setToken(token);

            return CommonResult.success(registerParam);


        }else if(registerParam.getType().equals("teacher"))
        {


            return CommonResult.success(registerParam);
        }


        return CommonResult.failed("登录失败");


    }





}
