//
//  main.mm
//  FastEnumerationVector
//
//  Created by Jinwoo Kim on 5/11/23.
//

#import <Foundation/Foundation.h>
#import <array>
#import <algorithm>
#import "FastEnmuerationVector.hpp"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FastEnmuerationVector *vector = [FastEnmuerationVector new];
        
        std::array<NSUInteger, 100> range;
        
        std::for_each(range.begin(), range.end(), [&range, &vector](NSUInteger &element) {
            NSUInteger index = &element - range.data();
            vector.objects.get()->push_back(@(index));
        });
        
        for (id object in vector) {
            NSLog(@"%@", object);
        }
    }
    
    return 0;
}
