//
//  NSString+SFAdd.m
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import "NSString+SFAdd.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"

@implementation NSString (SFAdd)

+ (NSAttributedString *)attributedString:(NSString *)str withSpace:(CGFloat)space{
    if (str == nil) {
        str = @"";
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str attributes:
                                      @{NSParagraphStyleAttributeName:
                                            paragraphStyle
                                        }];
    return attrString;
}

+ (NSAttributedString *)attributedString:(NSString *)str withFont:(UIFont *)font{
    if (str == nil) {
        str = @"";
    }
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str attributes:
                                      @{NSFontAttributeName:font
                                        }];
    return attrString;
}


+ (NSMutableAttributedString *)dealFont:(NSString *)text
                         withChangeText:(NSString *)changeText
                              withColor:(UIColor *)color
                               withFont:(UIFont *)font
{
    
    if (![text containsString:changeText]) {
        return [[NSMutableAttributedString alloc] initWithString:@""];;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:changeText];
    [str addAttribute:NSFontAttributeName value:font range:range];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
     
    return str;
}


+ (NSMutableAttributedString *)dealFont:(NSString *)text
                       withChangeTextAr:(NSArray *)changeTextAr
                              withColor:(UIColor *)color
                               withFont:(UIFont *)font
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSString *texts in changeTextAr) {
        NSRange range = [text rangeOfString:texts];
        [str addAttribute:NSFontAttributeName value:font range:range];
        [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return str;
}
+ (NSString *)userAgentStr{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], deviceString, [[UIDevice currentDevice] systemVersion], ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f)];
}

- (NSString *)URLEncoding{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              NULL,
                                                                                              kCFStringEncodingUTF8 ));
    return result;
}

- (NSString *)URLDecoding{
    NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)md5Str{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *) sha1Str{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)base64Str{
    NSData *data=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str=[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64Str;
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    resultSize = rect.size;
    return resultSize;
}

- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}

- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

- (BOOL)containsEmoji{
    if (!self || self.length <= 0) {
        return NO;
    }
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte{
    NSString *sizeDisplayStr;
    if (sizeOfByte < 1024) {
        sizeDisplayStr = [NSString stringWithFormat:@"%.2f bytes", sizeOfByte];
    }else{
        CGFloat sizeOfKB = sizeOfByte/1024;
        if (sizeOfKB < 1024) {
            sizeDisplayStr = [NSString stringWithFormat:@"%.2f KB", sizeOfKB];
        }else{
            CGFloat sizeOfM = sizeOfKB/1024;
            if (sizeOfM < 1024) {
                sizeDisplayStr = [NSString stringWithFormat:@"%.2f M", sizeOfM];
            }else{
                CGFloat sizeOfG = sizeOfKB/1024;
                sizeDisplayStr = [NSString stringWithFormat:@"%.2f G", sizeOfG];
            }
        }
    }
    return sizeDisplayStr;
}

- (NSString *)trimWhitespace{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

- (BOOL)isEmpty{
    return [[self trimWhitespace] isEqualToString:@""];
}

//判断是否为整形
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}

- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    return [self substringWithRange:[self rangeByTrimmingLeftCharactersInSet:characterSet]];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    return [self substringWithRange:[self rangeByTrimmingRightCharactersInSet:characterSet]];
}

//转换拼音
- (NSString *)transformToPinyin {
    if (self.length <= 0) {
        return self;
    }
    NSString *tempString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = (NSMutableString *)[tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [tempString uppercaseString];
}

//计算字符串宽度
-(CGFloat)widthOfContent:(NSString *)content andFont:(UIFont*) font andColor:(UIColor*)color{
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: color};
    CGSize stringBoundingBox=[content sizeWithAttributes:userAttributes];
    
    return stringBoundingBox.width;
}

-(BOOL)sfContainString:(NSString *)str{
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_8_0) {
        return [self containsString:str];
    }
    
    return [self rangeOfString:str].location!=NSNotFound;
}

+ (NSString *)randomString{
    NSInteger num = arc4random() % 10000;
    NSString *randomString = [NSString stringWithFormat:@"%.4ld",(long)num];
    return randomString;
}

#pragma mark - 验证
#pragma mark -
- (BOOL)isValidEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    emailRegex=@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhone {
    if (self.length != 11) {
        return NO;
    }
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|8[0-9]|9[89]|7[0678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

//短信验证码验证
- (BOOL)isValidCode{
    NSString *pattern = @"^[0-9]{6}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//邮编验证
- (BOOL)isValidPostCode{
    NSString *pattern = @"^[0-9]{6}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//车牌号验证
- (BOOL)isValidCarNo{
    if (self.length!=7) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-zA-Z_0-9]{5}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma 正则匹配用户密码6-18位数字或字母组合
- (BOOL)isValidPassword{
    NSString *pattern = @"^[a-zA-Z0-9]{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma 正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位
- (BOOL)checkUserIdCard{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma 正则匹配URL
- (BOOL)checkURL{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - emoji
#pragma mark -
- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

- (BOOL)isContainEmoji{
    if (!self || self.length <= 0) {
        return NO;
    }
    
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

- (NSString*)removeEmoji{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}

@end