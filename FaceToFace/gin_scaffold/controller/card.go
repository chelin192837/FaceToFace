package controller

import (
	"fmt"
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/gin-gonic/gin"
	"mime/multipart"
	"time"
)

type CardController struct {


}

//上传个人图片
func (t *CardController)card(c *gin.Context){


	//得到上传的文件
	_, header1, _ := c.Request.FormFile("files1") //image这个是uplaodify参数定义中的   'fileObjName':'image'
	//文件的名称
	filename1 := header1.Filename

    //得到上传的文件
	_, header2, _ := c.Request.FormFile("files2") //image这个是uplaodify参数定义中的   'fileObjName':'image'
	//文件的名称
	filename2 := header2.Filename


	//得到上传的文件
	_, header3, _ := c.Request.FormFile("files3") //image这个是uplaodify参数定义中的   'fileObjName':'image'
	//文件的名称
	filename3 := header3.Filename


	path1 := "/Users/mac/Desktop/Biconomy-Gate/BaseDev/gin_scaffold/resource/" + filename1


	if err := c.SaveUploadedFile(header1, path1); err != nil {

		//自己完成信息提示
		return
	}

	var files = [3](*multipart.FileHeader){header1,header2,header3}

	var filesname =  [3]string{filename1,filename2,filename3}

	var osspathArr []string

	for i := 0; i < 3; i++ {

		path1 := public.Linux_Path + filesname[i]

		if err := c.SaveUploadedFile(files[i], path1); err != nil {

			fmt.Println(err)

			//自己完成信息提示
		}

		mkdirStr := time.Now().Format("2006/01/02")

		ossFileName := fmt.Sprintf("%d%s%s",time.Now().Unix(),public.CurrentUser.ID,filesname[i])

		ossPath,err := public.UpToOSS(mkdirStr+"/" + ossFileName,path1)

		if err!=nil {

			response.ResponseFail(c,"上传失败")

			fmt.Println(ossPath)

		}

		osspathArr = append(osspathArr,ossPath)

	}

	faceCard := dao.FaceTeachcard{}

	tx:=public.DBCon

	ok:=faceCard.PhotoAuth(c,tx,osspathArr)

	if ok {
		response.ResponseSuccess(c,"")
		return
	}

	response.ResponseSuccess(c,"")

}

