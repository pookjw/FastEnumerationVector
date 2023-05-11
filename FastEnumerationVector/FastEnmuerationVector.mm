//
//  FastEnmuerationVector.m
//  FastEnumerationVector
//
//  Created by Jinwoo Kim on 5/11/23.
//

#import "FastEnmuerationVector.hpp"
#import <memory>

@implementation FastEnmuerationVector {
    std::shared_ptr<std::vector<id>> _objects;
    std::shared_ptr<unsigned long> normal;
    std::shared_ptr<unsigned long> mutated;
}

- (instancetype)init {
    if (self = [super init]) {
        _objects = std::shared_ptr<std::vector<id>>(new std::vector<id>());
        normal = std::shared_ptr<unsigned long>(new unsigned long (0));
        mutated = std::shared_ptr<unsigned long>(new unsigned long (1));
    }
    
    return self;
}

- (std::vector<id> *)objects {
    return _objects.get();
}

- (NSUInteger)countByEnumeratingWithState:(nonnull NSFastEnumerationState *)state objects:(__unsafe_unretained id  _Nullable * _Nonnull)buffer count:(NSUInteger)len {
    const std::vector<id> *objects = _objects.get();
    const unsigned long size = objects->size();
    
    if (state->state == 0) {
        // initial
        state->state = 1;
        state->itemsPtr = buffer;
        state->extra[0] = size; // remaining
        state->extra[1] = size; // initial size
        state->mutationsPtr = normal.get();
    }
    
    if (state->extra[1] != size) {
        // mutated - throw exception
        for (NSUInteger i = 0; i < len; i++) {
            buffer[i] = nullptr;
        }
        
        state->mutationsPtr = mutated.get();
        return NSNotFound;
    }
    
    const unsigned long remaining = state->extra[0];
    
    for (NSUInteger i = 0; i < len; i++) {
        if (remaining <= i) {
            buffer[i] = nullptr;
        } else {
            buffer[i] = objects->at(size - remaining + i);
        }
    }
    
    if (len <= remaining) {
        state->extra[0] -= len;
        return len;
    } else {
        // final
        state->extra[0] = 0;
        return remaining;
    }
}

@end
