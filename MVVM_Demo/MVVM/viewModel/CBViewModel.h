//
//  CBViewModel.h
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBViewModel : NSObject

@property (nonatomic,copy) NSString *aTitle;

@property (nonatomic,copy) NSString *aName;

@property (nonatomic,copy) NSString *aSex;

@property (nonatomic,copy) NSString *aAge;

@property (nonatomic,copy) NSString *aSuccess;


- (void)getModelData;

- (void)viewModelBtnClickedAction;

@end

NS_ASSUME_NONNULL_END
