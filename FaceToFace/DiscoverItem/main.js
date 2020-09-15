import Vue from 'vue'
import App from './App'

Vue.config.productionTip = false

App.mpType = 'app'

//全局挂载 www.facetoface.top  内网地址172.26.68.183
// Vue.prototype.serverURL = "http://www.facetoface.top:9001/app/"
// Vue.prototype.serverDemoURL = "http://www.facetoface.top:9001/demo/"


Vue.prototype.serverURL = "http://127.0.0.1:9001/app/"
Vue.prototype.serverDemoURL = "http://127.0.0.1:9001/demo/"

Vue.prototype.getGlobalUser = function(key) {
	var userInfo = uni.getStorageSync("globalUser");
	if (userInfo != null && userInfo != "" && userInfo != undefined) {
		return userInfo;
	} else {
		return null;
	}
}

const app = new Vue({
    ...App
})
app.$mount()
