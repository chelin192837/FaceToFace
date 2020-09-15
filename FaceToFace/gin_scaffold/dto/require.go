package dto


type RequireInput struct {

	Problem string `form:"problem" json:"problem" comment:"problem"  validate:"required" example:"" binding:"required"`

	StudentName string `form:"studentName" json:"studentName" comment:"studentName"  validate:"required" example:"" binding:"required"`

	Note string `form:"note" json:"note" comment:"note"  validate:"required" example:"" binding:"required"`

	ClassType string `form:"classType" json:"classType" comment:"classType"  validate:"required" example:"" binding:"required"`

	TeachMajor string `form:"teachMajor" json:"teachMajor" comment:"teachMajor"  validate:"required" example:"" binding:"required"`

}

type RequireListInput struct {

	Page int `form:"page" json:"page" comment:"page"  validate:"required" example:"" binding:"required"`

	Iphone string `form:"iphone" json:"iphone" comment:"iphone"  validate:"optional" example:"" binding:"optional"`

}
