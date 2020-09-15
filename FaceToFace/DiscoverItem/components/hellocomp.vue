
<!-- 定义组件名称为hellocomp >
<template name = "hellocomp">
	
	<view>
		
		{{msg}}
		
		<view>
			
			<input type="text" :value="mypro" class="txt"/>
			
		</view>
		
		
	</view>
	
</template>


<script>
	export default {
		name:"hellocomp",
	
		data() {
			return {
				msg:"你好，这是自定义组件"
			};
		},
		//定义组件内部使用的属性
		props:{
			//自定义一个变量，用于接受父组件传入的参数值
			mypro:{
				type:String //定义参数的类型
			}
		}
	}
	
</script>



<style>
		
.txt{
	color:#4CD964;
}
</style>
