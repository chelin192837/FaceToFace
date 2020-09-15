
<template name = "tailerStarts">
	
		<!-- 评分 -->
		<view class="movie-score-wapper">
			
			<image v-for="yellow in yelloScore"
			src="../static/icos/star-yellow.png" 
			class="start-icon"></image>
			
			<image v-for="gray in greyScore" 
			src="../static/icos/star-gray.png" 
			class="start-icon"></image>
			<view v-if="showNum == 1"
			class="movie-score">{{innerscore}}</view>
	
		</view>
	
</template>

<script>
	export default {
		
		name:"tailerStarts",
		
		data() {
			return {
				yelloScore:0,
				greyScore:5
			};
		},
		
		props:{
			//自定义一个变量，用于接受父组件传入的参数值
			innerscore:0,
			showNum:0 //1展示 0不展示
		},
		created(){
			
			var tempScore = 0 
			if(this.innerscore != null && this.innerscore != undefined && this.innerscore != '')
			{
				tempScore = this.innerscore;
			}
			
			var yelloScore = parseInt(tempScore/2);
			
			var grayScore = 5 - yelloScore;
			
			this.yelloScore = yelloScore ;
			
			this.greyScore = grayScore ;
			
		}
		
	}
</script>

<style>

    .movie-score-wapper{
		
		display: flex;
        flex-direction: row;		
		
	}
	
	.start-icon{
		width: 20upx;
		height: 20upx;
		margin-top: 6upx;
	}
	.movie-score{
		font-size: 12px;
		color: bgred;
		margin-left: 20upx;
	}
	
</style>
