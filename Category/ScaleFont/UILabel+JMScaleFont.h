//
//  UILabel+JMScaleFont.h
//  ImageTest
//
//  Created by Liuny on 2019/12/20.
//  Copyright © 2019 xiaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *根据屏幕宽度调整字体大小
 *此处就只对于使用xib、storyboard初始化控件有效,使用纯代码初始化的控件无效
 *使用方法：不需要调用任何代码，只需要把该.h .m文件加入，然后设置宏里面的放大比例即可
 *有些特殊的不需要字体放大，设置tag为kIgnoreScaleFontTag宏定义的数值
 */

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (JMScaleFont)

@end

@interface UIButton (JMScaleFont)

@end

@interface UITextField (JMScaleFont)

@end

@interface UITextView (JMScaleFont)

@end

NS_ASSUME_NONNULL_END
