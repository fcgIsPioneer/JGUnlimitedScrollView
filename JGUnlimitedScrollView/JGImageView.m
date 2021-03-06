//
//  JGImageView.m
//  无限轮播器
//
//  Created by FCG on 2017/5/27.
//  Copyright © 2017年 FCG. All rights reserved.
//

#import "JGImageView.h"

@interface JGImageView ()

@end

@implementation JGImageView


/**
*  设置图片
*
*  @param image       将图片传过来，任意类型，可以是图片的url，本地图片，或者是UIImage对象
*  @param placeholder 占位图
*/
- (void)jg_image:(id)image placeholder:(UIImage *)placeholder {
    if (image == nil) return;
    
    self.image = placeholder;
    if ([image isKindOfClass:[NSString class]]) {
        NSString *imageStr = (NSString *)image;
        
        if ([imageStr containsString:@"http://"] || [imageStr containsString:@"https://"]) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
                UIImage *image = [[UIImage alloc] initWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                });
            });
            /*
            [self sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];*/
        } else {
            UIImage *image = [UIImage imageNamed:imageStr];
            if (image == nil) {
                imageStr = [NSString stringWithFormat:@"%@%@", imageStr, @".jpg"];
                image = [UIImage imageNamed:imageStr];
            }
            
            if (image == nil) {
                image = [[UIImage alloc] initWithContentsOfFile:imageStr];
            }
            [self setImage:image];
        }
    } else if ([image isKindOfClass:[UIImage class]]) {
        self.image = image;
    } else if ([image isKindOfClass:[NSURL class]]) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:(NSURL *)image];
            UIImage *image = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        });
        /*
        [self sd_setImageWithURL:(NSURL *)image placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];*/
    }
    
}

@end
