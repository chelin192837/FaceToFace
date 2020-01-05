package com.macro.mall.mapper;


import com.macro.mall.model.FacTeach;
import com.macro.mall.model.FacTeachExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacTeachMapper {
    int countByExample(FacTeachExample example);

    int deleteByExample(FacTeachExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacTeach record);

    int insertSelective(FacTeach record);

    List<FacTeach> selectByExample(FacTeachExample example);

    FacTeach selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacTeach record, @Param("example") FacTeachExample example);

    int updateByExample(@Param("record") FacTeach record, @Param("example") FacTeachExample example);

    int updateByPrimaryKeySelective(FacTeach record);

    int updateByPrimaryKey(FacTeach record);
}
