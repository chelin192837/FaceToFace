<template>
    <view>
        <view>
            <form @submit="formSubmit">
				
              <view class="auth-name">
                  <view class="auth-name-title">名字</view>
                  <input class="auth-name-input" name="name" placeholder="  请输入姓名" />
              </view>
			  
			  
                <view class="auth-name">
                    <view class="auth-name-title">清华大学/北京大学</view>
					<radio-group name="subject" class="auth-name-radio">
                        <label class="auth-name-radio-item">
                            <radio value="清华大学" /><text>清华大学</text>
                        </label>
                        <label class="auth-name-radio-item">
                            <radio value="北京大学" /><text>北京大学</text>
                        </label>
                    </radio-group>
                </view>
				
				<view class="auth-name">
				    <view class="auth-name-title">专业</view>
				    <input class="auth-name-input" name="technology" placeholder="  请输入专业" />
				</view>
				
				<view class="auth-name">
				    <view class="auth-name-title">性别</view>
					<radio-group name="sex" class="auth-name-radio">
				        <label class="auth-name-radio-item">
				            <radio value="男" /><text>男</text>
				        </label>
				        <label class="auth-name-radio-item">
				            <radio value="女" /><text>女</text>
				        </label>
				    </radio-group>
				</view>
				
				<view class="auth-name">
				    <view class="auth-name-title">高中时文理科</view>
					<radio-group name="major" class="auth-name-radio">
				        <label class="auth-name-radio-item">
				            <radio value="文科" /><text>文科</text>
				        </label>
				        <label class="auth-name-radio-item">
				            <radio value="理科" /><text>理科</text>
				        </label>
				    </radio-group>
				</view>
				
				<view class="auth-name">
				    <view class="auth-name-title">特长优势</view>
					<radio-group name="flag" class="auth-name-radio-colum">
				        <label class="auth-name-radio-item-colum">
				            <radio value="高考状元" /><text>高考状元</text>
				        </label>
				        <label class="auth-name-radio-item-colum">
				            <radio value="单科满分" /><text>单科满分</text>
				        </label>
						<label class="auth-name-radio-item-colum">
						    <radio value="省三好学生" /><text>省三好学生</text>
						</label>
						<label class="auth-name-radio-item-colum">
						    <radio value="竞赛得奖" /><text>竞赛得奖</text>
						</label>
						<label class="auth-name-radio-item-colum">
						    <radio value="满分作文" /><text>满分作文</text>
						</label>
						<label class="auth-name-radio-item-colum">
						    <radio value="其他" /><text>其他</text>
						</label>
						
				    </radio-group>
				</view>
				
				<view class="auth-name">
				    <view class="auth-name-title">高考时的省市</view>
				    <input class="auth-name-input" name="address" placeholder="  请输入地址" />
				</view>
				
				
				<view class="auth-name">
				    <view class="auth-name-title">座右铭</view>
				    <input class="auth-name-input" name="advantage" placeholder="  请输入座右铭" />
				</view>
				
				<!-- 上传图片 -->
				
               
				
                <view class="auth-submit">
                    <button class="auth-submit-button" form-type="submit">提交</button>
                </view>
				
				
            </form>
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
            formSubmit: function(e) {
                console.log('form发生了submit事件，携带数据为：' + JSON.stringify(e.detail.value))
                var formdata = e.detail.value
                // uni.showModal({
                //     content: '表单数据内容：' + JSON.stringify(formdata),
                //     showCancel: false
                // });		
				var me = this;
				var userInfo = me.getGlobalUser("globalUser");
				var serverUrl = me.serverURL;	
				var token = "Bearer "+userInfo.token;
				uni.request({
					url:serverUrl + 'mine/auth',
					header:{
						"Authorization":token
					},
					data:{
						"iphone":userInfo.iphone,
						"major":formdata.major,
						"address":formdata.address,
						"subject":formdata.subject,
						"flag":formdata.flag,
						"advantage":formdata.advantage,
						"technology":formdata.technology,
						"sex":formdata.sex,
						"name":formdata.name
					},
					method:"POST",
					success: (res) => {
					
					var message = res.data.message;
				
						uni.showToast({
							duration:2000,
							title:message,
						    icon:"none"
						})
					}
				})
				
				
				
				
				
				
            }
        }
    }
</script>

<style>
   
   @import url("auth.css");
   
</style>