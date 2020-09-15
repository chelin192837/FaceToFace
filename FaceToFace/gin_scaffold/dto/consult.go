package dto


type ConsultInput struct {
	Iphone string `form:"iphone" json:"iphone" comment:"手机号"  validate:"required" example:"" binding:"required"`
	DeviceId string `form:"Device_id" json:"Device_id" comment:"Device_id"  validate:"required" example:"" binding:"required"`
	Consultation string `form:"consultation" json:"consultation" comment:"consultation"  validate:"required" example:"" binding:"required"`
}

