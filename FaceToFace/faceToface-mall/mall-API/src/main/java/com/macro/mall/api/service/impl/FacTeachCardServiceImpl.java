package com.macro.mall.api.service.impl;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;
import com.macro.mall.api.service.FacTeachCardService;
import com.macro.mall.api.service.FacTeachService;
import com.macro.mall.api.util.OssUtil;
import com.macro.mall.mapper.FacTeachCardMapper;
import com.macro.mall.model.FacTeachCard;
import com.macro.mall.model.FacTeachCardExample;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Service
public class FacTeachCardServiceImpl implements FacTeachCardService {

    private static final Logger LOG = LoggerFactory.getLogger(FacTeachCardServiceImpl.class);

    @Value("${aliyun.oss.bucketName}")
    private String bucketName;

    @Autowired
    private FacTeachCardMapper facTeachCardMapper;

    @Autowired
    private OSSClient ossClient;

    @Autowired
    private OssUtil ossUtil;

    @Override
    public int insert(FacTeachCard facTeachCard,MultipartFile files1, MultipartFile files2, MultipartFile files3)
    {

        String fileUrl1 = ossUtil.uploadImg2Oss(files1);
        String fileUrl2 = ossUtil.uploadImg2Oss(files2);
        String fileUrl3 = ossUtil.uploadImg2Oss(files3);

        facTeachCard.setFile_url1(fileUrl1);
        facTeachCard.setFile_url2(fileUrl2);
        facTeachCard.setFile_url3(fileUrl3);

        return facTeachCardMapper.insert(facTeachCard);

    }


   @Override
   public String getIconByUserid(String userid)
   {

//       selectByExample
       FacTeachCardExample example = new FacTeachCardExample();

       example.createCriteria().andUser_idEqualTo(userid);

       List <FacTeachCard> list = facTeachCardMapper.selectByExample(example);

       if (list.size()>0)
       {
           FacTeachCard facTeachCard = list.get(0);

           if (facTeachCard != null)
           {
               return facTeachCard.getFile_url1();
           }
       }

       return "" ;
   }

    @Override
    public FacTeachCard getTeachCardBy(String userid)
    {
        FacTeachCardExample example = new FacTeachCardExample();

        example.createCriteria().andUser_idEqualTo(userid);

        List <FacTeachCard> list = facTeachCardMapper.selectByExample(example);

        if (list.size()>0)
        {
            FacTeachCard facTeachCard = list.get(0);

            return  facTeachCard;
        }

        return null ;
    }



}
