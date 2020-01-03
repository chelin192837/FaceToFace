package com.macro.mall.mapper;


import com.macro.mall.model.FacOrder;

public interface FacOrderMapper {
    int deleteByPrimaryKey(Long id);

    int insert(FacOrder record);

    int insertSelective(FacOrder record);

    FacOrder selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(FacOrder record);

    int updateByPrimaryKey(FacOrder record);
}
