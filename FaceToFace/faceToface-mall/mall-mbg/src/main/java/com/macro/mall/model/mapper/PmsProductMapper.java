package com.macro.mall.model.mapper;

import com.macro.mall.model.PmsProduct;
import com.macro.mall.model.PmsProductExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PmsProductMapper {
    long countByExample(PmsProductExample example);

    //批量删除
    int deleteByExample(PmsProductExample example);

    //单个删除
    int deleteByPrimaryKey(Long id);

    int insert(PmsProduct record);

    int insertSelective(PmsProduct record);

    List<PmsProduct> selectByExampleWithBLOBs(PmsProductExample example);

    List<PmsProduct> selectByExample(PmsProductExample example);

    PmsProduct selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") PmsProduct record, @Param("example") PmsProductExample example);

    int updateByExampleWithBLOBs(@Param("record") PmsProduct record, @Param("example") PmsProductExample example);

    int updateByExample(@Param("record") PmsProduct record, @Param("example") PmsProductExample example);

    int updateByPrimaryKeySelective(PmsProduct record);

    int updateByPrimaryKeyWithBLOBs(PmsProduct record);

    int updateByPrimaryKey(PmsProduct record);
}