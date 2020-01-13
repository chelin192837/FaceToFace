package com.macro.mall.api.service;

import com.macro.mall.model.FacTeachCard;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface FacTeachCardService {


    int insert(FacTeachCard facTeachCard,MultipartFile files1, MultipartFile files2, MultipartFile files3);


    String getIconByUserid(String userid);

    FacTeachCard getTeachCardBy(String userid);


}

























