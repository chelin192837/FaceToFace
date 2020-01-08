package com.macro.mall.api.controller;


import com.macro.mall.api.dto.FacMineAuthParam;
import com.macro.mall.api.service.FacTeachService;
import com.macro.mall.common.api.CommonResult;
import com.macro.mall.model.FacTeach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;

@Controller
@RequestMapping(value = "/api/mine")
public class MineController {

    @Autowired
    private FacTeachService facTeachService;

    @Value("${student.price}")
    private String price;

    @PostMapping(value = "auth")
    public CommonResult<String> teachAuth(@RequestBody FacMineAuthParam facMineAuthParam)
    {

        System.out.println(facMineAuthParam);

        FacTeach facTeach = new FacTeach();

        facTeach.setName(facMineAuthParam.getName());
        facTeach.setIphone(facMineAuthParam.getIphone());
        facTeach.setFlag(facMineAuthParam.getFlag());

        facTeach.setSubject(facMineAuthParam.getSubject());
        facTeach.setMajor(facMineAuthParam.getMajor());
        facTeach.setSex(facMineAuthParam.getSex());

        facTeach.setOther_two(facMineAuthParam.getOther_two());
        facTeach.setOther_one(price);

        facTeach.setCreate_time((new Date()));

        int row = facTeachService.insert(facTeach);
        if (row > 0)
        {
            return CommonResult.success("认证已经提交");
        }

        return CommonResult.failed("认证已经失败");
    }


}
