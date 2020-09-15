package dao

import (
	jwtgo "github.com/dgrijalva/jwt-go"
	"github.com/e421083458/gin_scaffold/middleware"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gorm"
	"github.com/gin-gonic/gin"
	"time"
)


// 常量码的定义
const (

	SuccessCode int = 1

	FailCode int = 2
)

type FaceCode struct {

	gorm.Model

	Iphone string  `json:"iphone" gorm:"column:iphone"`

	Code string `json:"code" gorm:"column:code"`

	Status int `json:"status" gorm:"column:status"`

	Exptime time.Time `json:"exptime" gorm:"column:exptime"`

}
func (f *FaceCode) TableName() string {
	return "face_code"
}

type FaceUser struct {

	gorm.Model

	Username string `json:"username" gorm:"column:username"`

	Iphone string `json:"iphone" gorm:"column:iphone"`

}

func (f *FaceUser)TableName()string{

	return "face_user"

}

//构造登录成功后的输出
type LoginOutput struct {

	ID string `form:"id" json:"id" comment:"用户id"`
	Name string `form:"name" json:"name" comment:"姓名"`
	Iphone string `form:"iphone" json:"iphone" comment:"手机号"`
	Token string `form:"token" json:"token" comment:"token"`
}


func (f *FaceCode)Save(c *gin.Context,tx *gorm.DB)error {

	if error := tx.Save(f).Error;error != nil {

		return error
	}

	return nil

}

//保存
func (f *FaceUser)UserSave(c *gin.Context,tx *gorm.DB)(FaceUser,error){

	var user FaceUser

	ok:=tx.Where("iphone = ?",f.Iphone).First(&user).RecordNotFound()

	if ok{
		error := tx.Save(f).Error
		if error==nil{
			var newuser FaceUser
			tx.Where("iphone = ?",f.Iphone).First(&newuser)
			return newuser,nil
		}
		return user,error
	}

	return user,nil

}

func (f *FaceCode)ResetStatus(c *gin.Context,tx *gorm.DB) error {

	//批量更新
    if error := tx.Model(FaceCode{}).Where("iphone = ?",f.Iphone).Updates(FaceCode{Status:FailCode}).Error;error != nil{
    	return error
	}

	return nil
}

//给前端用户生成token
func (f *FaceUser)GetToken(c *gin.Context,tx *gorm.DB) (LoginOutput,error){

    return GenerateToken(c,f)

}



// 生成令牌
func GenerateToken(c *gin.Context, user *FaceUser)(LoginOutput,error){

	j :=&middleware.JWT{
		[]byte("newtrekWang"),
	}

	claims := middleware.CustomClaims{
		public.Strval(user.ID),
		user.Username,
		user.Iphone,
		jwtgo.StandardClaims{
			NotBefore: int64(time.Now().Unix() - 1000), // 签名生效时间
			ExpiresAt: int64(time.Now().Unix() + 36000000000000), // 过期时间 一小时
			Issuer:    "newtrekWang",                   //签名的发行者
		},
	}

	token, err := j.CreateToken(claims)

	if err != nil {

		return LoginOutput{},err
	}

	loginout := LoginOutput{}

	loginout.ID = string(user.ID)

	loginout.Iphone = user.Iphone

	loginout.Name = user.Username

	loginout.Token = token

	return loginout , nil
}
