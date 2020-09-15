package dto


type TeachListInput struct {

	Page int `form:"page" json:"page" comment:"页数" example:"" binding:"required"`

	PageSize int `form:"pagesize" json:"pagesize" comment:"pagesize" example:"" binding:"required"`

	SearchName string `form:"searchName" json:"searchName" comment:"searchName" example:"" binding:"required"`

	Sex string `form:"sex" json:"sex" comment:"sex" example:"" binding:"required"`

	Major string `form:"major" json:"major" comment:"major"  example:"" binding:"required"`

	Subject string `form:"subject" json:"subject" comment:"subject" example:"" binding:"required"`

	Flag string `form:"flag" json:"flag" comment:"flag"  example:"" binding:"required"`

}


type AuthInput struct {

	Iphone string `form:"iphone" json:"iphone" comment:"手机号"  validate:"required" example:"" binding:"required"`
	Name string `form:"name" json:"name" comment:"name"  validate:"required" example:"" binding:"required"`
	Sex string `form:"sex" json:"sex" comment:"sex"  validate:"required" example:"" binding:"required"`
	Age string `form:"age" json:"age" comment:"age"  validate:"required" example:"" binding:"required"`
	Major string `form:"major" json:"major" comment:"major"  validate:"required" example:"" binding:"required"`
	Subject string `form:"subject" json:"subject" comment:"subject"  validate:"required" example:"" binding:"required"`
	Flag string `form:"flag" json:"flag" comment:"flag"  validate:"required" example:"" binding:"required"`
	Technology string `form:"technology" json:"technology" comment:"technology"  validate:"required" example:"" binding:"required"`
	Address string `form:"address" json:"address" comment:"address"  validate:"required" example:"" binding:"required"`
	Advantage string `form:"advantage" json:"advantage" comment:"advantage"  validate:"required" example:"" binding:"required"`
}
