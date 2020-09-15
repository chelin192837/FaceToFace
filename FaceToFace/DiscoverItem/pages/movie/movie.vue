<template>
	<view class="page">
		
		<view class="movie-name">
			<view class="movie-name-value">姓名</view>			
			<view class="movie-name-content">{{this.carouse.name}}</view>
		</view>
		
		<view class="movie-name">
			<view class="movie-name-value">院校</view>			
			<view class="movie-name-content">{{this.carouse.subject}}</view>
		</view>
		
		<view class="movie-name">
			<view class="movie-name-value">专业</view>			
			<view class="movie-name-content">{{this.carouse.technology}}</view>
		</view>
		
		<view class="movie-name">
			<view class="movie-name-value">性别</view>			
			<view class="movie-name-content">{{this.carouse.sex}}</view>
		</view>
		
		<view class="movie-name">
			<view class="movie-name-value">文理科</view>			
			<view class="movie-name-content">{{this.carouse.major}}</view>
		</view>
		
		<view class="movie-name">
			<view class="movie-name-value">特长优势</view>			
			<view class="movie-name-content">{{this.carouse.flag}}</view>
		</view>
		
		<view class="movie-name">
			<view class="movie-name-value">高考省市</view>			
			<view class="movie-name-content">{{this.carouse.address}}</view>
		</view>
		
		<view class="movie-name">
			<view class="movie-name-value">座右铭</view>			
			<view class="movie-name-content">{{this.carouse.advantage}}</view>
		</view>
		
		<view class="image-file">
			
			<view class="image-file-detail">
				<navigator :url="'../cover/cover?cover=' + this.carouse.file_url1">
				
				<image :data-file="this.carouse.file_url1" :src="this.carouse.file_url1" class="image-icon"></image>
						
				</navigator>
				<view class="image-file-name">头像自拍</view>
				
			</view>
			
			<view class="image-file-detail">
				<navigator :url="'../cover/cover?cover=' + this.carouse.file_url1">
			
				<image :data-file="this.carouse.file_url2" :src="this.carouse.file_url1" class="image-icon"></image>
			
				</navigator>
				
				<view class="image-file-name">学生证照片</view>
		</view>	
			
			<view class="image-file-detail">
				
				<navigator :url="'../cover/cover?cover=' + this.carouse.file_url1">
				
				<image :data-file="this.carouse.file_url3" :src="this.carouse.file_url1" class="image-icon"></image>
						
				</navigator>
				<view class="image-file-name">手持学生证照片</view>
				
			</view>
			
		</view>
		

		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				carouse:{}

			}
		},
		onLoad(params) {
			
			const carouse = JSON.parse(decodeURIComponent(params.carouse));
			
			this.carouse = carouse;
			
			console.log("参数是"+params.carouse);
			
		},
		// onNavigationBarButtonTap(e) {
		// 	var index = e.index;
		// 	console.log(index);
		// },
		methods: {
			
			lookMe(e){
				
				var file = e.currentTarget.dataset.file;
				
				var me = this;
				
				uni.previewImage({
					urls:[file]
					// urls:[me.carouse.file_url1,me.carouse.file_url2,me.carouse.file_url3]
				});
				
			}
			
		}
	}
</script>

<style>

@import url("movie.css");

</style>
