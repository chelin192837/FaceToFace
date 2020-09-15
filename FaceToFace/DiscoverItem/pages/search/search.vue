<template>
	<view class="page">
		
		<view class="search-block">
			<view class="search-icon-warpper">
				<image src="../../static/icos/search.png" class="search-icon"></image>
			</view>
			<input placeholder="  寻找人才" maxlength="10" class="search-text" @confirm="searchClick" confirm-type="search"/>
	
		</view>
		
		<view class="page-block moive-list">
			
			<view 
			v-for="(carouse,index) in carouseList"
			class="moive-wapper">
			<view class="poster-wapper">
				<image 
				:data-index="index"
				@click="showTrailer"
				:src="carouse.file_url2" 
				class="poster"></image>
				<view class="move-name">{{carouse.name}}</view>
				<view class="move-subject">{{carouse.subject}}</view>
			</view>
			</view>

		</view>

	</view>
</template>

<script>
	
	import tailerStarts from "../../components/tailerStarts.vue"
	
	export default {
		data() {
			return {
				carouseList:[],
				page:1,
				keywords:""
			}
		},
		onPullDownRefresh() {
			this.page=1;
			this.refresh(this.page);
			
		},
		// 上拉加载
		onReachBottom: function() {
			
			this.refresh(this.page++);
		},
		onLoad() {
			this.page = 1 ;
			this.refresh(this.page);
		},
		methods: {
			showTrailer(e){
				 var me = this;
				 var index = e.currentTarget.dataset.index;
				 var carouse = me.carouseList[index];
				 uni.navigateTo({url:'../movie/movie?carouse='+encodeURIComponent(JSON.stringify(carouse))});
	
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
								me.carouseList = res.data.data.list;
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
			 searchClick: function(event) {	 
				 
				 var me =this;
				 var value = e.detail.value;
				 me.keywords = value;
				 me.carouseList = [];
				 
				 
			 //    this.inputValue = event.target.value;
				// console.log("打印搜索内容"+this.inputValue);		
				this.page = 1 ;
						
				this.refresh(this.page)
			  }
			
		},
	   components:{
		     tailerStarts
	   },
	}
</script>

<style>

@import url("search.css");

</style>
