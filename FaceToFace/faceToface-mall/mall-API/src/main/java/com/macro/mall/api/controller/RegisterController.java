package com.macro.mall.api.controller;


import com.macro.mall.common.api.CommonResult;
import com.macro.mall.api.component.JwtAuthenticationTokenFilter;
import com.macro.mall.api.dto.FacRegisterParam;
import com.macro.mall.model.FacStudent;
import com.macro.mall.api.service.FacStudentService;
import com.macro.mall.api.util.JwtTokenUtil;
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
@Api(tags = "RegisterController", description = "Face API 接口")
@RequestMapping("/api")
public class RegisterController {

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

    @PostMapping(value = "register")
    @ResponseBody
    public CommonResult<FacRegisterParam> register(@RequestBody FacRegisterParam registerParam, HttpServletRequest request)
    {

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

        return CommonResult.failed("注册失败");

    }






}
