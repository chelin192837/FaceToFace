package com.macro.mall.controller.API;


import com.macro.mall.common.api.CommonResult;
import com.macro.mall.model.FacStudent;
import com.macro.mall.service.FacStudentService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Api(tags = "FacStudentController", description = "Face API 接口")
@RequestMapping("/api")
public class FcStudentController {

    @Autowired
    private FacStudentService facStudentService;

    @GetMapping(value = "student")
    @ResponseBody
    public CommonResult<FacStudent> getstudent()
    {

        FacStudent facStudent = facStudentService.selectByKey(Long.valueOf(1));

        return CommonResult.success(facStudent);

    }

    @GetMapping(value = "common")
    @ResponseBody
    public CommonResult common()
    {

        return CommonResult.failed();
    }








}
