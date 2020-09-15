package dao

import (
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gorm"
	"github.com/gin-gonic/gin"
)

type FaceStuquire struct {
	Id             int    `form:"id" json:"id" gorm:"primary_key"`
	StudentName    string `form:"student_name" json:"student_name"`
	StudentIphone  string `form:"student_iphone" json:"student_iphone"`
	TeachFlag      string `form:"teach_flag" json:"teach_flag"`
	TeachSex       string `form:"teach_sex" json:"teach_sex"`
	TeachMajor     string `form:"teach_major" json:"teach_major"`
	TeachSubject   string `form:"teach_subject" json:"teach_subject"`
	TeachAdvantage string `form:"teach_advantage" json:"teach_advantage"`
	Problem        string `form:"problem" json:"problem"`
	Other          string `form:"other" json:"other"`
	ClassType      string `form:"class_type" json:"class_type"`
	CreateTime     string `form:"create_time" json:"create_time"`
}

type RequireListOutPut struct {

	List []RequireOutPut `form:"list" json:"list" comment:"列表"`

}

type RequireOutPut struct {

	ID string `form:"id" json:"id" comment:"用户id"`
	StudentName string `form:"student_name" json:"student_name" comment:"student_name"`
	StudentIphone string `form:"student_iphone" json:"student_iphone" comment:"student_iphone"`
	TeachMajor string `form:"teach_major" json:"teach_major" comment:"teach_major"`
	Problem string `form:"problem" json:"problem" comment:"problem"`
	Other string `form:"other" json:"other" comment:"other"`
	ClassType string `form:"classType" json:"classType" comment:"classType"`
	OtherTwo string `form:"other_two" json:"other_two" comment:"other_two"`
	CreateTime string `form:"create_time" json:"create_time" comment:"create_time"`
}



func (*FaceStuquire) TableName() string {
	return "face_stuquire"
}


func (f *FaceStuquire)AddRequire(c *gin.Context,tx *gorm.DB)error{

	if error:= tx.Save(f).Error;error != nil {

		return error
	}

	return nil
}

func (f *FaceStuquire)RequireList(c *gin.Context,tx *gorm.DB,requireInput dto.RequireListInput)(RequireListOutPut,error){

	requires := make([]RequireOutPut, 0)

	DB:=tx.Table("face_stuquire").Select("id,student_name,student_iphone,teach_major,problem,other,class_type,create_time")

	var page int = requireInput.Page

	var pageSize int = 10

	if  requireInput.Iphone != ""{
		DB=DB.Where("student_iphone = ?" , requireInput.Iphone)
	}


	DB=DB.Limit(pageSize).Offset((page-1)*pageSize).Order("create_time desc")

	if error:= DB.Find(&requires).Error;error!=nil{
		return RequireListOutPut{} , error
	}

	return RequireListOutPut{List:requires} , nil

}


































