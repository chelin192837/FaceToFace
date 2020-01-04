package com.macro.mall.service;


import com.macro.mall.model.FacOrder;
import com.macro.mall.model.FacStudent;

import java.util.List;

public interface FacStudentService {

    /**
     * 查询所有学生
     */
    List<FacStudent> listAll();


    FacStudent selectByKey(Long id);

    int insert(FacStudent facStudent);

    int getCount();



}
