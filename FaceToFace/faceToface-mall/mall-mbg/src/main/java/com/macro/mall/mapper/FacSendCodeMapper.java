package com.macro.mall.mapper;




import com.macro.mall.model.FacSendCode;
import com.macro.mall.model.FacSendCodeExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FacSendCodeMapper {
    int countByExample(FacSendCodeExample example);

    int deleteByExample(FacSendCodeExample example);

    int deleteByPrimaryKey(Long id);

    int insert(FacSendCode record);

    int insertSelective(FacSendCode record);

    List<FacSendCode> selectByExample(FacSendCodeExample example);

    FacSendCode selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") FacSendCode record, @Param("example") FacSendCodeExample example);

    int updateByExample(@Param("record") FacSendCode record, @Param("example") FacSendCodeExample example);

    int updateByPrimaryKeySelective(FacSendCode record);

    int updateByPrimaryKey(FacSendCode record);
}
