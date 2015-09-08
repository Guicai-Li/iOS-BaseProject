//
//  BaseModel.h
//  BaseProject
//
//  Created by Guicai_Li on 15/8/5.
//  Copyright (c) 2015年 Guicai_Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (id)initWithDictionary:(NSDictionary*)jsonDic;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
