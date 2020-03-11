//
//  SFTextFieldBuilder.m
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import "SFTextFieldBuilder.h"
#import "UIImageView+SFFly.h"

@interface SFTextFieldBuilder ()

@property (nonatomic,strong) UITextField *textField;

@end

@implementation SFTextFieldBuilder

- (instancetype)init{
    self = [super init];
    if (self) {
        self.textField = [UITextField new];
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

- (SFTextFieldBuilder *(^)(NSString *))text{
    return ^SFTextFieldBuilder *(NSString *text){
        self.textField.text = text;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIColor *))textColor{
    return ^SFTextFieldBuilder *(UIColor *textColor){
        self.textField.textColor = textColor;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(NSString *))placeholder{
    return ^SFTextFieldBuilder *(NSString *placeholder){
        self.textField.placeholder = placeholder;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIFont *))font{
    return ^SFTextFieldBuilder *(UIFont *font){
        self.textField.font = font;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(CGFloat))fontSize{
    return ^SFTextFieldBuilder *(CGFloat fontSize){
        self.textField.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (SFTextFieldBuilder *(^)(CGFloat))cornerRadius{
    return ^SFTextFieldBuilder *(CGFloat cornerRadius){
        if (cornerRadius > 0) {
            self.textField.layer.cornerRadius = cornerRadius;
            self.textField.layer.masksToBounds = YES;
        }else{
            self.textField.layer.cornerRadius = 0;
        }
        
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIColor *))borderColor{
    return ^SFTextFieldBuilder *(UIColor *borderColor){
        self.textField.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(CGFloat))borderWidth{
    return ^SFTextFieldBuilder *(CGFloat borderWidth){
        self.textField.layer.borderWidth = borderWidth;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIColor *))backgroundColor{
    return ^SFTextFieldBuilder *(UIColor *backgroundColor){
        self.textField.backgroundColor = backgroundColor;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIKeyboardType))keyboardType{
    return ^SFTextFieldBuilder *(UIKeyboardType keyboardType){
        self.textField.keyboardType = keyboardType;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UITextFieldViewMode))clearButtonMode{
    return ^SFTextFieldBuilder *(UITextFieldViewMode clearButtonMode){
        self.textField.clearButtonMode = clearButtonMode;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIView *))leftView{
    return ^SFTextFieldBuilder *(UIView *leftView){
        self.textField.leftView = leftView;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIView *))rightView{
    return ^SFTextFieldBuilder *(UIView *rightView){
        self.textField.rightView = rightView;
        return self;
    };
}

- (SFTextFieldBuilder *(^)(UIImage *, CGSize))leftImage{
    return ^SFTextFieldBuilder *(UIImage *image, CGSize size){
        UIView *leftView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,size}];
        UIImageView *imageView = [UIImageView imageViewWithImage:image];
        [leftView addSubview:imageView];
        imageView.center = leftView.center;
        self.textField.leftView = leftView;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        
        return self;
    };
}

- (SFTextFieldBuilder *(^)(CGFloat))leftPadding{
    return ^SFTextFieldBuilder *(CGFloat leftPadding){
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, 5)];
        self.textField.leftView = paddingView;
        paddingView.backgroundColor = self.textField.backgroundColor;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        
        return self;
    };
}

- (SFTextFieldBuilder *(^)(CGFloat))rightPadding{
    return ^SFTextFieldBuilder *(CGFloat rightPadding){
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightPadding, 5)];
        self.textField.rightView = paddingView;
        paddingView.backgroundColor = self.textField.backgroundColor;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        
        return self;
    };
}

- (UITextField *(^)(void))build{
    return ^UITextField *(void){
        return self.textField;
    };
}

@end
