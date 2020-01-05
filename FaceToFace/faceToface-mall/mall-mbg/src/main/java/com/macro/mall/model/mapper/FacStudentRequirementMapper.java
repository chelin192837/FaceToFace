package com.macro.mall.model.mapper;


import com.macro.mall.model.FacStudentRequirement;
import com.macro.mall.model.FacStudentRequirementExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacStudentRequirementMapper {
    int countByExample(FacStudentRequirementExample example);

    int deleteByExample(FacStudentRequirementExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacStudentRequirement record);

    int insertSelective(FacStudentRequirement record);

    List<FacStudentRequirement> selectByExample(FacStudentRequirementExample example);

    FacStudentRequirement selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacStudentRequirement record, @Param("example") FacStudentRequirementExample example);

    int updateByExample(@Param("record") FacStudentRequirement record, @Param("example") FacStudentRequirementExample example);

    int updateByPrimaryKeySelective(FacStudentRequirement record);

    int updateByPrimaryKey(FacStudentRequirement record);
}
