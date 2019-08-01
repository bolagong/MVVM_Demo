//
//  CBView.m
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import "CBView.h"

@implementation CBView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        [self viewLayout];
    }
    return self;
}

- (void)viewLayout {
    CGSize mainSize = self.frame.size;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 80, mainSize.width-12*2, 30)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_titleLabel.frame)+30, 100, 30)];
    _nameLabel.font = [UIFont systemFontOfSize:16.0];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    
    _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_nameLabel.frame)+30, 100, 30)];
    _sexLabel.backgroundColor = [UIColor lightGrayColor];
    _sexLabel.font = [UIFont systemFontOfSize:16.0];
    _sexLabel.textColor = [UIColor whiteColor];
    [self addSubview:_sexLabel];
    
    _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_sexLabel.frame)+30, 100, 30)];
    _ageLabel.backgroundColor = [UIColor lightGrayColor];
    _ageLabel.font = [UIFont systemFontOfSize:16.0];
    _ageLabel.textColor = [UIColor whiteColor];
    [self addSubview:_ageLabel];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(20, CGRectGetMaxY(_ageLabel.frame)+30, mainSize.width-20*2, 40);
    [_sureBtn setTitle:@"-点我刷新数据-" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(onPrintClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sureBtn];
    
    _successLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_sureBtn.frame)+50, mainSize.width-30*2, 40)];
    _successLabel.font = [UIFont boldSystemFontOfSize:16.0];
    _successLabel.textAlignment = NSTextAlignmentCenter;
    _successLabel.textColor = [UIColor blueColor];
    [self addSubview:_successLabel];
}

- (void)onPrintClick:(UIButton *)sender {
    [self.aViemModel viewModelBtnClickedAction];
}


- (void)showView:(CBViewModel *)viewModel {
    
    self.aViemModel = viewModel;
    
    //利用runtime获取属性,把ViewModel的属性和view视图的属性绑定到一起。
    unsigned int aCount = 0;
    objc_property_t *aProperties = class_copyPropertyList([viewModel class], &aCount);
    for (int i=0; i<aCount; i++) {
        objc_property_t aProperty = aProperties[i];
        const char *aName = property_getName(aProperty);
        NSString *nameStr = [NSString stringWithUTF8String:aName];
        
        if ([nameStr isEqualToString:@"aTitle"]
            || [nameStr isEqualToString:@"aName"]
            || [nameStr isEqualToString:@"aSex"]
            || [nameStr isEqualToString:@"aAge"]
            || [nameStr isEqualToString:@"aSuccess"] ) {
            
            // 利用RAC检测viewModel的属性变化
            @weakify(self);
            [[viewModel rac_valuesAndChangesForKeyPath:nameStr options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) observer:nil] subscribeNext:^(RACTuple * _Nullable x) {
                @strongify(self);
                if ([nameStr isEqualToString:@"aTitle"]) {
                    self.titleLabel.text = x.first?:@"";
                }else if ([nameStr isEqualToString:@"aName"]) {
                    self.nameLabel.text = x.first?:@"";
                }else if ([nameStr isEqualToString:@"aSex"]) {
                    self.sexLabel.text = x.first?:@"";
                }else if ([nameStr isEqualToString:@"aAge"]) {
                    self.ageLabel.text = x.first?:@"";
                }else if ([nameStr isEqualToString:@"aSuccess"]) {
                    self.successLabel.text = x.first?:@"";
                }
            }];
        }
    }
}



@end
