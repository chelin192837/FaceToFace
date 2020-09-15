
<template>
	
	<view class="page">
		
	<!-- 轮播图 默认 坐标(0,0) 宽百分之百 高440 -->
	<swiper :indicator-dots="true" :autoplay="true" :interval="3000" :duration="1000" class="carousel">
		
		<!-- 轮播图的某一项 -->
		<swiper-item v-for="car in carousePicList">
			<navigator :url="'../cover/cover?cover=' + car.file_url1">
			
				<image :src="car.file_url1" class="carousel"></image>
					
			</navigator>
				
				
		
		</swiper-item>
		
	</swiper>
	
	<!-- 热门超英 start -->
	<view class="page-block super-hot">
		
		<view class="hot-title-wapper">
			<image src="../../static/icos/hot.png" mode="" class="hot-ico"></image>
			<view class="hot-title">
				优秀状元
			</view>
		</view>
		
		<scroll-view scroll-x="true" class="page-block hot" show-scrollbar="false">
			
			<view class="single-poster" v-for="(carouse,index) in carouseList">
				<view class="poster-wapper">
					
					<image
					:data-index="index"
					@click="clickMe"
					:src="carouse.file_url2" 
					class="poster"></image>
					
					<view class="move-name">{{carouse.name}}</view>
					
					<tailerStarts innerscore = "6.2" showNum = "1"></tailerStarts>
					
				</view>
			</view>


		
			
		</scroll-view>

	</view>
	<!-- 热门超英 end-->
	
	<!-- 热门预告 start -->
	<view class="page-block super-hot">
		
		<view class="hot-title-wapper">
			<image src="../../static/icos/108x108.png" mode="" class="hot-ico"></image>
			<view class="hot-title">
				清北视频
			</view>
		</view>
		
		<view class="hot-movies page-block">
			<video 
			v-for="trailer in hotTrailerList"
			:src = "trailer"
			poster="../../static/facetoface/180.png"
			controls
			class="hot-movies-single"
			>
			</video>
		</view>
	
	</view>
	<!-- 热门预告 end-->
	
	<!-- 猜你喜欢start -->
	<view class="page-block super-hot">
		
		<view class="hot-title-wapper">
			<image src="../../static/icos/guess-u-like.png" mode="" class="hot-ico"></image>
			<view class="hot-title">
			     推荐精英
			</view>
		</view>

		<view class="page-block guess-u-like">
			
		<!-- 一块一块写 -->
		<view 
		v-for="(carouse,index) in carouseList"
		class="single-like-movie"
		>
			
			<image 
			:data-index="index"
			@click="clickMe"
			:src="carouse.file_url2" 
			class="movies-image"
			></image>
			
			<view class="movie-desc">
				<view class="movie-title">{{carouse.name}}</view>
				<tailerStarts innerscore = "10" showNum = "0"></tailerStarts>
				<view class="movie-info">{{carouse.subject}}</view>
				<view class="movie-info">{{carouse.price}}/30分钟</view>
			    <view class="movie-info">{{carouse.advantage}}</view>
			
			</view>
			
			<view class="movie-oper" :data-index="index" @click="priseMe">
				<image src="../../static/facetoface/iphone.png" class="prise-icon"></image>
			    <view class="prise-me">拨打电话</view>
				<view :animation="animationDataArr[index]" class="prise-me animation-opaticy">+1</view>
				
			</view>
			
		</view>

		</view>
		

	</view>
	
	<!-- 猜你喜欢end -->
	</view>
	
	
</template>

<script>
	
	import common from "../../common/common.js";
	
	import hellocomp from "../../components/hellocomp.vue";
	
	import tailerStarts from "../../components/tailerStarts.vue";
	
	export default {
		data() {
			return {
				//对象属性
				title: 'Hello',
				carouseList:[],
				carousePicList:[],
				hotTrailerList:[],
				animationData:{},
				animationDataArr:[
					{},{},{},{},{},{},{},{},{},{}
				],
				page:1
			}
		},
		onUnload(){
			this.animationData = {};
		},
		onPullDownRefresh() {
			this.page=1;
			this.refresh(this.page);
			this.refreshVideo();
			
		},
		// 上拉加载
		onReachBottom: function() {
			
			this.refresh(this.page++);
		},
		//生命周期函数 = viewdidload
		onLoad() {
	
			//this作用域问题
			var me = this;
						
			//在页面创建的时候，创建一个临时动画
			this.animation = uni.createAnimation({
				
			});
			
			//通过全局变量获取
			
			var serverDemoUrl = me.serverDemoURL;
						
			//查询热门超英
			// curl -X POST -d '{"page":1}' "http://39.100.127.77:9001/app/discover/teacherlist"
			
			me.refresh(1);
			
			me.refreshVideo();
	
		},
	
		//对象的实例方法
		methods: {
			refreshVideo(){

				var me = this;
				
				var serverDemoUrl = me.serverDemoURL;
				
				// debugger;
				//查询热门预告
				uni.request({
					url:serverDemoUrl + 'video',
					method:'POST',
				    data:{},
					header:{
						'content-type':'application/json'
					},
					// 箭头函数可以直接写this  es6
					// function函数
					success: (res) => {
						
						//获取真实数据之前，判断状态是否是200
						
						if(res.data.code  == 200)
						{
							var hotTrailerList=  res.data.data;
							
							me.hotTrailerList = hotTrailerList;
																			
						}
					}
				});
			},
			clickMe(e){
				var me = this;
				var index = e.currentTarget.dataset.index;
				var carouse = me.carouseList[index];				
			
				uni.navigateTo({
					url:'../movie/movie?carouse='+encodeURIComponent(JSON.stringify(carouse))}
					);
					
			},
			refresh(page){
				var me = this;
				
				uni.showLoading({
					mask:true
				});
				
				var serverurl = me.serverURL;
				
				uni.request({
					
					url:serverurl + 'discover/teacherlist',
					method:'POST',
					data:{
						page:page
					},
					header:{
						'content-type':'application/json'
					},
					// 箭头函数可以直接写this  es6
					// function函数
					success: (res) => {
						//获取真实数据之前，判断状态是否是200
						if(res.data.code  == 200)
						{
							if(page==1){
								me.carousePicList = [];
								me.carouseList = res.data.data.list;
								me.carousePicList = res.data.data.list;
							}else{
							
							me.carouseList = me.carouseList.concat(res.data.data.list);
							
							// for(var i=0;i<res.data.data.list.length;i++)
							// {
							// 	me.carouseList.push(res.data.data.list[i]);
							
							// }
						
							}
							
						}
					},
					complete: (res) => {
						uni.hideLoading();
						uni.stopPullDownRefresh();
					}
				})
				
			},
			
			//构建动画数据
			priseMe: function (e){
				
				uni.makePhoneCall({
				 	
				 	// 手机号
				    phoneNumber: '15510373985', 
				
					// 成功回调
					success: (res) => {
						console.log('调用成功!')	
					},
				
					// 失败回调
					fail: (res) => {
						console.log('调用失败!')
					}
					
				  });
				
				
				
			}
			
		},
		
		components:{
			hellocomp,
			tailerStarts
		},
		
	}
</script>

<style>
	@import url("index.css");
	
	
	
	
	
</style>
