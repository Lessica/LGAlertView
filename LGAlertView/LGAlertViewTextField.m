//
//  LGAlertViewTextField.m
//  LGAlertView
//
//
//  The MIT License (MIT)
//
//  Copyright © 2015 Grigory Lutkov <Friend.LGA@gmail.com>
//  (https://github.com/Friend-LGA/LGAlertView)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "LGAlertViewTextField.h"
#import "LGAlertViewHelper.h"

@interface LGAlertViewTextField ()

@property (nonatomic, strong) UIColor *colorButtonClearHighlighted;
@property (nonatomic, strong) UIColor *colorButtonClearNormal;

@property (nonatomic, strong) UIImage *imageButtonClearHighlighted;
@property (nonatomic, strong) UIImage *imageButtonClearNormal;

@end

@implementation LGAlertViewTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += LGAlertViewPaddingWidth;
    bounds.size.width -= LGAlertViewPaddingWidth * 2.0;

    if (self.leftView) {
        bounds.origin.x += CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
        bounds.size.width -= CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
    }

    if (self.rightView) {
        bounds.size.width -= CGRectGetWidth(self.rightView.bounds) + LGAlertViewPaddingWidth;
    }
    else if (self.clearButtonMode == UITextFieldViewModeAlways) {
        bounds.size.width -= 20.0;
    }

    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.x += LGAlertViewPaddingWidth;
    bounds.size.width -= LGAlertViewPaddingWidth * 2.0;

    if (self.leftView) {
        bounds.origin.x += CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
        bounds.size.width -= CGRectGetWidth(self.leftView.bounds) + LGAlertViewPaddingWidth;
    }

    if (self.rightView) {
        bounds.size.width -= CGRectGetWidth(self.rightView.bounds) + LGAlertViewPaddingWidth;
    }
    else if (self.clearButtonMode == UITextFieldViewModeAlways) {
        bounds.size.width -= 20.0;
    }

    return bounds;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self tintButtonClear];
}

- (void)setColorButtonClearHighlighted:(UIColor *)colorButtonClearHighlighted {
    _colorButtonClearHighlighted = colorButtonClearHighlighted;
}

- (void)setColorButtonClearNormal:(UIColor *)colorButtonClearNormal {
    _colorButtonClearNormal = colorButtonClearNormal;
}

- (UIButton *)buttonClear
{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *buttonClear = (UIButton *)v;
            return buttonClear;
        }
    }
    return nil;
}

- (void)tintButtonClear {
    UIButton *buttonClear = [self buttonClear];
    if (self.colorButtonClearNormal && self.colorButtonClearHighlighted && buttonClear) {
        if (!self.imageButtonClearHighlighted) {
            UIImage *imageHighlighted = [buttonClear imageForState:UIControlStateHighlighted];
            self.imageButtonClearHighlighted = [[self class] imageWithImage:imageHighlighted
                                                                  tintColor:self.colorButtonClearHighlighted];
        }
        if (!self.imageButtonClearNormal) {
            UIImage *imageNormal = [buttonClear imageForState:UIControlStateNormal];
            self.imageButtonClearNormal = [[self class] imageWithImage:imageNormal
                                                             tintColor:self.colorButtonClearNormal];
        }
        if (self.imageButtonClearHighlighted && self.imageButtonClearNormal)
        {
            [buttonClear setImage:self.imageButtonClearHighlighted forState:UIControlStateHighlighted];
            [buttonClear setImage:self.imageButtonClearNormal forState:UIControlStateNormal];
        }
    }
}


+ (UIImage *)imageWithImage:(UIImage *)image tintColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = (CGRect){ CGPointZero, image.size };
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [image drawInRect:rect];
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    UIImage *imageTinted = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageTinted;
}

@end
