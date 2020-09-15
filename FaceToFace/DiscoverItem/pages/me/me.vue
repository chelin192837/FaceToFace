<template>
	<view class="page page-fill">

		<view class="header">

			<view>
				<image src="../../static/facetoface/Portrait_signin_white.png" class="face"></image>
			</view>

			<view class="info-wapper" v-if="userIsLogin">
				<view class="nickname">
					{{userInfo.name}}
				</view>
				<view class="nav-info">电话：{{userInfo.iphone}}</view>
			</view>
			<view v-else>
				<navigator url="../registLogin/registLogin">
					<view class="nickname regist-login">
						注册/登录
					</view>
				</navigator>
			</view>

			<view class="set-wapper" v-if="userIsLogin">
				<navigator url="../meInfo/meInfo">
					<image src="../../static/icos/settings.png" class="settings"></image>
				</navigator>
			</view>

		</view>

		<view class="me-info-wapper" @click="authClick">

			<view class="me-info-left">
				<image class="me-info-left-image" src="../../static/facetoface/profile_identity_verify.png"></image>
				<view class="me-info-left-text">身份认证</view>
			</view>

			<image class="me-info-right-image" src="../../static/facetoface/arror_right.png"></image>

		</view>


	</view>
</template>

<script>
	export default {
		data() {
			return {
				userIsLogin: false,
				userInfo: {}
			};
		},
		onShow() {
			var me = this;
			// 用户状态的切换
			// 			var userInfo = uni.getStorageSync("globalUser");
			// 			if (userInfo != null && userInfo != "" && userInfo != undefined) {
			// 				me.userIsLogin = true;
			// 				me.userInfo = userInfo;
			// 			} else {
			// 				me.userIsLogin = false;
			// 				me.userInfo = {};
			// 			}

			// 使用挂载方法获取用户数据
			var userInfo = me.getGlobalUser("globalUser");
			if (userInfo != null) {
				me.userIsLogin = true;
				me.userInfo = userInfo;
			} else {
				me.userIsLogin = false;
				me.userInfo = {};
			}
		},
		methods: {

			authClick(e) {
				uni.navigateTo({
					url: "../auth/auth"
				});

			}
		}
	}
</script>

<style>
	@import url("me.css");
</style>
