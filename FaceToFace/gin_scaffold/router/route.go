package router

import (
	"github.com/e421083458/gin_scaffold/controller"
	"github.com/e421083458/gin_scaffold/docs"
	"github.com/e421083458/gin_scaffold/middleware"
	"github.com/e421083458/golang_common/lib"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/swaggo/files"
	"github.com/swaggo/gin-swagger"
)

// @title Swagger Example API
// @version 1.0
// @description This is a sample server celler server.
// @termsOfService http://swagger.io/terms/

// @contact.name API Support
// @contact.url http://www.swagger.io/support
// @contact.email support@swagger.io

// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html

// @host localhost:8080
// @BasePath /api/v1
// @query.collection.format multi

// @securityDefinitions.basic BasicAuth

// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name Authorization

// @securitydefinitions.oauth2.application OAuth2Application
// @tokenUrl https://example.com/oauth/token
// @scope.write Grants write access
// @scope.admin Grants read and write access to administrative information

// @securitydefinitions.oauth2.implicit OAuth2Implicit
// @authorizationurl https://example.com/oauth/authorize
// @scope.write Grants write access
// @scope.admin Grants read and write access to administrative information

// @securitydefinitions.oauth2.password OAuth2Password
// @tokenUrl https://example.com/oauth/token
// @scope.read Grants read access
// @scope.write Grants write access
// @scope.admin Grants read and write access to administrative information

// @securitydefinitions.oauth2.accessCode OAuth2AccessCode
// @tokenUrl https://example.com/oauth/token
// @authorizationurl https://example.com/oauth/authorize
// @scope.admin Grants read and write access to administrative information

// @x-extension-openapi {"example": "value on a json format"}

//初始化路由 middlewares ... 后面三个... 代表什么  ;
func InitRouter(middlewares ...gin.HandlerFunc) *gin.Engine {
	// programatically set swagger info
	docs.SwaggerInfo.Title = lib.GetStringConf("base.swagger.title")
	docs.SwaggerInfo.Description = lib.GetStringConf("base.swagger.desc")
	docs.SwaggerInfo.Version = "1.0"
	docs.SwaggerInfo.Host = lib.GetStringConf("base.swagger.host")
	docs.SwaggerInfo.BasePath = lib.GetStringConf("base.swagger.base_path")
	docs.SwaggerInfo.Schemes = []string{"http", "https"}

	//开启服务
	router := gin.Default()

	// 统一获取 Gorm.DB
	// 进行自动迁移
	//tx, err := lib.GetGormPool("default")


	//db, err := gorm.Open("mysql", "root:192837abc@tcp(127.0.0.1:3306)/face?charset=utf8&parseTime=true&loc=Local")
	//
	//if err != nil {
	//	panic("数据库连接失败")
	//}
	//defer db.Close()
	//
	//public.DBCon = db

	router.Use(middlewares...)

	router.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	//demo Demo的接口组
	v1 := router.Group("/demo")

	//在这个组下面，使用下面的中间件
	v1.Use(middleware.RecoveryMiddleware(), middleware.RequestLog(), middleware.IPAuthMiddleware(), middleware.TranslationMiddleware())
	{
		controller.DemoRegister(v1)
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


	return router



}
