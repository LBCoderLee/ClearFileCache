//
//  LBClearCacheTool.h
//  clearTest
//
//  Created by li  bo on 16/5/29.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBClearCacheTool : NSObject

/**
 *  @author li bo, 16/05/29
 *
 *  获取path路径文件夹的大小
 *
 *  @param path 要获取大小的文件夹全路径
 *
 *  @return 返回path路径文件夹的大小
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;

/**
 *  @author li bo, 16/05/29
 *
 *  清除path路径文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹全路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;

@end
