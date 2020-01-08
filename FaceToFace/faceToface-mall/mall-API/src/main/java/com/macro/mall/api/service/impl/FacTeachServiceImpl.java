package com.macro.mall.api.service.impl;

import com.github.pagehelper.PageHelper;
import com.macro.mall.api.service.FacTeachService;
import com.macro.mall.mapper.FacTeachMapper;
import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacTeach;
import com.macro.mall.model.FacTeachExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacTeachServiceImpl implements FacTeachService {

    @Autowired
    private FacTeachMapper facTeachMapper ;

    @Override
    public int insert(FacTeach facTeach)
    {

        return facTeachMapper.insert(facTeach);
    }


    @Override
    public List<FacTeach> list(FacStudent facStudent, Integer pageSize, Integer pageNum)
    {
        PageHelper.startPage(pageNum,pageSize);
        FacTeachExample example = new FacTeachExample();
        example.setOrderByClause("create_time desc");

        return facTeachMapper.selectByExample(example);
    }



}








































