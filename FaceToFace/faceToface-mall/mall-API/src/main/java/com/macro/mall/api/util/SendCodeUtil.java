package com.macro.mall.api.util;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.ClientException;
import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.http.MethodType;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Value;

import java.rmi.ServerException;
import java.util.Random;

public class SendCodeUtil {

    public static final String SIGNNAME = "清北面对面";
    public static final String TEMPLATECODE = "SMS_182535698";

    public static final String ACCESS_KEYID = "LTAIQDYu8xITN76T";
    public static final String ACCESS_SECRET = "CAfRV1GhQlvx5mQOwROtDttZzEEoHm";

    public static final String REGIONID = "cn-beijing";



    //产品名称:云通信短信API产品,开发者无需替换
    static final String product = "Dysmsapi";
    //产品域名,开发者无需替换
    static final String domain = "dysmsapi.aliyuncs.com";

    public static String sendCode(String mobile)
    {

        DefaultProfile profile = DefaultProfile.getProfile(REGIONID, ACCESS_KEYID, ACCESS_SECRET);

        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();

        request.setMethod(MethodType.POST);

        request.setDomain("dysmsapi.aliyuncs.com");

        request.setVersion("2017-05-25");

        request.setAction("SendSms");

        request.putQueryParameter("RegionId", REGIONID);

        request.putQueryParameter("PhoneNumbers", mobile);

        request.putQueryParameter("SignName", SIGNNAME);

        request.putQueryParameter("TemplateCode", TEMPLATECODE);

        String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);//生成短信验证码

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",verifyCode);
        request.putQueryParameter("TemplateParam", jsonObject.toJSONString());

        String code = verifyCode;

        CommonResponse response = new CommonResponse();
        try {
            try {
                response = client.getCommonResponse(request);
            }catch (Exception e)
            {

            }
            System.out.println(response.getData());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return code;
    }



}
