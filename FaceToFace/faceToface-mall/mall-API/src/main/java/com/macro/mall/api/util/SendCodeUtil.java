package com.macro.mall.api.util;

import com.aliyun.oss.ClientException;
import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.http.MethodType;
import org.springframework.beans.factory.annotation.Value;

import java.rmi.ServerException;

public class SendCodeUtil {

    @Value("${aliyun.oss.accessKeyId}")
    private String accessKeyId;
    @Value("${aliyun.oss.accessKeySecret}")
    private String accessKeySecret;

//    public static void main(String[] args) {
//
//        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAIQDYu8xITN76T", "CAfRV1GhQlvx5mQOwROtDttZzEEoHm");
//        IAcsClient client = new DefaultAcsClient(profile);
//
//        CommonRequest request = new CommonRequest();
//        request.setMethod(MethodType.POST);
//
//        request.setDomain("dysmsapi.aliyuncs.com");
//        request.setVersion("2017-05-25");
//        request.setAction("SendSms");
//
//        request.putQueryParameter("RegionId", "cn-hangzhou");
//
//        request.putQueryParameter("PhoneNumbers", "15510373985");
//
//        request.putQueryParameter("SignName", "阿里云");
//        request.putQueryParameter("TemplateCode", "SMS_153055065");
//        try {
//            CommonResponse response = client.getCommonResponse(request);
//            System.out.println(response.getData());
//        } catch (ServerException e) {
//            e.printStackTrace();
//        } catch (ClientException e) {
//            e.printStackTrace();
//        }
//    }

//    public boolean sendCode(String mobile)
//    {
//        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "<accessKeyId>", "<accessSecret>");
//        IAcsClient client = new DefaultAcsClient(profile);
//
//        CommonRequest request = new CommonRequest();
//        request.setMethod(MethodType.POST);
//        request.setDomain("dysmsapi.aliyuncs.com");
//        request.setVersion("2017-05-25");
//        request.setAction("SendSms");
//        request.putQueryParameter("RegionId", "cn-hangzhou");
//        boolean flag = false;
//        try {
//            CommonResponse response = client.getCommonResponse(request);
//            System.out.println(response.getData());
//            flag = true ;
//        } catch (ServerException e) {
//            e.printStackTrace();
//        } catch (ClientException e) {
//            e.printStackTrace();
//        }
//        return flag;
//    }



}
