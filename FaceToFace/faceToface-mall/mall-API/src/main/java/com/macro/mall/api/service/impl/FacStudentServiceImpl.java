package com.macro.mall.api.service.impl;

import com.macro.mall.api.service.FacStudentService;
import com.macro.mall.mapper.FacStudentMapper;
import com.macro.mall.model.FacStudent;
import com.macro.mall.model.FacStudentExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacStudentServiceImpl implements FacStudentService {


    @Autowired
    private FacStudentMapper facStudentMapper;

    @Override
    public List<FacStudent> listAll() {

        return null;
    }

    @Override
    public FacStudent selectByKey(Long id) {

        FacStudent facStudent = facStudentMapper.selectByPrimaryKey(id);

        return facStudentMapper.selectByPrimaryKey(id);
    }

    @Override
    public int insert(FacStudent facStudent)
    {
        return facStudentMapper.insert(facStudent);
    }

    @Override
    public int getCount()
    {
        return facStudentMapper.getcount();
    }

    @Override
    public int getIdByIphone(String iphone)
    {
        return facStudentMapper.getcount();
    }


    //判断用户名是否存在
    @Override
    public boolean userIsExist(String username)
    {
        return true;
    }

    //根据用户名查找对应密码，判断是否匹配
    @Override
    public boolean isValicateCorrect(String username,String password)
    {
        return true;
    }

    @Override
    public FacStudent getAdminByUsername(String username)
    {
        FacStudentExample example = new FacStudentExample();

        example.createCriteria().andIdEqualTo(Long.valueOf(username));
        List<FacStudent> adminList = facStudentMapper.selectByExample(example);

        if (adminList != null && adminList.size() > 0)
        {
            return adminList.get(0);
        }

        return null;
    }


}
