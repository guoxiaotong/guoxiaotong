//
//  GroupModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray *members;

@property (nonatomic, assign, getter=isOpen)BOOL open;

@end
