//
//  NSString+BPString.m
//  TestZone
//
//  Created by JiFu on 3/11/14.
//  Copyright (c) 2014 gmacsoft. All rights reserved.
//

#import "NSString+BPString.h"
#import "BPTestBase.h"
@implementation NSString (BPString)
-(NSString *)forceNumber;
{
    NSString *str=BPNullString;
    if ([self isNumber] == NO) {
        return str;
    }
    
    NSRegularExpression *regExp=[NSRegularExpression regularExpressionWithPattern:@"^\\s*(-?\\d+\\.?\\d*)\\s*$" options:NSRegularExpressionCaseInsensitive error:NULL];
    
    NSArray *matches =[ regExp matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange firstHalfRange = [match rangeAtIndex:1];
        str = [self    substringWithRange:firstHalfRange];
        break;
    }
    return str;
}
-(BOOL)isNumber;
{
    if (self == nil) {
        return NO;
    }
    NSRegularExpression *regExp=[NSRegularExpression regularExpressionWithPattern:@"^\\s*-?\\d+\\.?\\d*\\s*$" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSUInteger num = [regExp numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if (num < 1) {
        return NO;
    }
    return YES;
    
}

-(NSString *)getStringWithPattern:(NSString *)pattern
{
    NSString *str=nil;
    
    NSRegularExpression *regExp=[NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
    @try {
        NSArray *matches =[ regExp matchesInString:self options:0 range:NSMakeRange(0, self.length)];
        
        for (NSTextCheckingResult *match in matches) {
            NSRange firstHalfRange = [match rangeAtIndex:1];
            str = [self    substringWithRange:firstHalfRange];
            break;
        }
    }
    @catch (NSException *exception) {
    
        NSLog(@"<Exception> getStringWithPattern");
    }
    return str;
}

-(BOOL)isEmpty;
{
    if (self == nil || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

-(BOOL)isContainString:(NSString *)str;
{
    NSRegularExpression *regExp=[NSRegularExpression regularExpressionWithPattern:str options:NSRegularExpressionCaseInsensitive error:NULL];
    NSUInteger num = [regExp numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if (num < 1) {
        return NO;
    }
    return YES;
}
-(NSString *)deleteString:(NSString *)string;
{
    NSMutableString *str=[NSMutableString stringWithString:self];
    
    NSRegularExpression *regExp=[NSRegularExpression regularExpressionWithPattern:string options:NSRegularExpressionCaseInsensitive error:NULL];
    @try {
        [ regExp replaceMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"<Exception> deleteString");
    }
    return (NSString *)str;
    
}
@end
