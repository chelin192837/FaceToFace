package com.macro.mall.api.util;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import sun.misc.BASE64Encoder;

import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

public class FileUploadUtils {

    private static final Logger LOG = LoggerFactory.getLogger(FileUploadUtils.class);

    public static String getFileName(String userId) {
        //1、获取当前时间的毫秒数
        long currentTimeMillis = System.currentTimeMillis();
        //2、创建Random对象，获取0-999之间随机数
        Random random=new Random();
        int randomNum = random.nextInt(999);
        //3、最终的文件名
        //%03d: %是占位符 3:3位数  0:不够3位数补零   d:数字
        String fileName = currentTimeMillis + userId + String.format("%03d", randomNum);
        //4、返回文件名
        return fileName;
    }

}
