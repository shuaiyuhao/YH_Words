//
//  NSString+SFAdd.h
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SFAdd)


+ (NSAttributedString *)attributedString:(NSString *)str withSpace:(CGFloat)space;

+ (NSAttributedString *)attributedString:(NSString *)str withFont:(UIFont *)font;

+ (NSMutableAttributedString *)dealFont:(NSString *)text
                         withChangeText:(NSString *)changeText
                              withColor:(UIColor *)color
                               withFont:(UIFont *)font;

+ (NSMutableAttributedString *)dealFont:(NSString *)text
                       withChangeTextAr:(NSArray *)changeTextAr
                              withColor:(UIColor *)color
                               withFont:(UIFont *)font;


+ (NSString *)userAgentStr;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)md5Str;
- (NSString *)sha1Str;
- (NSString *)base64Str;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;

- (NSString *)trimWhitespace;
- (BOOL)isEmpty;

//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;

- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

//转换拼音
- (NSString *)transformToPinyin;

- (CGFloat)widthOfContent:(NSString *)content andFont:(UIFont*) font andColor:(UIColor*)color;

- (BOOL)sfContainString:(NSString*)str;

// 生成四位随机数
+ (NSString *)randomString;

#pragma mark - 验证
#pragma mark -

- (BOOL)isValidEmail;

- (BOOL)isValidPhone;

- (BOOL)isValidCode;

- (BOOL)isValidPostCode;

- (BOOL)isValidPassword;

- (BOOL)isValidCarNo;

- (BOOL)checkUserName;

- (BOOL)checkUserIdCard;

#pragma mark - emoji
#pragma mark -

- (BOOL)isContainEmoji;

- (NSString*)removeEmoji;

@end
