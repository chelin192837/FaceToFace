(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-auth-auth"],{"0de9":function(a,t,e){"use strict";function i(a){var t=Object.prototype.toString.call(a);return t.substring(8,t.length-1)}function n(){return"string"===typeof __channelId__&&__channelId__}function u(a){for(var t=arguments.length,e=new Array(t>1?t-1:0),i=1;i<t;i++)e[i-1]=arguments[i];console[a].apply(console,e)}function s(){for(var a=arguments.length,t=new Array(a),e=0;e<a;e++)t[e]=arguments[e];var u=t.shift();if(n())return t.push(t.pop().replace("at ","uni-app:///")),console[u].apply(console,t);var s=t.map((function(a){var t=Object.prototype.toString.call(a).toLowerCase();if("[object object]"===t||"[object array]"===t)try{a="---BEGIN:JSON---"+JSON.stringify(a)+"---END:JSON---"}catch(n){a="[object object]"}else if(null===a)a="---NULL---";else if(void 0===a)a="---UNDEFINED---";else{var e=i(a).toUpperCase();a="NUMBER"===e||"BOOLEAN"===e?"---BEGIN:"+e+"---"+a+"---END:"+e+"---":String(a)}return a})),o="";if(s.length>1){var r=s.pop();o=s.join("---COMMA---"),0===r.indexOf(" at ")?o+=r:o+="---COMMA---"+r}else o=s[0];console[u](o)}e.r(t),e.d(t,"log",(function(){return u})),e.d(t,"default",(function(){return s}))},"2f9a":function(a,t,e){"use strict";(function(a){Object.defineProperty(t,"__esModule",{value:!0}),t.default=void 0;var e={data:function(){return{}},methods:{formSubmit:function(t){a("log","form发生了submit事件，携带数据为："+JSON.stringify(t.detail.value)," at pages/auth/auth.vue:110");var e=t.detail.value,i=this,n=i.getGlobalUser("globalUser"),u=i.serverURL,s="Bearer "+n.token;uni.request({url:u+"mine/auth",header:{Authorization:s},data:{iphone:n.iphone,major:e.major,address:e.address,subject:e.subject,flag:e.flag,advantage:e.advantage,technology:e.technology,sex:e.sex,name:e.name},method:"POST",success:function(a){var t=a.data.message;uni.showToast({duration:2e3,title:t,icon:"none"})}})}}};t.default=e}).call(this,e("0de9")["log"])},"30e8":function(a,t,e){"use strict";e.r(t);var i=e("2f9a"),n=e.n(i);for(var u in i)"default"!==u&&function(a){e.d(t,a,(function(){return i[a]}))}(u);t["default"]=n.a},4794:function(a,t,e){var i=e("fa79");"string"===typeof i&&(i=[[a.i,i,""]]),i.locals&&(a.exports=i.locals);var n=e("4f06").default;n("04c1b3aa",i,!0,{sourceMap:!1,shadowMode:!1})},"71a9":function(a,t,e){"use strict";var i=e("4794"),n=e.n(i);n.a},b893:function(a,t,e){"use strict";e.r(t);var i=e("c39d"),n=e("30e8");for(var u in n)"default"!==u&&function(a){e.d(t,a,(function(){return n[a]}))}(u);e("71a9");var s,o=e("f0c5"),r=Object(o["a"])(n["default"],i["b"],i["c"],!1,null,"6e6f28a1",null,!1,i["a"],s);t["default"]=r.exports},c39d:function(a,t,e){"use strict";var i,n=function(){var a=this,t=a.$createElement,e=a._self._c||t;return e("v-uni-view",[e("v-uni-view",[e("v-uni-form",{on:{submit:function(t){arguments[0]=t=a.$handleEvent(t),a.formSubmit.apply(void 0,arguments)}}},[e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("名字")]),e("v-uni-input",{staticClass:"auth-name-input",attrs:{name:"name",placeholder:"  请输入姓名"}})],1),e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("清华大学/北京大学")]),e("v-uni-radio-group",{staticClass:"auth-name-radio",attrs:{name:"subject"}},[e("v-uni-label",{staticClass:"auth-name-radio-item"},[e("v-uni-radio",{attrs:{value:"清华大学"}}),e("v-uni-text",[a._v("清华大学")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item"},[e("v-uni-radio",{attrs:{value:"北京大学"}}),e("v-uni-text",[a._v("北京大学")])],1)],1)],1),e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("专业")]),e("v-uni-input",{staticClass:"auth-name-input",attrs:{name:"technology",placeholder:"  请输入专业"}})],1),e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("性别")]),e("v-uni-radio-group",{staticClass:"auth-name-radio",attrs:{name:"sex"}},[e("v-uni-label",{staticClass:"auth-name-radio-item"},[e("v-uni-radio",{attrs:{value:"男"}}),e("v-uni-text",[a._v("男")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item"},[e("v-uni-radio",{attrs:{value:"女"}}),e("v-uni-text",[a._v("女")])],1)],1)],1),e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("高中时文理科")]),e("v-uni-radio-group",{staticClass:"auth-name-radio",attrs:{name:"major"}},[e("v-uni-label",{staticClass:"auth-name-radio-item"},[e("v-uni-radio",{attrs:{value:"文科"}}),e("v-uni-text",[a._v("文科")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item"},[e("v-uni-radio",{attrs:{value:"理科"}}),e("v-uni-text",[a._v("理科")])],1)],1)],1),e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("特长优势")]),e("v-uni-radio-group",{staticClass:"auth-name-radio-colum",attrs:{name:"flag"}},[e("v-uni-label",{staticClass:"auth-name-radio-item-colum"},[e("v-uni-radio",{attrs:{value:"高考状元"}}),e("v-uni-text",[a._v("高考状元")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item-colum"},[e("v-uni-radio",{attrs:{value:"单科满分"}}),e("v-uni-text",[a._v("单科满分")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item-colum"},[e("v-uni-radio",{attrs:{value:"省三好学生"}}),e("v-uni-text",[a._v("省三好学生")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item-colum"},[e("v-uni-radio",{attrs:{value:"竞赛得奖"}}),e("v-uni-text",[a._v("竞赛得奖")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item-colum"},[e("v-uni-radio",{attrs:{value:"满分作文"}}),e("v-uni-text",[a._v("满分作文")])],1),e("v-uni-label",{staticClass:"auth-name-radio-item-colum"},[e("v-uni-radio",{attrs:{value:"其他"}}),e("v-uni-text",[a._v("其他")])],1)],1)],1),e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("高考时的省市")]),e("v-uni-input",{staticClass:"auth-name-input",attrs:{name:"address",placeholder:"  请输入地址"}})],1),e("v-uni-view",{staticClass:"auth-name"},[e("v-uni-view",{staticClass:"auth-name-title"},[a._v("座右铭")]),e("v-uni-input",{staticClass:"auth-name-input",attrs:{name:"advantage",placeholder:"  请输入座右铭"}})],1),e("v-uni-view",{staticClass:"auth-submit"},[e("v-uni-button",{staticClass:"auth-submit-button",attrs:{"form-type":"submit"}},[a._v("提交")])],1)],1)],1)],1)},u=[];e.d(t,"b",(function(){return n})),e.d(t,"c",(function(){return u})),e.d(t,"a",(function(){return i}))},fa79:function(a,t,e){var i=e("24fb");t=i(!1),t.push([a.i,".auth-name[data-v-6e6f28a1]{display:-webkit-box;display:-webkit-flex;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-webkit-flex-direction:column;flex-direction:column;padding:%?20?% %?20?%}.auth-name-title[data-v-6e6f28a1]{font-size:18px;color:#333}.auth-name-input[data-v-6e6f28a1]{border:1px solid #c6c8ce;background-color:initial;height:%?70?%;margin-top:%?10?%;border-radius:6px}.auth-name-radio[data-v-6e6f28a1]{margin-top:%?10?%}.auth-name-radio-item[data-v-6e6f28a1]{margin-left:%?10?%}.auth-name-radio-colum[data-v-6e6f28a1]{display:-webkit-box;display:-webkit-flex;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-webkit-flex-direction:column;flex-direction:column}.auth-name-radio-item-colum[data-v-6e6f28a1]{margin-top:%?15?%}.auth-submit-button[data-v-6e6f28a1]{width:80%;background-color:#007aff;color:#fff;margin-top:%?40?%}.auth-submit[data-v-6e6f28a1]{height:200px}",""]),a.exports=t}}]);