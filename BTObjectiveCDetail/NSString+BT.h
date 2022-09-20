//
//  NSString+BT.h
//  BTObjectiveCDetail
//
//  Created by blacktea on 20/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BT)

#pragma -mark  Add  Prefix to category method name

- (NSString*)badCategoryMethodName;

- (NSString*)bt_goodCategoryMethodName;

@end

@interface NSString (BT2)

@end

NS_ASSUME_NONNULL_END
