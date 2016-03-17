//
//  Config.h
//  guoxiaotong
//
//  Created by zxc on 16/3/8.
//  Copyright © 2016年 StenpChou. All rights reserved.
//
#ifndef Config_h
#define Config_h

#import <Foundation/Foundation.h>


extern const NSString *API_ROOT_URL;
//验证码
static NSString * const API_GETCODE_URL = @"getCode.page?";
static NSString * const API_CHECKCODE_URL = @"checkCode.page?";
//注册登录及找回修改密码
static NSString * const API_LOGIN_URL = @"user/login.page?";
static NSString * const API_REGISTER_URL = @"user/reg.page?";
static NSString * const API_RESET_PWD_URL = @"user/resetPassword.page?";
static NSString * const API_EDIT_PWD_URL = @"user/updatePassword.page?";
//获得及修改资料
static NSString * const API_PROFILE_URL = @"user/userinfo.page?";
static NSString * const API_EDIT_PROFILE_URL = @"user/editInfo.page?";
//修改头像
static NSString * const API_UPDATE_ICON_URL = @"user/upload.page?";
//获取角色列表
static NSString * const API_ROLELIST_URL = @"user/userinfo.page?";

static NSString * const API_BASIC_PROVINCE_URL = @"basic/province.page";
static NSString * const API_BASIC_CITY_URL = @"basic/city.page?";
static NSString * const API_BASIC_COUNTY_URL = @"basic/county.page?";

static NSString * const API_BASIC_CLASSLIST_URL = @"basic/classes.page?";


#endif /* Config_h */