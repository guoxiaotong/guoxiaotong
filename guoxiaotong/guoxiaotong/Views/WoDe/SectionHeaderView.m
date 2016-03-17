//
//  SectionHeaderView.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "SectionHeaderView.h"
#import "GroupModel.h"

@interface SectionHeaderView()

@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)UILabel *numLabel;

@end

@implementation SectionHeaderView

+ (instancetype)headerWithTableView:(UITableView *)tableView {
    SectionHeaderView *header = [[SectionHeaderView alloc]  init];
    return header;
}

- (instancetype)init {
    if (self = [super init]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:@"section_closed"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置小三角图片的内边距
        btn.contentEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);
        //设置按钮上文字距离小三角图片的距离
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);
        //设置按钮上分组标题的文本颜色（默认是白色）
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        // 设置btn中的图片不填充整个imageview
        btn.imageView.contentMode = UIViewContentModeCenter;
        // 超出范围的图片不要剪切
        btn.imageView.layer.masksToBounds = NO;
        //把按钮添加到视图
        btn.layer.borderWidth = 0.25;
        self.btn = btn;
        [self addSubview:self.btn];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor=[UIColor grayColor];
        [self addSubview:lab];
        self.numLabel = lab;
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]){
    }
    return self;
}

-(void)btnOnclick:(UIButton *)btn
 {
  //修改模型的isopen属性
    //1.修改模型数据
    self.group.open = !self.group.isOpen;
    //2.刷新表格
    //（刷新表格的功能由控制器完成，在这里可以设置一个代理），当按钮被点击的时候，就通知代理对表格进行刷新
    //通知代理
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickHeaderView:)]) {
          [self.delegate headerViewDidClickHeaderView:self];
      }
  }

 //当控件的frame值改变时，会自动调用该方法，故可以在该方法中设置控件的frame;
 -(void)layoutSubviews {
    [super layoutSubviews];
     //设置按钮的frame和头部视图一样大小
    self.btn.frame = self.bounds;
    //设置lab的frame
    CGFloat padding = 20;
    CGFloat labW = 50;
    CGFloat labH = self.frame.size.height;
    CGFloat labY = 0;
    CGFloat labX = self.frame.size.width-padding-labW;
    self.numLabel.frame = CGRectMake(labX, labY, labW, labH);
}

#pragma mark - 当一个控件被添加到其它视图上的时候会调用以下方法
 // 已经被添加到父视图上的时候会调用
 - (void)didMoveToSuperview {
    // 在这个方法中就快要拿到最新的被添加到tableview上的头部视图修改它的图片
    if (self.group.isOpen) {
    //让小三角图片向下旋转
//          self.btn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self.btn setImage:[UIImage imageNamed:@"section_opened"] forState:UIControlStateNormal];
    }
 }

 // 即将被添加到父视图上的时候会调用
 - (void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@"将要添加到视图了");
 }


 //重写get方法，设置数据
 -(void)setGroup:(GroupModel *)group {
    _group=group;
     //设置分组标题
    //self.btn.titleLabel.text=_group.name;
    #warning 请注意在设置按钮的文本时，一定要设置按钮的状态，像上面这样设置不会显示
    [self.btn setTitle:_group.name forState:UIControlStateNormal];
//    NSLog(@"%@",self.btn.titleLabel.text);
     //设置在线人数
//     self.lab.text=[NSString stringWithFormat:@"%@/%d",_group.online,_group.friends.count];
 }
@end
