//
//  JMCommonMethod.m
//  JMBaseProject
//
//  Created by Liuny on 2018/8/23.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMCommonMethod.h"

@implementation JMCommonMethod
+(NSMutableAttributedString *)navigationTitleWithColor:(UIColor *)color title:(NSString *)title{
    NSMutableAttributedString *rtn = [[NSMutableAttributedString alloc] initWithString:title];
    UIFont *font = [UIFont boldSystemFontOfSize:19.0];
    [rtn addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    [rtn addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];
    return rtn;
}
+(void)navigationItemSet:(UIButton *)item fontColor:(UIColor *)color{
    [item setTitleColor:color forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [item setTitleColor:color forState:UIControlStateNormal];
    UIColor *disableColor = [UIColor colorWithRGB:color.rgbValue alpha:0.2];
    [item setTitleColor:disableColor forState:UIControlStateDisabled];
}

+(NSMutableDictionary *)baseRequestParams{
    NSMutableDictionary *rtn = [[NSMutableDictionary alloc] init];
    NSString *sessionId = [JMProjectManager sharedJMProjectManager].loginUser.sessionId;
//    [rtn setJsonValue:sessionId key:@"sessionId"];
    [rtn setJsonValue:@"e01ee6fca2a4451ebc2db3f70998b0f9" key:@"sessionId"];
    return rtn;
}

//网络请求图片
+(NSURL *)imageUrlWithPath:(NSString *)imagePath{
    NSURL *rtn;
    if(imagePath.length == 0){
        return rtn;
    }
    if(![imagePath hasPrefix:@"http"]){
        NSString *allPath = [ImageBaseUrl stringByAppendingPathComponent:imagePath];
        rtn = [NSURL URLWithString:allPath];
    }else{
        rtn = [NSURL URLWithString:imagePath];
    }
    return rtn;
}

+(NSString *)pinImagePath:(NSString *)path{
    NSString *rtn;
    if(path.length == 0){
        return @"";
    }
    if(![path hasPrefix:@"http"]){
        NSString *allPath = [ImageBaseUrl stringByAppendingPathComponent:path];
        rtn = allPath;
    }else{
        rtn = path;
    }
    return rtn;
}

+(void)shadowView:(UIView *)view{
    //阴影
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowOpacity = 0.04;
    //    view.layer.shadowRadius = 5;
}

+(NSString *)autoFitImageHtml:(NSString *)goodHtml{
    NSMutableString *headHtml = [[NSMutableString alloc] initWithCapacity:0];
    [headHtml appendString : @"<html>" ];
    [headHtml appendString : @"<head>" ];
    [headHtml appendString : @"<meta charset=\"utf-8\">" ];
    [headHtml appendString : @"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />" ];
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />" ];
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />" ];
    [headHtml appendString : @"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />" ];
    
    //适配图片宽度，让图片宽度等于屏幕宽度
    //[headHtml appendString : @"<style>img{width:100%;}</style>" ];
    //[headHtml appendString : @"<style>img{height:auto;}</style>" ];
    
    //适配图片宽度，让图片宽度最大等于屏幕宽度
    //    [headHtml appendString : @"<style>img{max-width:100%;width:auto;height:auto;}</style>"];
    
    
    //适配图片宽度，如果图片宽度超过手机屏幕宽度，就让图片宽度等于手机屏幕宽度，高度自适应，如果图片宽度小于屏幕宽度，就显示图片大小
    [headHtml appendString : @"<script type='text/javascript'>"
     "window.onload = function(){\n"
     "var maxwidth=document.body.clientWidth;\n" //屏幕宽度
     "for(i=0;i <document.images.length;i++){\n"
     "var myimg = document.images[i];\n"
     "if(myimg.width > maxwidth){\n"
     "myimg.style.width = '100%';\n"
     "myimg.style.height = 'auto'\n;"
     "}\n"
     "}\n"
     "}\n"
     "</script>\n"];
    
    [headHtml appendString : @"<style>table{width:100%;}</style>" ];
    [headHtml appendString : @"<title>webview</title>" ];
    NSString *bodyHtml;
    bodyHtml = [NSString stringWithString:headHtml];
    bodyHtml = [bodyHtml stringByAppendingString:goodHtml];
    return bodyHtml;
}
@end
