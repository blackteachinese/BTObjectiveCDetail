//
//  BTHandler.m
//  BTObjectiveCDetail
//
//  Created by blacktea on 20/9/22.
//

#import "BTHandler.h"
@interface BTHandler1 ()

@property (nonatomic, copy) NSString *string;

@end

@implementation BTHandler1

+ (instancetype)sharedInstance {
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

#pragma -mark Pay attention to singleton deadlock

- (instancetype)init {
    if (self = [super init]) {
        [BTHandler2 sharedInstance];
    }
    return self;
}

#pragma  -mark Don't visit property in dealloc

- (void)dealloc {
    // bad
    self.string = nil;
    // good
    _string = nil;
    
}

@end

@implementation BTHandler2

+ (instancetype)sharedInstance {
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [BTHandler1 sharedInstance];
    }
    return self;
}

#pragma -mark Don't pass self in dealloc

- (void)dealloc {
    // bad
    [self damageMethod:self];
}

- (void)damageMethod:(BTHandler2 *)handler {
    
}

@end
