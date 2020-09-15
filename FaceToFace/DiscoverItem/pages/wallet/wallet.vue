
<template>
	
	<view class="page">
		
		<!-- 阴影卡片 -->
		<view class="wallet-card-wapper">
			<view class="wallet-card-num-title">卡片数量(张数)</view>
			<view class="wallet-card-num">2</view>
			<view class="wallet-card-num-desc">
				需要清华北大咨询卡片的可以咨询客服
				客服电话：15510373985
			</view>
			
		</view>
		
		<!-- 卡片张数 -->
		<view class="card-type">
			
			<view class="card-image-content">
				
				<image src="../../static/facetoface/coin_logo_default.png" class="card-image"></image>
		
				<view class="card-content">清华大学一次咨询卡</view>
				
			</view>
	
			<view class="card-Num-arrow">
				<view class="card-Num">1张</view>
				<image class="card-arrow" src="../../static/facetoface/arror_right.png"></image>
			</view>
			
			
		</view>
		
		<view class="card-type">
			
			<view class="card-image-content">
				
				<image src="../../static/facetoface/coin_logo_default.png" class="card-image"></image>
		
				<view class="card-content">北京大学一次咨询卡</view>
				
			</view>
			
			<view class="card-Num-arrow">
				<view class="card-Num">1张</view>
				<image class="card-arrow" src="../../static/facetoface/arror_right.png"></image>
			</view>
			
			
		</view>
		
		
		
		
		<view class="line-wapper">
			<view class="line"></view>
		</view>
				
		
		
	</view>
	
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			
		}
	}
</script>

<style>

@import url("wallet.css");

</style>
