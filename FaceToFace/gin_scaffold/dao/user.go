package dao

import (
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gorm"
	"github.com/gin-gonic/gin"
	"time"
)

// 分页开发 构造输出数据
type ListPageOutput struct {
	List  []User `form:"list" json:"list" comment:"用户列表" validate:""`
	Total int64  `form:"page" json:"page" comment:"用户总数" validate:"required"`
}


// 分页开发 构造输出数据
type AllListPageOutput struct {
	List  []FaceUser `form:"list" json:"list" comment:"用户列表" validate:""`
	Total int64  `form:"page" json:"page" comment:"用户总数" validate:"required"`
}

// User 模型
type User struct {
	Id        int       `json:"id" gorm:"column:id"`
	Name      string    `json:"name" gorm:"column:name"`
	Addr      string    `json:"addr" gorm:"column:addr"`
	Age       int       `json:"age" gorm:"column:age"`
	Birth     string    `json:"birth" gorm:"column:birth"`
	Sex       int       `json:"sex" gorm:"column:sex"`
	UpdatedAt time.Time `json:"update_at" gorm:"column:update_at"" description:"更新时间"`
	CreatedAt time.Time `json:"create_at" gorm:"column:create_at" description:"创建时间"`
}


func (f *User) TableName() string {
	return "user"
}








// 删除方法 where in
func (f *User) Del(c *gin.Context, tx *gorm.DB, idSlice []string) error {
	err := tx.Where("id in (?)", idSlice).Delete(&User{}).Error
	if err != nil {
		return err
	}
	return nil
}

// 查找方法
func (f *User) Find(c *gin.Context, tx *gorm.DB, id int64) (*User, error) {
	var user *User


	//err := tx.SetCtx(public.GetGinTraceContext(c)).Where(&User{Id:id}).First(&user).Error

	err := tx.Where("id = ?", id).First(user).Error

	//db.Where(&User{Name: "jinzhu", Age: 20}).First(&user)

	//tx.SetCtx(public.GetGinTraceContext(c)).First(user)

	//err := tx.Where("id = ?", id).First(user).Error
	//


	if err != nil {
		return nil, err
	}

	return user, nil

}


//分页方法
func (f *User) PageList(c *gin.Context, tx *gorm.DB, params *dto.ListPageInput) ([]User, int64, error) {
	var list []User
	var count int64
	offset := (params.Page - 1) * params.PageSize // 设置偏移量
	query := tx
	//自定义查询条件
	if params.Name != "" {
		query = query.Where("name = ?", params.Name)
	}

	//用limit和offset构造分页的方法
	err := query.Limit(params.PageSize).Offset(offset).Find(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return nil, 0, err
	}

	// query : 构造query来进行分步骤查询
	//.Error : 获取错误方法
	errCount := query.Table("user").Count(&count).Error
	if errCount != nil {
		return nil, 0, err
	}
	return list, count, nil
}

func (f *FaceUser) AllPageList(c *gin.Context, tx *gorm.DB, params *dto.ListPageInput) (AllListPageOutput, int64, error) {
	var list []FaceUser
	var count int64
	if params.Page == 0{
		params.Page = 1
	}
	if params.PageSize==0 {
		params.PageSize = 10
	}
	offset := (params.Page - 1) * params.PageSize // 设置偏移量
	query := tx
	//自定义查询条件
	if params.Name != "" {
		query = query.Where("name = ?", params.Name)
	}

	//用limit和offset构造分页的方法
	err := query.Limit(params.PageSize).Offset(offset).Find(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return AllListPageOutput{}, 0, err
	}

	// query : 构造query来进行分步骤查询
	//.Error : 获取错误方法
	errCount := query.Table("face_user").Count(&count).Error
	if errCount != nil {
		return AllListPageOutput{}, 0, err
	}

	return AllListPageOutput{List:list,Total:count}, count, nil

}







//存储
func (f *User) Save(c *gin.Context, tx *gorm.DB) error {
	//这种写法很经典
	if err := tx.Save(f).Error; err != nil {
		return err
	}
	return nil
}
