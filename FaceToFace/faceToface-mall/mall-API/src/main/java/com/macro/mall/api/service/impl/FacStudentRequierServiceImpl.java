package com.macro.mall.api.service.impl;

import com.github.pagehelper.PageHelper;
import com.macro.mall.api.service.FacStudentRequierService;
import com.macro.mall.mapper.FacStudentRequirementMapper;
import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacStudentRequirement;
import com.macro.mall.model.FacStudentRequirementExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacStudentRequierServiceImpl implements FacStudentRequierService {

    @Autowired
    private FacStudentRequirementMapper facStudentRequirementMapper;

    @Override
    public int insert(FacStudentRequirement facStudentRequirement)
    {
        return facStudentRequirementMapper.insert(facStudentRequirement);
    }

    @Override
    public List<FacStudentRequirement> list(FacStudent facStudent, Integer pageSize, Integer pageNum)
    {
        PageHelper.startPage(pageNum, pageSize);
        FacStudentRequirementExample example = new FacStudentRequirementExample();
        example.createCriteria().andStudent_iphoneEqualTo(facStudent.getIphone());
        example.setOrderByClause("create_time desc");
        return facStudentRequirementMapper.selectByExample(example);
    }

}
