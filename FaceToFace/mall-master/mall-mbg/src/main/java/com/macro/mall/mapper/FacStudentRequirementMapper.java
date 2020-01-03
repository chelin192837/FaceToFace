package com.macro.mall.mapper;


import com.macro.mall.model.FacStudentRequirement;

public interface FacStudentRequirementMapper {
    int deleteByPrimaryKey(Long id);

    int insert(FacStudentRequirement record);

    int insertSelective(FacStudentRequirement record);

    FacStudentRequirement selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(FacStudentRequirement record);

    int updateByPrimaryKey(FacStudentRequirement record);
}
