//
//  FastEnmuerationVector.m
//  FastEnumerationVector
//
//  Created by Jinwoo Kim on 5/11/23.
//

#import "FastEnmuerationVector.hpp"

@implementation FastEnmuerationVector

- (instancetype)init {
    if (self = [super init]) {
        _objects = std::shared_ptr<std::vector<id>>(new std::vector<id>());
    }
    
    return self;
}

- (NSUInteger)countByEnumeratingWithState:(nonnull NSFastEnumerationState *)state objects:(__unsafe_unretained id  _Nullable * _Nonnull)buffer count:(NSUInteger)len {
    const std::vector<id> *objects = _objects.get();
    const std::uint64_t size = objects->size();
    
    if (state->state == 0) {
        // initial
        state->state = 1;
        state->itemsPtr = buffer;
        state->extra[0] = size;
        state->mutationsPtr = reinterpret_cast<unsigned long *>(_objects.get());
    }
    
    const unsigned long remaining = state->extra[0];
    
    if (len <= remaining) {
        for (NSUInteger i = 0; i < len; i++) {
            buffer[i] = objects->at(size - remaining + i);
        }
        
        state->extra[0] -= len;
        return len;
    } else {
        // final
        state->extra[0] = 0;
        
        for (NSUInteger i = 0; i < remaining; i++) {
            buffer[i] = objects->at(size - remaining + i);
        }
        
        return remaining;
    }
}

@end
