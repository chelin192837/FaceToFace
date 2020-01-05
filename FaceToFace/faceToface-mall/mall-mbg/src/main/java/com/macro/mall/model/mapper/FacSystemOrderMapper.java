package com.macro.mall.model.mapper;


import com.macro.mall.model.FacSystemOrder;
import com.macro.mall.model.FacSystemOrderExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacSystemOrderMapper {

    int countByExample(FacSystemOrderExample example);

    int deleteByExample(FacSystemOrderExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacSystemOrder record);

    int insertSelective(FacSystemOrder record);

    List<FacSystemOrder> selectByExample(FacSystemOrderExample example);

    FacSystemOrder selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacSystemOrder record, @Param("example") FacSystemOrderExample example);

    int updateByExample(@Param("record") FacSystemOrder record, @Param("example") FacSystemOrderExample example);

    int updateByPrimaryKeySelective(FacSystemOrder record);

    int updateByPrimaryKey(FacSystemOrder record);

}
