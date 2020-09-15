package controller

import (
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/middleware"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/e421083458/golang_common/lib"
	"github.com/garyburd/redigo/redis"
	"github.com/gin-gonic/gin"
)

type DemoController struct {


}

//Demo 的注册路由的地方
func DemoRegister(router *gin.RouterGroup) {

	demo := DemoController{}

	router.GET("/index", demo.Index)

	router.Any("/bind", demo.Bind)

	router.GET("/dao", demo.Dao)

	router.GET("/redis", demo.Redis)

	router.POST("/video",demo.Video)

}

func (demo *DemoController) Index(c *gin.Context){


	middleware.ResponseSuccess(c, "")

	return
}


func (demo *DemoController) Dao(c *gin.Context) {

	tx, err := lib.GetGormPool("default")

	if err != nil {
		middleware.ResponseError(c, 2000, err)
		return
	}

	area, err := (&dao.Area{}).Find(c, tx, c.DefaultQuery("id", "1"))

	if err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	middleware.ResponseSuccess(c, area)

	return

}


//构造视频数据
func (demo* DemoController)Video(c *gin.Context)  {


	arr := []string{}

	//arr1 := make([]string,1)

	url1 := "https://liuying192837.oss-cn-beijing.aliyuncs.com/2020/video/1597722190018205.mp4"
	url2 := "https://liuying192837.oss-cn-beijing.aliyuncs.com/2020/video/1597722203575502.mp4"
	url3 := "https://liuying192837.oss-cn-beijing.aliyuncs.com/2020/video/1597722468728274.mp4"
	url4 := "https://liuying192837.oss-cn-beijing.aliyuncs.com/2020/video/1597722472969092.mp4"

	arr = append(arr,url1,url2,url3,url4)


	response.ResponseSuccess(c,arr)


}


func (demo *DemoController) Redis(c *gin.Context) {

	redisKey := "redis_key"

	// 设置 Redis  key - value 值
	lib.RedisConfDo(public.GetTraceContext(c),
		"default",
		"SET",
		redisKey, "redis_LY")

	// 获取 Redis value 值
	redisValue, err := redis.String(
		lib.RedisConfDo(public.GetTraceContext(c), "default",
			"GET",
			redisKey))

	if err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	middleware.ResponseSuccess(c, redisValue)

	return
}


// ListPage godoc
// @Summary 测试数据绑定
// @Description 测试数据绑定
// @Tags 用户
// @ID /demo/bind
// @Accept  json
// @Produce  json
// @Param polygon body dto.DemoInput true "body"
// @Success 200 {object} middleware.Response{data=dto.DemoInput} "success"
// @Router /demo/bind [post]

func (demo *DemoController) Bind(c *gin.Context) {

	params := &dto.DemoInput{}

	if err := params.BindingValidParams(c); err != nil {
		middleware.ResponseError(c, 2001, err)
		return
	}

	middleware.ResponseSuccess(c, params)

	return

}























































