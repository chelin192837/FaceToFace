//
//  LLWebSocket.h
//  Socket
//
//  Created by WangZhaomeng on 2017/11/1.
//  Copyright © 2017年 WangZhaomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketRocket.h"

@interface BICWebSocket : NSObject

- (instancetype)initWithUrl:(NSString *)url;

- (void)openWithDelegate;

- (void)close;

- (void)sendString:(NSString *)string;

- (void)sendData:(NSData *)data;

@end
