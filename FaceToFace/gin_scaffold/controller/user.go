package controller

import (
	"fmt"
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/gin-gonic/gin"
)

type UserController struct {


}

func (u* UserController)AllUserList(c *gin.Context)  {


	var listInput dto.ListPageInput

	if c.Bind(&listInput)==nil{

		fmt.Println(listInput)

		user := dao.FaceUser{}

		tx := public.DBCon

		list,_,error := user.AllPageList(c,tx, &listInput)

		if error==nil {

			response.ResponseSuccess(c,list)

			return
		}

		response.ResponseFail(c,"")

	}

}
