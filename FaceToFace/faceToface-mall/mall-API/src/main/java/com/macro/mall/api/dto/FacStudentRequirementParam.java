package com.macro.mall.api.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FacStudentRequirementParam {

    private String studentName;

    private String studentIphone;

    private String problem;

    //清华还是北大
    private String teachMajor;

    //其他内容
    private String other;

    //年级
    private String otherOne;


}
