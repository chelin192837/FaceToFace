package main

import (
	"github.com/e421083458/gin_scaffold/controller"
	"github.com/e421083458/gin_scaffold/middleware"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/golang_common/lib"
	"github.com/e421083458/gorm"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

func main(){

	lib.InitModule("./conf/dev/",[]string{"base","redis",})

	//db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/face?charset=utf8&parseTime=true&loc=Local")

	db, err := gorm.Open("mysql", "root:192837abc@tcp(127.0.0.1:3306)/face?charset=utf8&parseTime=true&loc=Local")


	if err != nil {
		panic("数据库连接失败")
	}
	defer db.Close()

	public.DBCon = db

	//gin.SetMode("ReleaseMode")

	router := gin.Default()

	router.Use(middleware.Cors())

	////////////////////////////////////////////////////////////////////////////////// Demo项目 -----
	// VUE 网页端的网络映射
	demoNormalGroup := router.Group("/demo")

	demoNormalGroup.Use(middleware.RequestLog())
	{
		controller.DemoRegister(demoNormalGroup)
	}
	////////////////////////////////////////////////////////////////////////////////// 正式进入项目 -----

	//非登陆接口  --  正式进入项目业务逻辑 ---
	store := sessions.NewCookieStore([]byte("secret"))

	// VUE 网页端的网络映射
	apiNormalGroup := router.Group("/api")

	apiNormalGroup.Use(sessions.Sessions("mysession", store),
		middleware.RecoveryMiddleware(),
		middleware.RequestLog(),
		middleware.TranslationMiddleware())
	{
		controller.ApiRegister(apiNormalGroup)
	}

	//登陆接口
	apiAuthGroup := router.Group("/api")
	apiAuthGroup.Use(
		sessions.Sessions("mysession", store),
		middleware.RecoveryMiddleware(),
		middleware.RequestLog(),
		middleware.SessionAuthMiddleware(),
		middleware.TranslationMiddleware())
	{
		controller.ApiLoginRegister(apiAuthGroup)
	}


	//APP 微信小程序 登陆接口  --  正式进入项目业务逻辑 ---
	appNoarmalGroup := router.Group("/app")

	//不需要鉴权
	appNoarmalGroup.Use(middleware.RequestLog(),middleware.TranslationMiddleware())
	{
		//登录模块
		controller.AppRegister(appNoarmalGroup)

		controller.AppNormalTeach(appNoarmalGroup)

	}

	//需要token
	appNoarmalGroup.Use(middleware.JWTAuth(),middleware.RequestLog())
	{
		controller.AppNormalAuth(appNoarmalGroup)
	}

	router.Run(":9001")


	////////////////////////////////////////////////////////////////////////////////// golang_common 进入项目 -----

	//基础文件的配置
	//lib.InitModule("./conf/dev/",[]string{"base","mysql","redis",})
	//
	//defer lib.Destroy()

	//
	//router.HttpServerRun()
	//
	//quit := make(chan os.Signal)
	//
	//signal.Notify(quit, syscall.SIGKILL, syscall.SIGQUIT, syscall.SIGINT, syscall.SIGTERM)
	//
	//<-quit
	//
	//router.HttpServerStop()

}


