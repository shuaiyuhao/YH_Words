//
//  SFNetworkActivityConsoleLogger.m
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/11/1.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "SFNetworkActivityConsoleLogger.h"

@implementation SFNetworkActivityConsoleLogger

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.level = AFLoggerLevelInfo;
    
    return self;
}


- (void)URLSessionTaskDidStart:(NSURLSessionTask *)task {
    NSURLRequest *request = task.originalRequest;
    
    NSString *body = nil;
    if ([request HTTPBody]) {
        body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    }
    
    switch (self.level) {
        case AFLoggerLevelDebug:
            NSLog(@"%@ '%@': %@ %@", [request HTTPMethod], [[request URL] absoluteString], [request allHTTPHeaderFields], body);
            break;
        case AFLoggerLevelInfo:
            NSLog(@"%@ '%@'", [request HTTPMethod], [[request URL] absoluteString]);
            break;
        default:
            break;
    }
}

- (void)URLSessionTaskDidFinish:(NSURLSessionTask *)task withResponseObject:(id)responseObject inElapsedTime:(NSTimeInterval )elapsedTime withError:(NSError *)error {
    NSUInteger responseStatusCode = 0;
    NSDictionary *responseHeaderFields = nil;
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        responseStatusCode = (NSUInteger)[(NSHTTPURLResponse *)task.response statusCode];
        responseHeaderFields = [(NSHTTPURLResponse *)task.response allHeaderFields];
    }
    
    if (error) {
        switch (self.level) {
            case AFLoggerLevelDebug:
            case AFLoggerLevelInfo:
            case AFLoggerLevelError:
                NSLog(@"[Error] %@ '%@' (%ld) [%.04f s]: %@", [task.originalRequest HTTPMethod], [[task.response URL] absoluteString], (long)responseStatusCode, elapsedTime, error);
            default:
                break;
        }
    } else {
        switch (self.level) {
            case AFLoggerLevelDebug:
                if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                    
                    NSString *jsonString;
                    
                    id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    if (jsonObject) {
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
                        
                        if (jsonData) {
                            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        }
                    }else {
                        jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    }
                    
                    NSLog(@"%ld '%@' [%.04f s]: %@ %@", (long)responseStatusCode, [[task.response URL] absoluteString], elapsedTime, responseHeaderFields, jsonString);
                }else {
                    
                    NSLog(@"%ld '%@' [%.04f s]: %@ %@", (long)responseStatusCode, [[task.response URL] absoluteString], elapsedTime, responseHeaderFields, responseObject);
                }
                break;
            case AFLoggerLevelInfo:
                NSLog(@"%ld '%@' [%.04f s]", (long)responseStatusCode, [[task.response URL] absoluteString], elapsedTime);
                break;
            default:
                break;
        }
    }
}

@end
