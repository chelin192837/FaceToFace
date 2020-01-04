package com.macro.mall.controller.API;


import com.macro.mall.common.api.CommonResult;
import com.macro.mall.component.JwtAuthenticationTokenFilter;
import com.macro.mall.dto.fac.FacRegisterParam;
import com.macro.mall.model.FacStudent;
import com.macro.mall.service.FacStudentService;
import com.macro.mall.util.JwtTokenUtil;
import io.swagger.annotations.Api;
import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HttpServletBean;

import javax.servlet.http.HttpServletRequest;

@Controller
@Api(tags = "RegisterController", description = "Face API 接口")
@RequestMapping("/api/loginreg")
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
                password = DigestUtils.md5Hex(registerParam.getPassword().getBytes("UTF-8"));
            }catch (Exception e)
            {

            }

            facStudent.setPassword(password);

            String tokenStr = jwtTokenUtil.getCurrentUserId();

            int count = facStudentService.getCount();

            facStudent.setName(("学生"+String.valueOf(count)));

            registerParam.setName(facStudent.getName());

            int value = facStudentService.insert(facStudent);

            String username = registerParam.getIphone();

            String token = jwtTokenUtil.generateTokenBera(username);

            registerParam.setToken(token);

            return CommonResult.success(registerParam);

        }else if(registerParam.getType().equals("teacher"))
        {


            return CommonResult.success(registerParam);
        }

        return CommonResult.failed("注册失败");

    }






}
