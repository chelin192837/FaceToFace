package com.macro.mall.api.service.impl;

import com.macro.mall.api.service.FacConsultationService;
import com.macro.mall.mapper.FacConsultationMapper;
import com.macro.mall.model.FacConsultation;
import com.macro.mall.model.FacConsultationExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacConsultationServiceImpl implements FacConsultationService {

    @Autowired
    private FacConsultationMapper facConsultationMapper;

    @Override
    public int insert(FacConsultation facConsultation)
    {
        return facConsultationMapper.insert(facConsultation);
    }

    @Override
    public List<FacConsultation> getConsultationByDeviceId(String deviceId)
    {

        FacConsultationExample example = new FacConsultationExample();
        example.createCriteria().andDevice_idEqualTo(deviceId);
        return facConsultationMapper.selectByExample(example);
    }



}
