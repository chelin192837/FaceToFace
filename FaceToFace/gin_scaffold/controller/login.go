package controller

import (
	"fmt"
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/gin-gonic/gin"
	"math/rand"
	"time"
)


type LoginController struct {





}




func (login * LoginController)sendCode(c *gin.Context){

	var code dto.SendCodeInput

	if c.Bind(&code) == nil {
		//生产6位数随机数
		rnd := rand.New(rand.NewSource(time.Now().UnixNano()))

		vcode := fmt.Sprintf("%06v", rnd.Int31n(1000000))

		fmt.Println(vcode)

		codeModel := &dao.FaceCode{}

		codeModel.Code = vcode

		codeModel.Iphone = code.Iphone

		codeModel.Status = dao.SuccessCode

		codeModel.Exptime = time.Now().Add(5 * time.Minute)

		tx:=public.DBCon

		//重置以前的验证码状态
		if error := codeModel.ResetStatus(c,tx);error != nil {
			response.ResponseFail(c,"")
			return
		}

		if error:=codeModel.Save(c,tx);error != nil{
			response.ResponseFail(c,"")
			return
		}else{

			//开始发送短信
		  if error := public.SendSms(code.Iphone,vcode);error==nil{
		  	response.ResponseSuccess(c,"验证码发送成功")
		  	return
		  }

		}

      }

	response.ResponseFail(c,"")

}

func (login * LoginController)Login(c *gin.Context){

	var userLogin dto.UserLoginInput

	if c.Bind(&userLogin) == nil {

		//判断验证码是否有效
		//通过用户名获取验证码
		tx:=public.DBCon
		var code dao.FaceCode
        tx.Where("iphone = ? AND status = ?",userLogin.Iphone,dao.SuccessCode).First(&code)
		//验证不通过
		//放行666666
		if userLogin.Code != "666666" {
			if code.Iphone != userLogin.Iphone {
				response.ResponseFailMessage(c,"","验证码错误")
				return
			}
		}

		user := &dao.FaceUser{}

		var count int

		tx.Table("face_user").Count(&count)

		user.Username = fmt.Sprintf("%s%d","同学",count)

		user.Iphone = userLogin.Iphone

		usernew,error := user.UserSave(c,tx)

		if error != nil{
			response.ResponseFailMessage(c,"","未知错误")
			return
		}

		//登录成功 给App返回token

		token,error := usernew.GetToken(c,tx)

		if error != nil {
			response.ResponseFailMessage(c,"","未知错误")
		}

		response.ResponseSuccess(c,token)

		return

	}

	response.ResponseFailMessage(c,"","未知错误")


}
