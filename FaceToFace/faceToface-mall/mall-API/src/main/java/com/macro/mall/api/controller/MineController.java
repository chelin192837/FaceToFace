package com.macro.mall.api.controller;


import com.macro.mall.api.dto.FacConsultationParam;
import com.macro.mall.api.dto.FacMineAuthParam;
import com.macro.mall.api.service.FacConsultationService;
import com.macro.mall.api.service.FacTeachCardService;
import com.macro.mall.api.service.FacTeachService;
import com.macro.mall.api.util.HelpUserTool;
import com.macro.mall.common.api.CommonResult;
import com.macro.mall.model.FacConsultation;
import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacTeach;
import com.macro.mall.model.FacTeachCard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/api/mine")
public class MineController {

    @Autowired
    private FacTeachService facTeachService;

    @Autowired
    private FacTeachCardService facTeachCardService;

    @Autowired
    private FacConsultationService facConsultationService;

    @Value("${student.price}")
    private String price;

    @PostMapping(value = "auth")
    @ResponseBody
    public CommonResult<String> teachAuth(@RequestBody FacMineAuthParam facMineAuthParam)
    {
        FacStudent facStudent = HelpUserTool.getInstance().getFacStudent();

        System.out.println(facMineAuthParam);

        FacTeach facTeach = new FacTeach();

        facTeach.setName(facMineAuthParam.getName());
        facTeach.setIphone(facMineAuthParam.getIphone());
        facTeach.setFlag(facMineAuthParam.getFlag());

        facTeach.setSubject(facMineAuthParam.getSubject());
        facTeach.setMajor(facMineAuthParam.getMajor());
        facTeach.setSex(facMineAuthParam.getSex());

        facTeach.setAdvantage(facMineAuthParam.getAdvantage());
        facTeach.setOther_two(facMineAuthParam.getOther_two());
        facTeach.setOther_one(facMineAuthParam.getOther_one());

        // password字段变为 facstudent 关联 facteach 的字段
        facTeach.setPassword(facStudent.getId().toString());

        facTeach.setActive(Integer.valueOf(price));

        facTeach.setCreate_time((new Date()));

        int row = facTeachService.insert(facTeach);
        if (row > 0)
        {
            return CommonResult.success("认证已经提交");
        }

        return CommonResult.failed("认证已经失败");
    }


    @PostMapping(value = "card")
    @ResponseBody
    public CommonResult<String> card(MultipartFile files1, MultipartFile files2, MultipartFile files3, HttpServletRequest request)
    {

        FacStudent facStudent = HelpUserTool.getInstance().getFacStudent();

        FacTeachCard facTeachCard = new FacTeachCard();

        facTeachCard.setUser_id(facStudent.getId().toString());

        facTeachCard.setCreate_time(new Date());

        facTeachCard.setStatus("pending");

        facTeachCard.setRemark("身份认证");

        facTeachCardService.insert(facTeachCard,files1,files2,files3);

        return CommonResult.success("认证已经提交");

    }

    @PostMapping(value = "consultation")
    @ResponseBody
    public CommonResult<String> consultation(@RequestBody FacConsultationParam facConsultationParam)
    {
        FacConsultation facConsultation = new FacConsultation();
        facConsultation.setDevice_id(facConsultationParam.getDevice_id());
        facConsultation.setIphone(facConsultationParam.getIphone());
        facConsultation.setOther_one(facConsultationParam.getConsultation());
        facConsultation.setCreate_time(new Date());
        int result = facConsultationService.insert(facConsultation);

        if (result > 0)
        {
         return CommonResult.success("发布成功");
        }

         return CommonResult.failed("发布失败");

    }

    @PostMapping(value = "consultationlist")
    @ResponseBody
    public CommonResult<List<FacConsultation>> consultationlist(@RequestBody FacConsultationParam facConsultationParam)
    {

        List<FacConsultation> list = facConsultationService.getConsultationByDeviceId(facConsultationParam.getDevice_id());

        return CommonResult.success(list);

    }






}
