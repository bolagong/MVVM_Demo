//
//  CBViewModel.m
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import "CBViewModel.h"
#import "CBModel.h"

@interface CBViewModel ()

@property (nonatomic,strong) CBModel *aModel;

@end


@implementation CBViewModel


- (void)getModelData {
    
    _aModel = [[CBModel alloc] init];
    _aModel.titleStr = @"个人信息提交";
    _aModel.nameStr = @"张小豪";
    _aModel.sexStr = @"男";
    _aModel.ageStr = @"19";
    _aModel.successStr = @"1";
    
    
    //利用runtime获取属性,把model的属性和ViewModel的属性绑定到一起
    unsigned int aCount = 0;
    objc_property_t *aProperties = class_copyPropertyList([self.aModel class], &aCount);
    for (int i=0; i<aCount; i++) {
        objc_property_t aProperty = aProperties[i];
        const char *aName = property_getName(aProperty);
        NSString *nameStr = [NSString stringWithUTF8String:aName];
        
        if ([nameStr isEqualToString:@"titleStr"]
            || [nameStr isEqualToString:@"nameStr"]
            || [nameStr isEqualToString:@"sexStr"]
            || [nameStr isEqualToString:@"ageStr"]
            || [nameStr isEqualToString:@"successStr"] ) {
            
            // 利用RAC检测aModel的属性变化
            @weakify(self);
            [[self.aModel rac_valuesAndChangesForKeyPath:nameStr options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) observer:nil] subscribeNext:^(RACTuple * _Nullable x) {
                @strongify(self);
                if ([nameStr isEqualToString:@"titleStr"]) {
                    self.aTitle = x.first?:@"";
                }else if ([nameStr isEqualToString:@"nameStr"]) {
                    self.aName = x.first?:@"";
                }else if ([nameStr isEqualToString:@"sexStr"]) {
                    self.aSex = x.first?:@"";
                }else if ([nameStr isEqualToString:@"ageStr"]) {
                    self.aAge = x.first?:@"";
                }else if ([nameStr isEqualToString:@"successStr"]) {
                    self.aSuccess = x.first?:@"";
                }
            }];
        }
    }
}

- (void)viewModelBtnClickedAction {
    
    if ([self.aModel.successStr isEqualToString:@"1"]) {
        
        self.aModel.titleStr = @"信息错误";
        self.aModel.nameStr = @"xxx";
        self.aModel.sexStr = @"xxx";
        self.aModel.ageStr = @"xxx";
        self.aModel.successStr = @"xxx";
        
    }else {
        self.aModel.titleStr = @"个人信息提交";
        self.aModel.nameStr = @"张小豪";
        self.aModel.sexStr = @"男";
        self.aModel.ageStr = @"19";
        self.aModel.successStr = @"1";
    }
}



@end
