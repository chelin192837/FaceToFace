package middleware

import (
	"encoding/json"
	"fmt"
	"github.com/e421083458/golang_common/lib"
	"github.com/gin-gonic/gin"
	"net/http"
	"strings"
)

type ResponseCode int

// 1000以下为通用码，1000以上为用户自定义码
// 常量码的定义
const (

	//SuccessCode ResponseCode = iota
	SuccessCode ResponseCode = 200

	UndefErrorCode

	ValidErrorCode

	InternalErrorCode

	InvalidRequestErrorCode ResponseCode = 401

	CustomizeCode           ResponseCode = 1000

	GROUPALL_SAVE_FLOWERROR ResponseCode = 2001

)

//给前端返回的数据结构 返回体数据结构的封装
type Response struct {
	ErrorCode ResponseCode `json:"errno"`
	ErrorMsg  string       `json:"errmsg"`
	Data      interface{}  `json:"data"`
	TraceId   interface{}  `json:"trace_id"`
	Stack     interface{}  `json:"stack"`
}

type AppResponse struct {
	Message string `json:"message"`
	Code  int       `json:"code"`
	Data      interface{}  `json:"data"`
}

// 返回的错误信息
func ResponseError(c *gin.Context, code ResponseCode, err error) {

	trace, _ := c.Get("trace")

	traceContext, _ := trace.(*lib.TraceContext)

	traceId := ""

	if traceContext != nil {
		traceId = traceContext.TraceId
	}

	stack := ""

	if c.Query("is_debug") == "1" || lib.GetConfEnv() == "dev" {
		stack = strings.Replace(fmt.Sprintf("%+v", err), err.Error()+"\n", "", -1)
	}

	resp := &Response{ErrorCode: code, ErrorMsg: err.Error(), Data: "", TraceId: traceId, Stack: stack}

	c.JSON(200, resp)

	response, _ := json.Marshal(resp)

	c.Set("response", string(response))

	c.AbortWithError(200, err)
}

//返回正确信息
func ResponseSuccess(c *gin.Context, data interface{}) {

	//跨中间件取值
	trace, _ := c.Get("trace")

	traceContext, _ := trace.(*lib.TraceContext)

	traceId := ""

	if traceContext != nil {
		traceId = traceContext.TraceId
	}

	resp := &Response{ErrorCode: SuccessCode, ErrorMsg: "", Data: data, TraceId: traceId}

	c.JSON(200, resp)

	response, _ := json.Marshal(resp)

	c.Set("response", string(response))

	}

func APPResponseSuccess(c *gin.Context, data interface{})  {

	appRes := &AppResponse{}

	appRes.Code = http.StatusOK

	appRes.Message = "请求成功"

	appRes.Data = data ;

	c.JSON(http.StatusOK,appRes)

}

func APPResponseFail(c *gin.Context, data interface{})  {

	appRes := &AppResponse{}

	appRes.Code = http.StatusBadRequest

	appRes.Message = "请求失败"

	appRes.Data = data;

	c.JSON(http.StatusBadRequest,appRes)

}
