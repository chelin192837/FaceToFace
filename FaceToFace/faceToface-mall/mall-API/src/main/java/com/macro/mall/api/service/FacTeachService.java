package com.macro.mall.api.service;

import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacStudentRequirement;
import com.macro.mall.model.FacTeach;

import java.util.List;

public interface FacTeachService {

    int insert(FacTeach facTeach);

    /**
     * 教师资源查询
     */
    List<FacTeach> list(FacStudent facStudent, Integer pageSize, Integer pageNum);






}
