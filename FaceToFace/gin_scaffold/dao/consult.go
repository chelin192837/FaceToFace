package dao

import (
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gorm"
	"github.com/gin-gonic/gin"
	"time"
)

type FaceConsult struct {

	gorm.Model

	DeviceId string `form:"device_id" json:"device_id" gorm:"column:device_id"`

	Iphone string `form:"iphone" json:"iphone" gorm:"column:iphone"`

	Consultation string `form:"consultation" json:"consultation" gorm:"column:consultation"`

}

func (f*FaceConsult)TableName()string  {
	return "face_consult"
}


func (f* FaceConsult)SaveConsult(c *gin.Context,tx *gorm.DB,consultInput dto.ConsultInput)error {

	consult := FaceConsult{}

	consult.Consultation = consultInput.Consultation

	consult.DeviceId = consultInput.DeviceId

	consult.Iphone = consultInput.Iphone

	consult.CreatedAt = time.Now()

	consult.UpdatedAt = time.Now()

	if error:=tx.Create(&consult).Error;error!=nil{

		return error
	}

	return nil

}
