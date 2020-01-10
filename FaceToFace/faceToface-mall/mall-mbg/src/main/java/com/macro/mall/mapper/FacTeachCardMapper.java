package com.macro.mall.mapper;


import com.macro.mall.model.FacTeachCardExample;
import com.macro.mall.model.FacTeachCard;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacTeachCardMapper {
    int countByExample(FacTeachCardExample example);

    int deleteByExample(FacTeachCardExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacTeachCard record);

    int insertSelective(FacTeachCard record);

    List<FacTeachCard> selectByExample(FacTeachCardExample example);

    FacTeachCard selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacTeachCard record, @Param("example") FacTeachCardExample example);

    int updateByExample(@Param("record") FacTeachCard record, @Param("example") FacTeachCardExample example);

    int updateByPrimaryKeySelective(FacTeachCard record);

    int updateByPrimaryKey(FacTeachCard record);
}
