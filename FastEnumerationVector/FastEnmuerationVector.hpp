//
//  FastEnmuerationVector.h
//  FastEnumerationVector
//
//  Created by Jinwoo Kim on 5/11/23.
//

#import <Foundation/Foundation.h>
#import <memory>
#import <vector>

NS_ASSUME_NONNULL_BEGIN

@interface FastEnmuerationVector : NSObject <NSFastEnumeration>
@property (readonly, assign) std::shared_ptr<std::vector<id>> objects;
@end

NS_ASSUME_NONNULL_END
