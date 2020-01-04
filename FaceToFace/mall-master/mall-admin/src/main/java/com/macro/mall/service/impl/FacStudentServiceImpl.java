package com.macro.mall.service.impl;

import com.macro.mall.mapper.FacStudentMapper;

import com.macro.mall.model.FacStudent;

import com.macro.mall.service.FacStudentService;
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



}
