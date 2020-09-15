package dao

import (
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gorm"
	"github.com/gin-gonic/gin"
	"time"
)

type FaceTeach struct {
	Id         int    `form:"id" json:"id" gorm:"primary_key"`
	Name       string `form:"name" json:"name"`
	Iphone     string `form:"iphone" json:"iphone"`
	UserId     string `form:"user_id" json:"user_id"`
	Sex        string `form:"sex" json:"sex"`
	Major      string `form:"major" json:"major"`
	Subject    string `form:"subject" json:"subject"`
	Flag       string `form:"flag" json:"flag"`
	Advantage  string `form:"advantage" json:"advantage"`
	Price      int    `form:"price" json:"price"`
	Address    string `form:"address" json:"address"`
	Technology string `form:"technology" json:"technology"`
	CreateTime string `form:"create_time" json:"create_time"`
}

func (*FaceTeach) TableName() string {
	return "face_teach"
}


//构造登录成功后的输出
type TeachOutput struct {
	ID string `form:"id" json:"id" comment:"用户id"`
	Name string `form:"name" json:"name" comment:"姓名"`
	Iphone string `form:"iphone" json:"iphone" comment:"手机号"`
	Icon string `form:"icon" json:"icon" comment:"icon"`
	Sex string `form:"sex" json:"sex" comment:"sex"`
	Major string `form:"major" json:"major" comment:"major"`
	Subject string `form:"subject" json:"subject" comment:"subject"`
	Flag string `form:"flag" json:"flag" comment:"flag"`
	Price string `form:"price" json:"price" comment:"price"`
	Address string `form:"address" json:"address" comment:"address"`
	Technology string `form:"technology" json:"technology" comment:"technology"`
	Advantage string `form:"advantage" json:"advantage" comment:"advantage"`

	FileUrl1 string `form:"file_url1" json:"file_url1" comment:"file_url1"`
	FileUrl2 string `form:"file_url2" json:"file_url2" comment:"file_url2"`
	FileUrl3 string `form:"file_url3" json:"file_url3" comment:"file_url3"`
}

type TeachListOutput struct {

	List []TeachOutput `form:"list" json:"list" comment:"列表"`

}


type TeachListApiOutput struct {

	List []TeachOutput `form:"list" json:"list" comment:"列表"`
	total int `form:"total" json:"total" comment:"总页数"`
}

type AuthOutput struct {

	Status string 	`form:"status" json:"status"`

}

func (t *FaceTeach)Auth(c *gin.Context,tx *gorm.DB,auth dto.AuthInput)(AuthOutput,bool){

	//插入数据
	faceTeach := FaceTeach{}
	faceTeach.UserId = public.CurrentUser.ID
	faceTeach.Name = auth.Name
	faceTeach.Iphone = auth.Iphone
	faceTeach.Sex = auth.Sex
	faceTeach.Advantage = auth.Advantage
	faceTeach.Major = auth.Major
	faceTeach.Subject = auth.Subject
	faceTeach.Flag = auth.Flag
	faceTeach.Technology = auth.Technology
	faceTeach.Address = auth.Address
	faceTeach.Price = public.StudentPrice
    faceTeach.CreateTime = time.Now().Format(public.TimeLayoutStr)

	var teach FaceTeach

	ok:=tx.Where("user_id = ?",public.CurrentUser.ID).First(&teach).RecordNotFound()

	if ok{
		error := tx.Save(&faceTeach).Error
		if error==nil{
			return AuthOutput{Status:"保存成功"},false
		}
		return AuthOutput{Status:"保存失败"},true
	}

	return AuthOutput{Status:"保存失败"},true

}



func (t *FaceTeach)FaceTeachList(c *gin.Context,tx *gorm.DB,teach dto.TeachListInput) (TeachListOutput,error) {

	users := make([]TeachOutput, 0)

	Db := tx.Table("face_teach").Select("face_teach.*,file_url1,file_url2,file_url3")

	Db = Db.Joins("left join face_teachcard on face_teach.user_id = face_teachcard.user_id")

	page := teach.Page

	pageSize := teach.PageSize

	if page == 0{
		 page = 1
	}

	if pageSize==0 {
		pageSize = 10
	}

	if teach.SearchName != "" {

		if teach.SearchName == "学习方法" || teach.SearchName == "学习习惯"|| teach.SearchName == "择校就业"{
			Db = Db.Where("flag = ?", "单科满分")
		}

		if teach.SearchName == "家庭教育" || teach.SearchName == "课外扩展" ||teach.SearchName == "教育方法"{
			Db = Db.Where("flag = ?", "省三好学生")
		}

	}


	if teach.Sex != "" {
		Db = Db.Where("sex = ?", teach.Sex)
	}

	if teach.Subject != "" {
		Db = Db.Where("subject = ?", teach.Subject)
	}

	if teach.Major != "" {
		Db = Db.Where("major = ?", teach.Major)
	}

	if teach.Flag != "" {
		Db = Db.Where("flag = ?", teach.Flag)
	}

	//关联查询

	if page > 0 && pageSize > 0 {
		Db = Db.Limit(pageSize).Offset((page - 1) * pageSize)
	}

	if err := Db.Find(&users).Error; err != nil {

		return TeachListOutput{} , err

	}

	return TeachListOutput{List:users} , nil

}



func (t *FaceTeach)FaceTeachListForApi(c *gin.Context,tx *gorm.DB,teach dto.ListPageInput) (TeachListApiOutput,error) {

	users := make([]TeachOutput, 0)

	Db := tx.Table("face_teach").Select("face_teach.*,file_url1,file_url2,file_url3")

	Db = Db.Joins("left join face_teachcard on face_teach.user_id = face_teachcard.user_id")

	page := teach.Page

	pageSize := teach.PageSize

	if page == 0{
		page = 1
	}

	if pageSize==0 {
		pageSize = 10
	}

	if teach.Name != "" {
		Db = Db.Where("name = ?", teach.Name)
	}

	//关联查询
	if page > 0 && pageSize > 0 {
		Db = Db.Limit(pageSize).Offset((page - 1) * pageSize)
	}

	if err := Db.Find(&users).Error; err != nil {

		return TeachListApiOutput{} , err

	}

	var count int

	tx.Table("face_teach").Select("*").Count(&count)

	 totalPageNum := (count  +  pageSize  - 1) / pageSize

	return TeachListApiOutput{List:users,total:totalPageNum} , nil

}



