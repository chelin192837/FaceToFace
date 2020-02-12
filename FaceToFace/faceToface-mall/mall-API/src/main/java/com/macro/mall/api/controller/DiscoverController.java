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

        FacTeach facTeach = new FacTeach();

        if (facPageHelpParam.getSearchName() != null)
        {
            if (facPageHelpParam.getSearchName().equals("学习方法") ||facPageHelpParam.getSearchName().equals("高分经验"))
            {
                facTeach.setSex("女");
            }else if (facPageHelpParam.getSearchName().equals("学习习惯") ||facPageHelpParam.getSearchName().equals("课外扩展"))
            {
                facTeach.setMajor("理科");
            }else if (facPageHelpParam.getSearchName().equals("学习心态") ||facPageHelpParam.getSearchName().equals("家长监督"))
            {
                facTeach.setSubject("清华大学");
            }else if (facPageHelpParam.getSearchName().equals("情感心理") ||facPageHelpParam.getSearchName().equals("家庭教育"))
            {
                facTeach.setFlag("单科满分");
            }
        }else {

//            if (str != null && str.length() != 0); java判空处理
            if (facPageHelpParam.getSex() != null && facPageHelpParam.getSex().length() !=0)
            {
                facTeach.setSex(facPageHelpParam.getSex());
            }
            if (facPageHelpParam.getMajor() != null && facPageHelpParam.getMajor().length() !=0)
            {
                facTeach.setMajor(facPageHelpParam.getMajor());
            }
            if (facPageHelpParam.getSubject() != null && facPageHelpParam.getSubject().length() !=0)
            {
                facTeach.setSubject(facPageHelpParam.getSubject());
            }
            if (facPageHelpParam.getFlag() != null && facPageHelpParam.getFlag().length() !=0)
            {
                facTeach.setFlag(facPageHelpParam.getFlag());
            }

        }



        List<FacTeach> list = facTeachService.list(facStudent,facTeach,5,facPageHelpParam.getPage());

        HashMap<String,List<FacTeach>> map = new HashMap<>();

        if (list.size()>0)
        {
            map.put("list",list);
        }

        return CommonResult.success(map);

    }


}
