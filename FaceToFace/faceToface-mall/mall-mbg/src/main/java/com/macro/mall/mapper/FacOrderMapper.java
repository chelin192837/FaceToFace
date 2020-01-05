package com.macro.mall.mapper;


import com.macro.mall.model.FacOrder;
import com.macro.mall.model.FacOrderExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacOrderMapper {

    int countByExample(FacOrderExample example);

    int deleteByExample(FacOrderExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacOrder record);

    int insertSelective(FacOrder record);

    List<FacOrder> selectByExample(FacOrderExample example);

    FacOrder selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacOrder record, @Param("example") FacOrderExample example);

    int updateByExample(@Param("record") FacOrder record, @Param("example") FacOrderExample example);

    int updateByPrimaryKeySelective(FacOrder record);

    int updateByPrimaryKey(FacOrder record);
}
