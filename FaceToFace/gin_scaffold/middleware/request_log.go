
package middleware

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/golang_common/lib"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"time"
)

// 请求进入日志
// 请求日志的中间件
func RequestInLog(c *gin.Context) {

	traceContext := lib.NewTrace()

	// 获取请求头的基本信息
	if traceId := c.Request.Header.Get("com-header-rid"); traceId != "" {
		traceContext.TraceId = traceId
	}

    //
	if spanId := c.Request.Header.Get("com-header-spanid"); spanId != "" {
		traceContext.SpanId = spanId
	}

	//
	c.Set("startExecTime", time.Now())

	c.Set("trace", traceContext)

	//获取POST请求的请求体
	bodyBytes, _ := ioutil.ReadAll(c.Request.Body)

	var dat map[string]string

	json.Unmarshal(bodyBytes, &dat)

	//循环遍历Map
	for key,value:= range dat{
		fmt.Printf("this body is %s=>%s\n",key,value)
	}

	c.Request.Body = ioutil.NopCloser(bytes.NewBuffer(bodyBytes)) // Write body back

	//将POST请求参数打印出来
	lib.Log.TagInfo(traceContext, "_com_request_in", map[string]interface{}{
		"uri":    c.Request.RequestURI,
		"method": c.Request.Method,
		"args":   c.Request.PostForm,
		"body":   dat,
		"from":   c.ClientIP(),
	})

}

// 请求输出日志
// 输出日志请求
func RequestOutLog(c *gin.Context) {
	// after request
	endExecTime := time.Now()
	response, _ := c.Get("response")
	st, _ := c.Get("startExecTime")

	startExecTime, _ := st.(time.Time)
	public.ComLogNotice(c, "_com_request_out", map[string]interface{}{
		"uri":       c.Request.RequestURI,
		"method":    c.Request.Method,
		"args":      c.Request.PostForm,
		"from":      c.ClientIP(),
		"response":  response,
		"proc_time": endExecTime.Sub(startExecTime).Seconds(),
	})
}

//相当于执行两个函数 延迟执行RequestOutLog
func RequestLog() gin.HandlerFunc {
	return func(c *gin.Context) {

		RequestInLog(c)
		//defer RequestOutLog(c)

		c.Next()
	}

}



















