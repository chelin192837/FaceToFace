package com.macro.mall.mapper;


import com.macro.mall.model.FacConsultation;
import com.macro.mall.model.FacConsultationExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacConsultationMapper {
    int countByExample(FacConsultationExample example);

    int deleteByExample(FacConsultationExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacConsultation record);

    int insertSelective(FacConsultation record);

    List<FacConsultation> selectByExample(FacConsultationExample example);

    FacConsultation selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacConsultation record, @Param("example") FacConsultationExample example);

    int updateByExample(@Param("record") FacConsultation record, @Param("example") FacConsultationExample example);

    int updateByPrimaryKeySelective(FacConsultation record);

    int updateByPrimaryKey(FacConsultation record);
}
