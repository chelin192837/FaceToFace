package com.macro.mall.api.service;


import com.macro.mall.model.FacConsultation;

import java.util.List;

public interface FacConsultationService {

    int insert(FacConsultation facConsultation);

    List<FacConsultation> getConsultationByDeviceId(String deviceId);


}
