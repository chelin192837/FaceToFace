/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockConfig.h
 ** Description: 配置文件
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#ifndef JinnLockConfig_h
#define JinnLockConfig_h

// 指示器大小
#define JINN_LOCK_INDICATOR_SIDE_LENGTH 64.0f

// 九宫格大小
#define JINN_LOCK_SUDOKO_SIDE_LENGTH 360.0f

// 圆圈边框粗细(指示器和九宫格的一样粗细)
#define JINN_LOCK_CIRCLE_WIDTH 0.5f

// 指示器轨迹粗细
#define JINN_LOCK_INDICATOR_TRACK_WIDTH 0.5f

// 九宫格轨迹粗细
//#define JINN_LOCK_SUDOKO_TRACK_WIDTH 4.0f
#define JINN_LOCK_SUDOKO_TRACK_WIDTH 12.0f

// 圆圈选中效果中心点和圆圈比例
#define JINN_LOCK_CIRCLE_CENTER_RATIO 0.33f

// 背景颜色
#define JINN_LOCK_COLOR_BACKGROUND [UIColor whiteColor]

// 正常主题颜色
#define JINN_LOCK_COLOR_NORMAL [UIColor blackColor]

// 错误提示颜色
#define JINN_LOCK_COLOR_ERROR [UIColor redColor]

// 重设按钮颜色
#define JINN_LOCK_COLOR_RESET [UIColor grayColor]

// 指示器标签基数(不建议更改)
#define JINN_LOCK_INDICATOR_LEVEL_BASE 1000

// 九宫格标签基数(不建议更改)
#define JINN_LOCK_SUDOKO_LEVEL_BASE 2000

// 密码键(不建议更改)
#define JINN_LOCK_PASSWORD [NSString stringWithFormat:@"JinnLockPassword-%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"USERID"]]

// 提示文本
#define JINN_LOCK_RESET_TEXT     LAN(@"重置")
#define JINN_LOCK_NEW_TEXT       LAN(@"请绘制解锁图案")
#define JINN_LOCK_NEW_TEXT2       LAN(@"请绘制手势密码")
#define JINN_LOCK_NEW_TEXT3       LAN(@"请绘制原手势密码")
#define JINN_LOCK_NEW_NOTSTYLE_TEXT       LAN(@"至少连接4个点，请重新绘制")
#define JINN_LOCK_AGAIN_TEXT     LAN(@"请再绘制一次")
#define JINN_LOCK_NOT_MATCH_TEXT LAN(@"与上次绘制不一致,请重新绘制")
#define JINN_LOCK_RE_NEW_TEXT    LAN(@"请重新绘制图案")
#define JINN_LOCK_OLD_TEXT       LAN(@"请绘制手势密码")
#define JINN_LOCK_OLD_TEXT2       LAN(@"请绘制原手势密码")
#define JINN_LOCK_OLD_ERROR_TEXT LAN(@"绘制错误,还可以输入%d次")
#define JINN_LOCK_RE_OLD_TEXT    LAN(@"请重新绘制原手势密码")
#define JINN_LOCK_CHECK_TEXT     LAN(@"密码登录")
#define JINN_LOCK_CHECK_TEXT2     LAN(@"验证登录密码")

#endif// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
