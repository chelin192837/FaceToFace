package com.macro.mall.api.controller;


import com.macro.mall.api.dto.FacPageHelpParam;
import com.macro.mall.api.dto.FacStudentRequirementParam;
import com.macro.mall.api.service.FacStudentRequierService;
import com.macro.mall.api.util.HelpUserTool;
import com.macro.mall.common.api.CommonResult;
import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacStudentRequirement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping(value = "/api/publish")
public class PublishController {

    @Autowired
    private FacStudentRequierService facStudentRequierService;


    @PostMapping(value = "require")
    @ResponseBody
    public CommonResult<String> studentRequirement(@RequestBody FacStudentRequirementParam facStudentRequirementParam)
    {

        FacStudent facStudent = HelpUserTool.getInstance().getFacStudent();

        FacStudentRequirement facStudentRequirement = new FacStudentRequirement();

        facStudentRequirement.setStudent_name(facStudentRequirementParam.getStudentName());

        facStudentRequirement.setStudent_iphone(facStudent.getIphone());

        facStudentRequirement.setProblem(facStudentRequirementParam.getProblem());

        facStudentRequirement.setTeach_major(facStudentRequirementParam.getTeachMajor());

        facStudentRequirement.setOther(facStudentRequirementParam.getOther());

        facStudentRequirement.setOther_one(facStudentRequirementParam.getOtherOne());

        facStudentRequirement.setCreate_time((new Date()));

        int row = facStudentRequierService.insert(facStudentRequirement);

        if (row > 0)
        {
            return CommonResult.success("发布成功");
        }
            return CommonResult.failed("发布失败");
    }

    @PostMapping(value = "requirelist")
    @ResponseBody
    public CommonResult<HashMap<String,List<FacStudentRequirement>>> studentRequirelist(@RequestBody FacPageHelpParam facPageHelpParam)
    {

        FacStudent facStudent = HelpUserTool.getInstance().getFacStudent();

        List<FacStudentRequirement> list = facStudentRequierService.list(facStudent,5,facPageHelpParam.getPage());

        HashMap<String,List<FacStudentRequirement>> map = new HashMap<>();

        map.put("list",list);

        return CommonResult.success(map);

    }





}
