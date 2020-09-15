package controller

import (
	"encoding/json"
	"fmt"
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"strconv"
	"time"
)

type RequireController struct {



}



func (r *RequireController)Addrequire(c *gin.Context){

	var input dto.RequireInput

	if c.BindJSON(&input)==nil {

		fmt.Println(input)

		require := dao.FaceStuquire{}

		require.StudentName = input.StudentName

		require.StudentIphone = public.CurrentUser.Iphone

		require.Other = input.Note

		require.Problem = input.Problem

		require.ClassType = input.ClassType

		require.TeachMajor = input.TeachMajor

		require.CreateTime = time.Now().Format(public.TimeLayoutStr)

		tx:=public.DBCon

		error :=require.AddRequire(c,tx)

		if error ==nil {
			response.ResponseSuccess(c,"")
			return
		}

	}

	response.ResponseFailMessage(c,"","请求失败")

}


func (r *RequireController)requireList(c *gin.Context){

	bodyBytes, _ := ioutil.ReadAll(c.Request.Body)

	var dat map[string]interface{}

	json.Unmarshal(bodyBytes, &dat)

	requireInput := dto.RequireListInput{}

	pageStr := public.Strval(dat["page"])

	pageInt,_ := strconv.Atoi(pageStr)

	requireInput.Page = pageInt

	requireInput.Iphone = public.Strval(dat["iphone"])

	require := dao.FaceStuquire{}

	tx:=public.DBCon

	list,_ :=require.RequireList(c,tx,requireInput)

	response.ResponseSuccess(c,list)

}
