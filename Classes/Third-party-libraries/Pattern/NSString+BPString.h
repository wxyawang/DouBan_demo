//
//  NSString+BPString.h
//  TestZone
//
//  Created by JiFu on 3/11/14.
//  Copyright (c) 2014 gmacsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPString)
-(BOOL)isNumber;
-(BOOL)isContainString:(NSString *)str;
-(NSString *)getStringWithPattern:(NSString *)pattern;
-(NSString *)forceNumber;
-(NSString *)deleteString:(NSString *)string;
-(BOOL)isEmpty;
@end
