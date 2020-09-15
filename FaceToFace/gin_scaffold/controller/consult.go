package controller

import (
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/gin-gonic/gin"
)

type ConsultController struct {

}

func (f *ConsultController)addConsult(c *gin.Context)  {

	var consult dto.ConsultInput


	if c.BindJSON(&consult)==nil {

		f := dao.FaceConsult{}

		tx:=public.DBCon

		error := f.SaveConsult(c,tx,consult)

		if error==nil {
			response.ResponseSuccessMessage(c,"","保存成功")
			return
		}

	}

	response.ResponseFail(c,"")

}
