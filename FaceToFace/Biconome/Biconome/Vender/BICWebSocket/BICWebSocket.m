//
//  BICWebSocket.m
//  Socket
//
//  Created by WangZhaomeng on 2017/11/1.
//  Copyright © 2017年 WangZhaomeng. All rights reserved.
//

#import "BICWebSocket.h"

@interface BICWebSocket ()<SRWebSocketDelegate>
@property (nonatomic, strong) SRWebSocket *socket;
@property (nonatomic, strong) NSString    *url;
@property (nonatomic, assign) BOOL        isOpen;
@property (nonatomic, weak) NSTimer *heartBeat;
@property (nonatomic, assign)int reConnectTime;
@end

@implementation BICWebSocket

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)openWithDelegate{
    if (_isOpen == NO) {
        _isOpen = YES;
        NSURL *URL = [NSURL URLWithString:_url];
        _socket = [[SRWebSocket alloc] initWithURL:URL];
        //  设置代理线程queue
        NSOperationQueue * queue=[[NSOperationQueue alloc]init];
        queue.maxConcurrentOperationCount=1;
        [_socket setDelegateOperationQueue:queue];
        _socket.delegate = self;
        [_socket open];
    }
}

// 初始化心跳
- (void)initHeartBeat
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf destroyHeartBeat];
            //心跳设置为3分钟，NAT超时一般为5分钟
            weakSelf.heartBeat = [NSTimer scheduledTimerWithTimeInterval:3*60 repeats:YES block:^(NSTimer * _Nonnull timer) {
                NSLog(@"heart");
                //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
                [weakSelf sendString:@"heart"];
            }];
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.heartBeat forMode:NSRunLoopCommonModes];
    });
}

// 取消心跳
- (void)destroyHeartBeat
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.heartBeat) {
            [weakSelf.heartBeat invalidate];
            weakSelf.heartBeat=nil;
        }
    });
}


//  重连机制
- (void)reConnect
{
    [self close];
    __weak typeof (self) weakSelf = self;
    //  超过一分钟就不再重连   之后重连5次  2^5=64
    if (self.reConnectTime>64) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.socket=nil;
        [weakSelf openWithDelegate];
    });
    
    //   重连时间2的指数级增长
    if (self.reConnectTime == 0) {
        self.reConnectTime =2;
    } else {
        self.reConnectTime *=2;
    }
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"webSocketDidOpen");
    //   连接成功 开始发送心跳
    [self initHeartBeat];
}
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string{
    NSLog(@"didReceiveMessageWithString");
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data{
    NSLog(@"didReceiveMessageWithData");
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
    //失败了去重连
    [self reConnect];
    //断开连接时销毁心跳
    [self destroyHeartBeat];
}
//网络连接中断被调用
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"didCloseWithCode");
    //失败了去重连
    [self reConnect];
    //断开连接时销毁心跳
    [self destroyHeartBeat];
}
//sendPing的时候，如果网络通的话，则会收到回调，但是必须保证ScoketOpen，否则会crash
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload
{
    NSLog(@"收到pong回调");
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"didReceiveMessage");
}


- (void)close {
    if (_socket && _isOpen) {
        _isOpen = NO;
        [_socket close];
        _socket.delegate = nil;
        _socket = nil;
    }
}

- (void)sendString:(NSString *)string {
    if (_socket && _isOpen) {
//        NSError *error;
//        [_socket sendString:string error:&error];
//        if (error) {
//            NSLog(@"错误信息：%@",error);
//        }
        [_socket send:string];
    }
}

- (void)sendData:(NSData *)data {
    if (_socket && _isOpen) {
//        NSError *error;
//        [_socket sendData:data error:&error];
//        if (error) {
//            NSLog(@"错误信息：%@",error);
//        }
        [_socket send:data];
    }
}

@end
