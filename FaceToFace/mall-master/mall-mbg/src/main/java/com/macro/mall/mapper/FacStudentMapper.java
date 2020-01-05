package com.macro.mall.mapper;


import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacStudentExample;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacStudentMapper {


    int countByExample(FacStudentExample example);

    int deleteByExample(FacStudentExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacStudent record);

    int insertSelective(FacStudent record);

    List<FacStudent> selectByExample(FacStudentExample example);

    FacStudent selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacStudent record, @Param("example") FacStudentExample example);

    int updateByExample(@Param("record") FacStudent record, @Param("example") FacStudentExample example);

    int updateByPrimaryKeySelective(FacStudent record);

    int updateByPrimaryKey(FacStudent record);




    int getcount();

    int getIdByIphone(String iphone);

}
