package controller

import "github.com/gin-gonic/gin"

//APP 端的路由分发
//登录 注册
func AppRegister(router *gin.RouterGroup)  {

	//登录注册模块
	curd := LoginController{}
	router.POST("/login", curd.Login)
	router.POST("/sendCode", curd.sendCode)

}

//App 正常业务逻辑
func AppNormalTeach(router *gin.RouterGroup){

	curd := TeachController{}

	require := RequireController{}

	consult := ConsultController{}

	router.POST("/discover/teacherlist", curd.teacherList)

	router.POST("/publish/requirelist", require.requireList)

	router.POST("/mine/consultation", consult.addConsult)

}

//提交认证	需要token
func AppNormalAuth(router *gin.RouterGroup){

	curd := TeachController{}

	card := CardController{}

	require := RequireController{}

	router.POST("/mine/auth", curd.auth)

	router.POST("/mine/card", card.card)

	router.POST("/publish/require", require.Addrequire)

}
