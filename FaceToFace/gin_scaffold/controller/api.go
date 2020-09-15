package controller

import (
	"encoding/json"
	"errors"
	"fmt"
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/middleware"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"strconv"
	"strings"
	"time"
)

//控制器层面
//从路由过来的第一层
//负责路由模块的分发
type ApiController struct {


}


//登录 退出 的路由分发
func ApiRegister(router *gin.RouterGroup) {
	curd := ApiController{}
	//router.POST("/login", curd.Login)
	router.POST("/login", curd.Login_)
	router.GET("/loginout", curd.LoginOut_)

}

//增删改查的路由分发
func ApiLoginRegister(router *gin.RouterGroup) {

	curd := ApiController{}

	curdUser := UserController{}

	router.GET("/user/listpage", curd.TeachList)

	router.GET("/user/alllistpage", curdUser.AllUserList)

	router.POST("/user/add", curd.AddTeach)

	router.POST("/user/edit", curd.EditTeach)

	router.POST("/user/remove", curd.RemoveTeach)

	router.POST("/user/batchremove", curd.BatchRemoveUser)


}



//登录
func (demo *ApiController) Login_(c *gin.Context) {

	//输入验证
	api := &dto.LoginInput{}

	if err := api.BindingValidParams(c); err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	//模拟登录存入session
	if api.Username == "admin" && api.Password == "123456" {
		session := sessions.Default(c)
		session.Set("user", api.Username)
		session.Save()
		//统一格式返回值
		middleware.ResponseSuccess(c, "")
		return
	}

	middleware.ResponseError(c, 2002, errors.New("账号或密码错误"))
	return
}

// 模拟退出 删除session
func (demo *ApiController) LoginOut_(c *gin.Context) {
	session := sessions.Default(c)
	session.Delete("user")
	session.Save()
	return
}


func (api *ApiController)TeachList(c *gin.Context)  {

	var listInput dto.ListPageInput

	if c.Bind(&listInput)==nil{

		fmt.Println(listInput)

		teach := dao.FaceTeach{}

		tx := public.DBCon

		list,error := teach.FaceTeachListForApi(c,tx,listInput)

		if error==nil {

			response.ResponseSuccess(c,list)

			return
		}

		response.ResponseFail(c,"")

	}

}






//获取用户列表
func (demo *ApiController) ListPage(c *gin.Context) {

	//参数验证
	//输入参数的验证统一放在dto层
	listInput := &dto.ListPageInput{}
	if err := listInput.BindingValidParams(c); err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	//分页插件
	if listInput.PageSize == 0 {
		listInput.PageSize = 10
	}

	// 统一获取 Gorm.DB
	tx := public.DBCon

	//从dao的User.go文件中调用方法执行操作
	userList, total, err := (&dao.User{}).PageList(c, tx, listInput)
	if err != nil {
		middleware.ResponseError(c, 2003, err)
		return
	}

	//返回参数放在dao中
	//dao中放置了model 放置了curd 放置了output参数
	m := &dao.ListPageOutput{
		List:  userList,
		Total: total,
	}
	//中间件中的统一返回格式
	middleware.ResponseSuccess(c, m)
	return
}

//添加用户
func (demo *ApiController) AddUser(c *gin.Context) {
	//输入参数的获取
	addInput := &dto.AddUserInput{}
	//参数绑定校验
	if err := addInput.BindingValidParams(c); err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	//获取数据库
	tx:=public.DBCon

	//构造用户插入模型 从addInput中获取传入的数据
	user := &dao.User{
		Name:  addInput.Name,
		Sex:   addInput.Sex,
		Age:   addInput.Age,
		Birth: addInput.Birth,
		Addr:  addInput.Addr,
	}
	//执行插入操作
	if err := user.Save(c, tx); err != nil {
		middleware.ResponseError(c, 2002, err)
		return
	}
	middleware.ResponseSuccess(c, "")
	return
}



func (api* ApiController)AddTeach(c *gin.Context){

	//构造参数绑定
	//获取POST请求的请求体
	bodyBytes, _ := ioutil.ReadAll(c.Request.Body)

	var dat map[string]interface{}

	json.Unmarshal(bodyBytes, &dat)

	//获取数据库
	tx := public.DBCon

	//查找User
	var teach dao.FaceTeach

	teach.UserId = public.Strval(dat["userid"])
	teach.Name = public.Strval(dat["name"])
	teach.Iphone = public.Strval(dat["iphone"])
	teach.Major = public.Strval(dat["major"])

	teach.Subject = public.Strval(dat["subject"])
	teach.Flag = public.Strval(dat["flag"])
	teach.Advantage = public.Strval(dat["advantage"])

	teach.Address = public.Strval(dat["address"])
	teach.Technology = public.Strval(dat["technology"])
	teach.Price = 200

	teach.CreateTime = time.Now().Format(public.TimeLayoutStr)


	if public.Strval(dat["sex"])=="1"{

		teach.Sex = "男"

	}else {
		teach.Sex = "女"

	}
	//这种写法很经典
	if err := tx.Save(&teach).Error; err != nil {
		response.ResponseFailMessage(c,"添加失败","添加失败")
	}
	response.ResponseSuccess(c,"")



}










//编辑yonghu
func (demo *ApiController) EditUser(c *gin.Context) {
	//参数绑定,校验参数
	editInput := &dto.EditUserInput{}
	if err := editInput.BindingValidParams(c); err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	//获取数据库
	tx := public.DBCon

	//查找User
	var user dao.User

	//SetCtx(public.GetGinTraceContext(c)) 本质上设置一下traceContext 不影响后续的操作
	tx.Where(&dao.User{Id: editInput.Id}).First(&user)

	user.Name = editInput.Name
	user.Sex = editInput.Sex
	user.Age = editInput.Age
	user.Birth = editInput.Birth
	user.Addr = editInput.Addr
	//编辑就是获取到对应的user进行再次存储
	if err := user.Save(c, tx); err != nil {
		middleware.ResponseError(c, 2003, err)
		return
	}
	middleware.ResponseSuccess(c, "")
	return
}

func (api *ApiController)EditTeach(c *gin.Context)  {

	//构造参数绑定
	//获取POST请求的请求体
	bodyBytes, _ := ioutil.ReadAll(c.Request.Body)

	var dat map[string]interface{}

	json.Unmarshal(bodyBytes, &dat)

	//获取数据库
	tx := public.DBCon

	//查找User
	var teach dao.FaceTeach

	var idStr string
	idStr = public.Strval(dat["id"])
	idInt,_ := strconv.Atoi(idStr)

	//SetCtx(public.GetGinTraceContext(c)) 本质上设置一下traceContext 不影响后续的操作
	tx.Where(&dao.FaceTeach{Id:idInt}).First(&teach)

	teach.Name = public.Strval(dat["name"])
	teach.Iphone = public.Strval(dat["iphone"])
	teach.Major = public.Strval(dat["major"])

	teach.Subject = public.Strval(dat["subject"])
	teach.Flag = public.Strval(dat["flag"])
	teach.Advantage = public.Strval(dat["advantage"])

	teach.Address = public.Strval(dat["address"])
	teach.Technology = public.Strval(dat["technology"])

	teach.CreateTime = time.Now().Format(public.TimeLayoutStr)


	if public.Strval(dat["sex"])=="1"{

		teach.Sex = "男"

	}else {
		teach.Sex = "女"

	}
	//这种写法很经典
	if err := tx.Save(teach).Error; err != nil {
		response.ResponseFailMessage(c,"修改失败","修改失败")
	}
	response.ResponseSuccess(c,"")

}


//批量删除
func (demo *ApiController) BatchRemoveUser(c *gin.Context) {

	//获取绑定数据
	removeInput := &dto.BatchRemoveUserInput{}
	if err := removeInput.BindingValidParams(c); err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	//获取数据库
	tx:=public.DBCon


	//在dao中 Where in 进行操作 来进行批量删除
	// 以逗号为分割符 组成数组
	if err := (&dao.User{}).Del(c, tx, strings.Split(removeInput.IDS, ",")); err != nil {
		middleware.ResponseError(c, 2002, err)
		return
	}
	middleware.ResponseSuccess(c, "")
	return
}

//移除用户
func (demo *ApiController) RemoveUser(c *gin.Context) {

	//获取参数
	removeInput := &dto.RemoveUserInput{}
	if err := removeInput.BindingValidParams(c); err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	//获取数据库
	tx:=public.DBCon

	if err := (&dao.User{}).Del(c, tx, strings.Split(removeInput.ID, ",")); err != nil {
		middleware.ResponseError(c, 2002, err)
		return
	}
	middleware.ResponseSuccess(c, "")
	return
}

func (api*ApiController)RemoveTeach(c *gin.Context) {

	var removeInput dto.RemoveUserInput

	if c.Bind(&removeInput) == nil {

		fmt.Println(removeInput)

		tx := public.DBCon

		idSlice := strings.Split(removeInput.ID,",")

		err:=tx.Where("id in (?)",idSlice).Delete(&dao.FaceTeach{}).Error
		if err==nil {
			response.ResponseSuccess(c,"")
		}

	}

	response.ResponseFailMessage(c, "删除失败", "删除失败")

}


// 删除方法 where in
//func () Del(c *gin.Context, tx *gorm.DB, idSlice []string) error {
//	err := tx.Where("id in (?)", idSlice).Delete(&User{}).Error
//	if err != nil {
//		return err
//	}
//	return nil
//}


