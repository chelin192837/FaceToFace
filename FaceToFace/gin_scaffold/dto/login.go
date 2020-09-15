package dto

import (
	"github.com/e421083458/gin_scaffold/public"
	"github.com/gin-gonic/gin"
)

type SendCodeInput struct {
	Iphone string `form:"iphone" json:"iphone" comment:"手机号"  validate:"required" example:"" binding:"required"`
}

func (params *SendCodeInput) BindingValidParams(c *gin.Context) error {
	return public.DefaultGetValidParams(c, params)
}

type UserLoginInput struct {
	Iphone string `form:"iphone" json:"iphone" comment:"手机号"  validate:"required" example:"" binding:"required"`
	Code string `form:"code" json:"code" comment:"验证码"  validate:"required" example:"" binding:"required"`
}






