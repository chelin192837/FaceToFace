package com.macro.mall.mapper;


import com.macro.mall.model.FacStudent;

import java.util.List;

public interface FacStudentMapper {

    int deleteByPrimaryKey(Long id);

    int insert(FacStudent record);

    int insertSelective(FacStudent record);

    FacStudent selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(FacStudent record);

    int updateByPrimaryKey(FacStudent record);

}
