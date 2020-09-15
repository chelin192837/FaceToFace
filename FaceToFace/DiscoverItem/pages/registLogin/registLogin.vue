<template>
	<view class="body">
		<form @submit="formSubmit">
			<view class="face-wapper">
				<image src="../../static/facetoface/120.png" class="face"></image>
			</view>

			<view class="info-wapper">
				<label class="words-lbl">手机号</label>
				<input @input="iphoneInput" name="username" type="number" value="" class="input" placeholder="请输入手机号" placeholder-class="graywords" />
			</view>

			<view class="info-wapper" style="margin-top: 40upx;">
				<label class="words-lbl">验证码</label>
				<input name="password" type="number" value="" password="true" class="input" placeholder="请输入验证码" placeholder-class="graywords" />
			</view>

			<view>
				<button type="primary" class="butto" :disabled="disabled" @tap="SMS"> {{title}} </button>
			</view>

			<button type="primary" form-type="submit" style="margin-top: 60upx;width: 90%;">注册/登录</button>
		</form>

	</view>
</template>


<script>
	export default {
		data() {
			return {
				timer: 60,
				disabled: false,
				title: '发送验证码',
				account:''
			};
		},
		methods: {
			iphoneInput(e) {
				var me = this;
				var username = e.target.value;
				me.account = username;
			},
			SMS: function(e) {
				if (this.account.length < 11) {
					uni.showToast({
						title: '手机号不符合要求',
						duration: 2000,
						icon: 'none',
						code:''
					});
					return;
				} else {
					this.sendCode(this.account);
					this.disabled = true;
					let timer1 = setInterval(() => {
						this.timer--;
						this.title = '请等待' + this.timer + '秒后再次发送'
						if (this.timer == 0) {
							clearInterval(timer1);
							this.timer = 60;
							this.disabled = false
							this.title = '发送验证码'
							return;
						}
					}, 1000);
				}
			},
			sendCode(iphone){
				
				var me = this;
				
				var serverUrl = me.serverURL;
								
				uni.request({
					url:serverUrl + 'sendCode',
					data:{
						"iphone":iphone
					},
					method:"POST",
					success: (res) => {
					
					var message = res.data.data.message;
				
						uni.showToast({
							duration:2000,
							title:message,
						    icon:"none"
						})
					}
				})
		
			},
			formSubmit(e) {
				var me = this;
				var iphone = e.detail.value.username;
				var code = e.detail.value.password;
	
				// 发起注册/登录的请求
				var serverUrl = me.serverURL;
				uni.request({
					url: serverUrl + 'login',
					data: {
						"iphone": iphone,
						"code": code
					},
					method: "POST",
					success: (res) => {

						// 获取真实数据之前，务必判断状态是否为200
						if (res.data.code == 200) {
		
							var userInfo = res.data.data;
							
							console.log("userInfo is --- " + JSON.stringify(userInfo));
							
							// console.log(userInfo);
							// 保存用户信息到全局的缓存中
							uni.setStorageSync("globalUser", userInfo);
							// 切换页面跳转，使用tab切换的api
							uni.switchTab({
								url: "../me/me"
							});
						} else {
							uni.showToast({
								title: res.data.message,
								duration: 2000,
								icon: "none"
							})
						}
					}
				});
			}
		}
	}
</script>

<style>
	@import url("registLogin.css");
</style>
