//
//   ___           ___        ___      ___        ___
//  /\  \         /\  \      /\  \    /\  \      /\  \
//  \ \  \        \ \  \_____\ \  \   \ \  \_____\ \  \
//   \ \  \        \ \  \_____\ \  \   \ \  \_____\ \  \
//    \ \  \______  \ \  \     \ \  \   \ \  \     \ \  \
//     \ \________\  \ \__\     \ \__\   \ \__\     \ \__\
//      \/________/   \/__/      \/__/    \/__/      \/__/
//
//  欢欢为人民服务
//  有问题请联系我，http://www.jianshu.com/u/3c6ff28fdc63
//
// -----------------------------------------------------------------------------


#import "NSObject+BKBlockExecution.h"

#define BKTimeDelay(t) dispatch_time(DISPATCH_TIME_NOW, (uint64_t)(NSEC_PER_SEC * t))

@implementation NSObject (BlocksKit)

- (id)bk_performBlock:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay
{
	return [self bk_performBlock:block onQueue:dispatch_get_main_queue() afterDelay:delay];
}

+ (id)bk_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	return [NSObject bk_performBlock:block onQueue:dispatch_get_main_queue() afterDelay:delay];
}

- (id)bk_performBlockInBackground:(void (^)(id obj))block afterDelay:(NSTimeInterval)delay
{
	return [self bk_performBlock:block onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) afterDelay:delay];
}

+ (id)bk_performBlockInBackground:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	return [NSObject bk_performBlock:block onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) afterDelay:delay];
}

- (id)bk_performBlock:(void (^)(id obj))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay
{
	NSParameterAssert(block != nil);
	
	__block BOOL cancelled = NO;
	
	void (^wrapper)(BOOL) = ^(BOOL cancel) {
		if (cancel) {
			cancelled = YES;
			return;
		}
		if (!cancelled) block(self);
	};
	
	dispatch_after(BKTimeDelay(delay), queue, ^{
		wrapper(NO);
	});
	
	return [wrapper copy];
}

+ (id)bk_performBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay
{
	NSParameterAssert(block != nil);
	
	__block BOOL cancelled = NO;
	
	void (^wrapper)(BOOL) = ^(BOOL cancel) {
		if (cancel) {
			cancelled = YES;
			return;
		}
		if (!cancelled) block();
	};
	
	dispatch_after(BKTimeDelay(delay), queue, ^{ wrapper(NO); });
	
	return [wrapper copy];
}

+ (void)bk_cancelBlock:(id)block
{
	NSParameterAssert(block != nil);
	void (^wrapper)(BOOL) = block;
	wrapper(YES);
}

@end
