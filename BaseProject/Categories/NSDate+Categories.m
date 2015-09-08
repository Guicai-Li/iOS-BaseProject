//
//  NSDate+Categories.m
//  BaseProject
//
//  Created by Guicai_Li on 3/13/14.
//  Copyright (c) 2014 Guicai_Li. All rights reserved.
//

#import "NSDate+Categories.h"
#import "NSUserDefaults+Categories.h"

@implementation NSDate (Categories)

+ (BOOL)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];

    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference day] < 0;
}

+ (NSDate *)ChinaDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
}

+ (void)saveLastOpenDate {
    [NSUserDefaults setObject:[self ChinaDate] forKey:@"LastOpenDate"];
    [NSUserDefaults synchronize];
}

+ (NSDate *)lastOpenDate {
    NSDate *date = (NSDate *) [NSUserDefaults objectForKey:@"LastOpenDate"];
    return (date == nil) ? [NSDate distantPast] : date;
}

+ (void)saveLastOpenDiagnoseDate {
    [NSUserDefaults setObject:[self ChinaDate] forKey:@"LastOpenDiagnoseDate"];
    [NSUserDefaults synchronize];
}

+ (NSDate *)lastOpenDiagnose {
    NSDate *date = (NSDate *) [NSUserDefaults objectForKey:@"LastOpenDiagnoseDate"];
    return (date == nil) ? [NSDate distantPast] : date;
}

@end
