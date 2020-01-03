package com.macro.mall.mapper;


import com.macro.mall.model.FacSystemOrder;

public interface FacSystemOrderMapper {
    int deleteByPrimaryKey(Long id);

    int insert(FacSystemOrder record);

    int insertSelective(FacSystemOrder record);

    FacSystemOrder selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(FacSystemOrder record);

    int updateByPrimaryKey(FacSystemOrder record);
}
