package response

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Response struct {
	Message string `json:"message"`
	Code  int       `json:"code"`
	Data      interface{}  `json:"data"`
}

func ResponseSuccess(c *gin.Context,data interface{})  {

	response := &Response{}

	response.Message = "请求成功"

	response.Code = http.StatusOK

	response.Data = data

	c.JSON(http.StatusOK,response)

}

func ResponseFail(c *gin.Context,data interface{})  {

	response := &Response{}

	response.Message = "未知错误"

	response.Code = http.StatusBadRequest

	response.Data = data

	c.JSON(http.StatusBadRequest,response)

}

func ResponseFailMessage(c *gin.Context,data interface{},message string)  {

	response := &Response{}

	response.Message = message

	response.Code = http.StatusBadRequest

	response.Data = data

	c.JSON(http.StatusBadRequest,response)

}

func ResponseFailMessageCode(c *gin.Context,data interface{},message string,code int)  {

	response := &Response{}

	response.Message = message

	response.Code = code

	response.Data = data

	c.JSON(http.StatusBadRequest,response)

}


func ResponseSuccessMessage(c *gin.Context,data interface{},message string)  {

	response := &Response{}

	response.Message = message

	response.Code = http.StatusOK

	response.Data = data

	c.JSON(http.StatusOK,response)

}
