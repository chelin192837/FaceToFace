package com.macro.mall.api.service;


import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacStudentRequirement;
import com.macro.mall.model.OmsOrder;

import java.util.List;

public interface FacStudentRequierService {

    int insert(FacStudentRequirement facStudentRequirement);

    /**
     * 需求查询
     */
    List<FacStudentRequirement> list(FacStudent facStudent,Integer pageSize, Integer pageNum);

}
