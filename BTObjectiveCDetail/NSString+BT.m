//
//  NSString+BT.m
//  BTObjectiveCDetail
//
//  Created by blacktea on 20/9/22.
//

#import "NSString+BT.h"

@implementation NSString (BT)

#pragma -mark Prohibit overwrite category method

- (NSString *)substringFromIndex:(NSUInteger)from {
    return @"";
}

- (NSString*)conflictCategoryMethod {
    return @"";
}

@end

@implementation NSString (BT2)

- (NSString*)conflictCategoryMethod {
    return @"";
}

@end
