package com.macro.mall.mapper;


import com.macro.mall.model.FacTeach;

public interface FacTeachMapper {
    int deleteByPrimaryKey(Long id);

    int insert(FacTeach record);

    int insertSelective(FacTeach record);

    FacTeach selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(FacTeach record);

    int updateByPrimaryKey(FacTeach record);
}
