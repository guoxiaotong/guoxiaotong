//
//  DongTaiList.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DongTaiList : NSObject

//动态里的数据模型
proStr(content);//动态内容
proStr(dynamicId);//动态ID
proStr(dynamicType);//动态类型 0通知1分享
proStr(sendTime);//发送时间
proStr(isCollection);//是否收藏过
proStr(isPraise);//是否点过赞
proStr(praise);//点赞人的名字
proStr(title);//动态的接收人列表
proStr(readed);//未读条数
proStr(lastUser);//最后发送的人
//commentBean评论array

proArr(commentBean);



////picBean  array
proArr(picBean);
//proStr(desc);
//proStr(imageUrl);
//proStr(picId);

//userBean
proStr(birthday);
proStr(email);
proStr(loginName);
proStr(phone);
proStr(picPath);
proStr(qq);
proStr(userId);
proStr(userName);
proStr(userRoleId);
proStr(wechat);


@end
