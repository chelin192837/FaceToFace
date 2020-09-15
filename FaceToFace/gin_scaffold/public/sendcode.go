package public

import (
	"encoding/json"
	"fmt"
	"github.com/aliyun/aliyun-oss-go-sdk/oss"
	"os"
	//"errors"
	"github.com/aliyun/alibaba-cloud-sdk-go/sdk"
	"github.com/aliyun/alibaba-cloud-sdk-go/sdk/requests"
	"github.com/go-kratos/kratos/pkg/log"
)

// todo: 替换为公司账号
const (
	SignName          = "清北面对面"
	REGION_ID         = "cn-shenzhen"
	ACCESS_KEY_ID     = "LTAIQDYu8xITN76T"
	ACCESS_KEY_SECRET = "CAfRV1GhQlvx5mQOwROtDttZzEEoHm"
	END_POINT = "oss-cn-beijing.aliyuncs.com"
	BUCKET_NAME = "liuying192837"
	BUCKET_ADDRESS = "https://liuying192837.oss-cn-beijing.aliyuncs.com/"
)



func SendSms(phone string, code string) (err error) {

	client, err := sdk.NewClientWithAccessKey(REGION_ID, ACCESS_KEY_ID, ACCESS_KEY_SECRET)
	if err != nil {
		log.Error("ali ecs client failed, err:%s", err.Error())
		return
	}

	request := requests.NewCommonRequest()                           // 构造一个公共请求
	request.Method = "POST"                                          // 设置请求方式
	request.Product = "Ecs"                                          // 指定产品
	request.Scheme = "https"                                         // https | http
	request.Domain = "dysmsapi.aliyuncs.com"                         // 指定域名则不会寻址，如认证方式为 Bearer Token 的服务则需要指定
	request.Version = "2017-05-25"                                   // 指定产品版本
	request.ApiName = "SendSms"                                      // 指定接口名
	request.QueryParams["RegionId"] = "cn-hangzhou"                  // 地区
	request.QueryParams["PhoneNumbers"] = phone                      //手机号
	request.QueryParams["SignName"] = SignName                       //阿里云验证过的项目名 自己设置
	request.QueryParams["TemplateCode"] = "SMS_182535698"            //阿里云的短信模板号 自己设置
	request.QueryParams["TemplateParam"] = "{\"code\":" + code + "}" //短信模板中的验证码内容 自己生成

	response, err := client.ProcessCommonRequest(request)
	if err != nil {
		log.Error("ali ecs client failed, err:%s", err.Error())
		return
	}
	log.Info(response.String())
	var message Message //阿里云返回的json信息对应的类
	//记得判断错误信息

	errcode := json.Unmarshal(response.GetHttpContentBytes(), &message)

	if errcode !=nil {

	}
	if message.Message != "OK" {
		//错误处理
		return
	}
	return nil
}


//json数据解析
type Message struct {
	Message   string
	RequestId string
	BizId     string
	Code      string
}

func handleError(err error) {
	fmt.Println("Error:", err)
	os.Exit(-1)
}

func UpToOSS(objectName string,localFileName string) (string,error) {

	client, err := oss.New(END_POINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET)

	if err != nil {
		handleError(err)
	}

	bucket,err := client.Bucket(BUCKET_NAME)

	if err != nil {

		handleError(err)

	}

	err = bucket.PutObjectFromFile(objectName,localFileName)

	if err != nil {

		handleError(err)

	}

	path := BUCKET_ADDRESS + objectName

	return path,err

}
