package public

type GlobalUser struct {

	ID string `form:"id" json:"id"`

	Iphone string  `form:"iphone" json:"iphone"`

	Name string `form:"name" json:"name"`

}

var CurrentUser GlobalUser

