package com.macro.mall.api.controller;


import com.macro.mall.api.dto.FacPageHelpParam;
import com.macro.mall.api.service.FacTeachService;
import com.macro.mall.api.util.HelpUserTool;
import com.macro.mall.common.api.CommonResult;
import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacStudentRequirement;
import com.macro.mall.model.FacTeach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping(value = "/api/discover")
public class DiscoverController {

    @Autowired
    private FacTeachService facTeachService;

    @PostMapping(value = "teacherlist")
    @ResponseBody
    public CommonResult<HashMap<String, List<FacTeach>>> studentRequirelist(@RequestBody FacPageHelpParam facPageHelpParam)
    {

        FacStudent facStudent = HelpUserTool.getInstance().getFacStudent();

        List<FacTeach> list = facTeachService.list(facStudent,5,facPageHelpParam.getPage());

        HashMap<String,List<FacTeach>> map = new HashMap<>();

        map.put("list",list);

        return CommonResult.success(map);

    }


}
