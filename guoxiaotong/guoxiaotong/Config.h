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
/**文字根URL*/
extern const NSString *API_ROOT_URL;
/**图片及其他根URL*/
static NSString * const API_ROOT_IMAGE_URL = @"http://www.ketangzhiwai.com/";

/**验证码*/
static NSString * const API_GETCODE_URL = @"getCode.page?";
static NSString * const API_CHECKCODE_URL = @"checkCode.page?";
/**注册登录及找回修改密码*/
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
//地址接口
static NSString * const API_BASIC_PROVINCE_URL = @"basic/province.page";
static NSString * const API_BASIC_CITY_URL = @"basic/city.page?";
static NSString * const API_BASIC_COUNTY_URL = @"basic/county.page?";

static NSString * const API_CONTACTLIST_URL = @"dynamic/contact.page?";
/**校长信箱接口（参数：userId，page）*/
static NSString * const API_XIAOZHANG_EMAILLIST_URL = @"dynamic/rainList.page";

//管理相关接口
static NSString * const API_BASIC_CLASSLIST_URL = @"basic/classes.page?";
/**学校：（+schoolId显示学校信息）（+cityName得到学校列表）*/
static NSString * const API_BASIC_SCHOOLLIST_URL = @"basic/school.page?";
static NSString * const API_BASIC_STUDENTLIST_URL = @"basic/students.page?";
static NSString * const API_BASIC_SCHOOL_COURSELIST_URL = @"basic/course.page?";
static NSString * const API_BASIC_CLASS_COURSELIST_URL = @"basic/courseByclasses.page?";

static NSString * const API_BASIC_RELATION_URL = @"basic/relation.page";

static NSString * const API_BASIC_TEACHERLIST_URL = @"basic/teacher.page?";
static NSString * const API_BASIC_GUARDIANLIST_URL = @"basic/guardian.page?";//监护人
static NSString * const API_BASIC_JIAZHANGLIST_URL = @"basic/manager.page?";
static NSString * const API_JIAZHANG_GET_PERMISSION_URL = @"classes/oldGuardianSetting.page";
static NSString * const API_JIAZHANG_SET_PERMISSION_URL = @"classes/guardianSetting.page";

static NSString * const API_ADD_SCHOOL_URL = @"school/addSchool.page?";
static NSString * const API_ADD_CLASS_URL = @"school/addGrade.page?";
static NSString * const API_EDIT_CLASS_URL = @"school/editGrade.page?";
static NSString * const API_ADD_SCHOOL_TEACHER_URL = @"school/addTeacher.page?";
static NSString * const API_DEL_SCHOOL_TEACHER_URL = @"school/delTeacher.page?";
static NSString * const API_EDIT_SCHOOL_COURSE_URL = @"school/editCourse.page?";
static NSString * const API_DEL_SCHOOL_COURSE_URL = @"school/deleteCourse.page?";
static NSString * const API_ADD_SCHOOL_COURSE_URL = @"school/addCourse.page?";

static NSString * const API_SET_MASTER_URL = @"school/setMaster.page?";
static NSString * const API_SET_SCHOOL_SETTING_URL = @"school/setting.page?";
static NSString * const API_SCHOOL_SETTING_URL = @"school/oldSetting.page?";

static NSString * const API_ADD_CHILD_URL = @"school/addRole.page?";
static NSString * const API_APPLY_XIAOZHANG_URL = @"school/applyPrincipal.page";

static NSString * const API_ROLE_URL = @"role/role.page?";//userId = 0全部
static NSString * const API_ROLE_PERMISSION_URL = @"role/rolePermission.page?";


//banzhuren
static NSString * const API_CLASS_DEL_JIANHUREN_URL = @"classes/delGuardian.page?";
static NSString * const API_CLASS_GET_QUANXIAN_URL = @"classes/oldTutorSetting.page?";
static NSString * const API_CLASS_SET_QUANXIAN_URL = @"classes/tutorSetting.page?";


#endif /* Config_h */