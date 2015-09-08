//
//  BaseModel.m
//  BaseProject
//
//  Created by Guicai_Li on 15/8/5.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (id)initWithDictionary:(NSDictionary*)jsonDic
{
    if ((self = [super init]))
    {
        [self setValuesForKeysWithDictionary:jsonDic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"Undefined Key:%@ in %@",key,[self class]);
}

#pragma mark 数据持久化
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        if (propertyValue)
        {
            [aCoder encodeObject:propertyValue forKey:propertyName];
        }
    }
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([self class], &outCount);
        
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            
            NSString *capital = [[propertyName substringToIndex:1] uppercaseString];
            NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[propertyName substringFromIndex:1]];
            
            SEL sel = NSSelectorFromString(setterSelStr);
            
            [self performSelectorOnMainThread:sel
                                   withObject:[aCoder decodeObjectForKey:propertyName]
                                waitUntilDone:[NSThread isMainThread]];
        }
    }
    return self;
}

@end
