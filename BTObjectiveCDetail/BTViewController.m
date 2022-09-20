//
//  BTViewController.m
//  BTObjectiveCDetail
//
//  Created by blacktea on 20/9/22.
//

#import "BTViewController.h"

@interface BTViewController ()

@property (nonatomic, copy) NSString *dead_loop_bad;
@property (nonatomic, copy) NSString *dead_loop_good;

#pragma - mark Don't use copy  modifier to mutable Value

@property (nonatomic, copy) NSMutableArray* mutable_object_modifier_bad;
@property (nonatomic, strong) NSMutableArray* mutable_object_modifier_good;

#pragma - mark Using copy modifier to NSCopying Class

@property (nonatomic, strong) NSString* nscopying_class_bad;
@property (nonatomic, copy) NSString* nscopying_class_good;

@end

@implementation BTViewController


static NSObject* _staticVariable;


+ (void)initialize {
#pragma -mark "initialize" can only me execute once

    // bad
    _staticVariable = [NSObject alloc];
    
    // good
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _staticVariable = [NSObject alloc];
    });
    
    // good
    if ([self class] == [BTViewController class]) {
        _staticVariable = [NSObject alloc];
    }
#pragma -mark Don't invoke "super initialize"
    // bad
    [super initialize];
}

+ (void)load {
#pragma -mark Don't code in "+load" method
    // bad
    _staticVariable = [NSObject alloc];
}


    
#pragma - mark Take care dead loop of property accessor

- (NSString *)dead_loop_bad {
    return self.dead_loop_bad;
}

- (void)setdead_loop_bad:(NSString *)dead_loop_bad {
    self.dead_loop_bad = dead_loop_bad;
}

- (NSString *)dead_loop_good {
    return _dead_loop_good;
}

- (void)setdead_loop_good:(NSString *)dead_loop_good {
    _dead_loop_good = dead_loop_good;
}


#pragma - mark Don't change value of instance variable

static NSString * staticVariable;

- (void)handleStaticVariable_bad {
    staticVariable = @"Hello world";
}

- (void)handleStaticVariable_good {
    static NSString * tmpStaticString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticVariable = @"Hello world";
    });
}

#pragma - mark Don't miss overwrite hash method

- (BOOL)isEqual:(id)object {
    return [object isKindOfClass:BTViewController.class] && [self.dead_loop_bad isEqualToString:[(BTViewController *)object dead_loop_bad]];
}

- (NSUInteger)hash {
    return self.dead_loop_bad.hash ^ self.dead_loop_good.hash;
}

#pragma -mark Don't remove all the observers

- (void)handleRemoveObserver {
    // Bad
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Good
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma -mark Don't invoke "self.view" in dealloc mthod

- (void)viewDidLoad {
    [super viewDidLoad];
    // good
    [self.view setFrame:CGRectZero];
    // good
    UIWindow *window = nil;
    window = [[UIApplication sharedApplication] keyWindow];
    // bad
    window = self.view.window;
}

- (void)dealloc {
    // bad
    [self.view setFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // bad
    [self.view setFrame:CGRectZero];
    //如果当VC已经被创建，但是view还没有加入到view层级中时(比如Tabbar初始化之后的非选中VC)，此时接收到了内存警告，那么self.view会被直接创建，没有加入到层级，导致其子view可能处于异常的状态
}

@end
