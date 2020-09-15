<template>
	<view class="page">
		
	<view class="footer-wapper">
			<view class="footer-words" @click="cleanStorage">
				清理缓存
			</view>
			<view class="footer-words" style="margin-top: 10upx;" @click="logout">
				退出登录
			</view>
	</view>
	
	</view>
		
</template>

<script>
	export default {
		data() {
			return {
				globalUser: {}
			};
		},
		onShow() {
			var me = this;
			var globalUser = me.getGlobalUser("globalUser");
			me.globalUser = globalUser;
		},
		methods: {
			modifySex() {
				uni.navigateTo({
					url: "../sex/sex"
				})
			},
			modifyBirthday() {
				uni.navigateTo({
					url: "../meBirthday/meBirthday"
				})
			},
			modifyNickname() {
				uni.navigateTo({
					url: "../meNickname/meNickname"
				})
			},
			operator() {
				var me = this;
				var globalUser = me.getGlobalUser("globalUser");
				uni.showActionSheet({
					itemList: ["查看我的头像", "从相册选择上传"],
					success(res) {
						var index = res.tapIndex;
						if (index == 0) {
							// 预览头像
							var faceArr = [];
							faceArr.push(globalUser.faceImage);
							uni.previewImage({
								urls: faceArr,
								current: faceArr[0]
							})
						} else if (index == 1) {
							// 选择上传头像
							uni.chooseImage({
								count: 1,
								sizeType: ["compressed"],
								sourceType: ["album"],
								success(res) {
									// 获得临时路径
									var tempFilePath = res.tempFilePaths[0];
									// #ifdef H5
									uni.navigateTo({
										url: "../meFace/meFace?tempFilePath=" + tempFilePath
									})
									// #endif
									// #ifndef H5
									uni.navigateTo({
										url: "../faceCrop/faceCrop?tempFilePath=" + tempFilePath
									})
									// #endif
								}
							})
							
						}
					}
				})
			},
			cleanStorage() {
				uni.clearStorageSync();
				uni.showToast({
					title: "清理缓存成功",
					mask: false,
					duration: 1500
				})
			},
			logout() {
				var globalUser = this.getGlobalUser("globalUser");

				uni.removeStorageSync("globalUser");
				
				uni.switchTab({
					url: "../me/me"
				});

			}
		}
	}
</script>

<style>
	@import url("meInfo.css");
</style>
