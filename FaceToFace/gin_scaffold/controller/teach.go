package controller

import (
	"encoding/json"
	"github.com/e421083458/gin_scaffold/dao"
	"github.com/e421083458/gin_scaffold/dto"
	"github.com/e421083458/gin_scaffold/public"
	"github.com/e421083458/gin_scaffold/response"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"strconv"
)

type TeachController struct {


}



//老师认证
func (t*TeachController)auth(c *gin.Context) {

	bodyBytes, _ := ioutil.ReadAll(c.Request.Body)

	var dat map[string]interface{}

	json.Unmarshal(bodyBytes, &dat)

	authInput := dto.AuthInput{}

	iphone,ok := dat["iphone"]
	if !ok {
		authInput.Iphone = ""
	}else {
		authInput.Iphone = t.Strval(iphone)
	}

	major,ok := dat["major"]
	if !ok {
		authInput.Major = ""
	}else {
		authInput.Major = t.Strval(major)
	}

	address,ok := dat["address"]
	if !ok {
		authInput.Address = ""
	}else {
		authInput.Address = t.Strval(address)
	}

	subject,ok := dat["subject"]
	if !ok {
		authInput.Subject = ""
	}else {
		authInput.Subject = t.Strval(subject)
	}

	flag,ok := dat["flag"]
	if !ok {
		authInput.Flag = ""
	}else {
		authInput.Flag = t.Strval(flag)
	}

	advantage,ok := dat["advantage"]
	if !ok {
		authInput.Advantage = ""
	}else {
		authInput.Advantage = t.Strval(advantage)
	}

	technology,ok := dat["technology"]
	if !ok {
		authInput.Technology = ""
	}else {
		authInput.Technology = t.Strval(technology)
	}

	sex,ok := dat["sex"]
	if !ok {
		authInput.Sex = ""
	}else {
		authInput.Sex = t.Strval(sex)
	}

	name,ok := dat["name"]
	if !ok {
		authInput.Name = ""
	}else {
		authInput.Name = t.Strval(name)
	}

	teach := dao.FaceTeach{}

	tx:=public.DBCon

	authOutPut,exist:=teach.Auth(c,tx,authInput)

	if exist{

		response.ResponseFailMessage(c,"认证失败","已经认证过了")
		return
	}

	response.ResponseSuccess(c,authOutPut)

}


//教师列表
func (t *TeachController)teacherList(c *gin.Context) {

	//构造参数绑定
	//获取POST请求的请求体
	bodyBytes, _ := ioutil.ReadAll(c.Request.Body)

	var dat map[string]interface{}

	json.Unmarshal(bodyBytes, &dat)

	teachInput := dto.TeachListInput{}

	page,ok := dat["page"]
	if ok {

		var pageStr string
		pageStr = t.Strval(page)
		pageInt,_ := strconv.Atoi(pageStr)
		teachInput.Page = pageInt
	}else {
		teachInput.Page = 1
	}

	teachInput.PageSize = 10

	searchName,ok := dat["searchName"]
	if !ok {
		teachInput.SearchName = ""
	}else {
		teachInput.SearchName = t.Strval(searchName)
	}

	sex,ok := dat["sex"]
	if !ok {
		teachInput.Sex = ""
	}else {
		teachInput.Sex = t.Strval(sex)
	}

	major,ok := dat["major"]
	if !ok {
		teachInput.Major = ""
	}else {
		teachInput.Major = t.Strval(major)
	}

	subject,ok := dat["subject"]
	if !ok {
		teachInput.Subject = ""
	}else {
		teachInput.Subject = t.Strval(subject)
	}

	flag,ok := dat["flag"]
	if !ok {
		teachInput.Flag = ""
	}else {
		teachInput.Flag = t.Strval(flag)
	}

	teach := dao.FaceTeach{}

	//tx, _ := lib.GetGormPool("default")

	tx := public.DBCon

	list,error := teach.FaceTeachList(c,tx,teachInput)

	if error==nil {

		response.ResponseSuccess(c,list)

		return
	}

    response.ResponseFail(c,"")

}

// Strval 获取变量的字符串值
// 浮点型 3.0将会转换成字符串3, "3"
// 非数值或字符类型的变量将会被转换成JSON格式字符串
func (f *TeachController)Strval(value interface{}) string {
	var key string
	if value == nil {
		return key
	}

	switch value.(type) {
	case float64:
		ft := value.(float64)
		key = strconv.FormatFloat(ft, 'f', -1, 64)
	case float32:
		ft := value.(float32)
		key = strconv.FormatFloat(float64(ft), 'f', -1, 64)
	case int:
		it := value.(int)
		key = strconv.Itoa(it)
	case uint:
		it := value.(uint)
		key = strconv.Itoa(int(it))
	case int8:
		it := value.(int8)
		key = strconv.Itoa(int(it))
	case uint8:
		it := value.(uint8)
		key = strconv.Itoa(int(it))
	case int16:
		it := value.(int16)
		key = strconv.Itoa(int(it))
	case uint16:
		it := value.(uint16)
		key = strconv.Itoa(int(it))
	case int32:
		it := value.(int32)
		key = strconv.Itoa(int(it))
	case uint32:
		it := value.(uint32)
		key = strconv.Itoa(int(it))
	case int64:
		it := value.(int64)
		key = strconv.FormatInt(it, 10)
	case uint64:
		it := value.(uint64)
		key = strconv.FormatUint(it, 10)
	case string:
		key = value.(string)
	case []byte:
		key = string(value.([]byte))
	default:
		newValue, _ := json.Marshal(value)
		key = string(newValue)
	}

	return key
}

