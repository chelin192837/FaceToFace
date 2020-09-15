package dao

import (
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gorm"
	"github.com/gin-gonic/gin"
	"time"
)

type FaceTeachcard struct {
	Id         int    `form:"id" json:"id" gorm:"primary_key"`
	UserId     string `form:"user_id" json:"user_id"`
	Icon       string `form:"icon" json:"icon"`
	FileUrl1   string `form:"file_url1" json:"file_url1"`
	FileUrl2   string `form:"file_url2" json:"file_url2"`
	FileUrl3   string `form:"file_url3" json:"file_url3"`
	Status     string `form:"status" json:"status"`
	Remark     string `form:"remark" json:"remark"`
	CreateTime string `form:"create_time" json:"create_time"`
}

func (*FaceTeachcard) TableName() string {
	return "face_teachcard"
}


func (t * FaceTeachcard)PhotoAuth(c *gin.Context,tx *gorm.DB,picArr []string)bool{

	faceTeachCard := FaceTeachcard{}
	faceTeachCard.UserId = public.CurrentUser.ID
	faceTeachCard.Icon = picArr[0]
	faceTeachCard.FileUrl1 = picArr[0]
	faceTeachCard.FileUrl2 = picArr[1]
	faceTeachCard.FileUrl3 = picArr[2]
	faceTeachCard.Status = "pending"
	faceTeachCard.Remark = "身份认证"
	faceTeachCard.CreateTime = time.Now().Format(public.TimeLayoutStr)

	ok:=tx.Where("user_id = ?",public.CurrentUser.ID).First(&t).RecordNotFound()

	if ok{

		tx.Save(&faceTeachCard)

		return true
	}

	return false

}

