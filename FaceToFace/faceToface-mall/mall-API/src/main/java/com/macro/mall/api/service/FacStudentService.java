package com.macro.mall.api.service;

import com.macro.mall.model.FacStudent;

import java.util.List;

public interface FacStudentService {

    /**
     * 查询所有学生
     */
    List<FacStudent> listAll();


    FacStudent selectByKey(Long id);

    FacStudent selectByIphone(String iphone);

    int insert(FacStudent facStudent);

    int getCount();

    int getIdByIphone(String iphone);

    //判断用户名是否存在
    boolean userIsExist(String username);
    //根据用户名查找对应密码，判断是否匹配

    boolean isValicateCorrect(String username, String password);

    FacStudent getAdminByUsername(String username);



}
