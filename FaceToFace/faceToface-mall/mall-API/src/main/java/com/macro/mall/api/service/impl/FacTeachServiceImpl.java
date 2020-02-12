package com.macro.mall.api.service.impl;

import com.github.pagehelper.PageHelper;
import com.macro.mall.api.service.FacTeachCardService;
import com.macro.mall.api.service.FacTeachService;
import com.macro.mall.mapper.FacTeachMapper;
import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacTeach;
import com.macro.mall.model.FacTeachCard;
import com.macro.mall.model.FacTeachExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacTeachServiceImpl implements FacTeachService {

    @Autowired
    private FacTeachMapper facTeachMapper ;

    @Autowired
    private FacTeachCardService facTeachCardService;

    @Override
    public int insert(FacTeach facTeach)
    {

        return facTeachMapper.insert(facTeach);
    }


    @Override
    public List<FacTeach> list(FacStudent facStudent, FacTeach facTeachParam,Integer pageSize, Integer pageNum)
    {
        PageHelper.startPage(pageNum,pageSize);

        FacTeachExample example = new FacTeachExample();

        FacTeachExample.Criteria criteria = example.createCriteria();


        if (facTeachParam.getSex() != null)
        {
            criteria.andSexEqualTo(facTeachParam.getSex());
        }
        if (facTeachParam.getMajor() != null)
        {
            criteria.andMajorEqualTo(facTeachParam.getMajor());
        }
        if (facTeachParam.getSubject() != null)
        {
            criteria.andSubjectEqualTo(facTeachParam.getSubject());
        }
        if (facTeachParam.getFlag() != null)
        {
            criteria.andFlagEqualTo(facTeachParam.getFlag());
        }

        example.setOrderByClause("create_time desc");


        List<FacTeach> list = facTeachMapper.selectByExample(example);


        for (FacTeach facTeach : list)
        {
            FacTeachCard facTeachCard = facTeachCardService.getTeachCardBy(facTeach.getUser_id());

            if (facTeachCard != null)
            {
                facTeach.setIcon(facTeachCard.getIcon());
                facTeach.setFile_url1(facTeachCard.getFile_url1());
                facTeach.setFile_url2(facTeachCard.getFile_url2());
                facTeach.setFile_url3(facTeachCard.getFile_url3());
            }

        }


        return list;

    }



}








































