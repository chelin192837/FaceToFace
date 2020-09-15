<template>
	<view class="page">
		<view class="publish-wapper" v-for="require in requirelist">
			
			<view class="publish-require-wapper">
				<view class="publish-require">姓名：{{require.student_name}}</view>
				<view class="publish-require">年纪：{{require.classType}}</view>
				<view class="publish-require">需要的学生类型：{{require.teach_major}}</view>
				<view class="publish-require">困扰问题：{{require.problem}}</view>
				<view class="publish-require">订单状态：待处理</view>
			</view>
			
		</view>
		
		
		
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				requirelist:[],
				page:1,
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
			refresh(page){
				var me = this;
				
				uni.showLoading({
					mask:true
				});
				
				var serverurl = me.serverURL;
				
				uni.request({
					
					url:serverurl + 'publish/requirelist',
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
								me.requirelist = res.data.data.list;
							}else{
							
							me.requirelist = me.requirelist.concat(res.data.data.list);
						
							}
							
						}
					},
					complete: (res) => {
						uni.hideLoading();
						uni.stopPullDownRefresh();
					}
				})
				
			},
			
			
			
			
		}
	}
</script>

<style>
     @import url("newspages.css");

</style>
