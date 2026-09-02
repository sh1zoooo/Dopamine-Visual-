//
//  DOFakeEnvironment.m
//  Dopamine (Visual Fake Edition)
//

#import "DOFakeEnvironment.h"

NSNotificationName const DOFakeJailbreakStateChangedNotification = @"DOFakeJailbreakStateChangedNotification";

@interface DOFakeEnvironment ()
@property (nonatomic, assign) BOOL isJailbroken;
@end

@implementation DOFakeEnvironment

+ (instancetype)sharedManager
{
    static DOFakeEnvironment *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [DOFakeEnvironment new];
    });
    return shared;
}

- (NSString *)fakeSupportedVersionString
{
    return @"iOS 18.0b2 - 18.7.1 (PPL, SPTM)";
}

- (void)resetFakeState
{
    self.isJailbroken = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:DOFakeJailbreakStateChangedNotification object:self];
}

- (void)startFakeJailbreakWithStepHandler:(void (^)(NSString *stepDescription, float progress))stepHandler
                                completion:(void (^)(BOOL success))completion
{
    // Чисто визуальная имитация прогресса — просто последовательность
    // текстов + задержек. Ни один из этих "шагов" не соответствует
    // реальному действию, ничего не патчится и не эксплуатируется.
    NSArray<NSString *> *fakeSteps = @[
        @"Checking device compatibility...",
        @"Preparing environment...",
        @"Bypassing PPL (visual only)...",
        @"Bypassing SPTM (visual only)...",
        @"Installing bootstrap...",
        @"Finishing up...",
    ];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSUInteger i = 0; i < fakeSteps.count; i++) {
            [NSThread sleepForTimeInterval:0.8];
            float progress = (float)(i + 1) / (float)fakeSteps.count;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (stepHandler) stepHandler(fakeSteps[i], progress);
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isJailbroken = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:DOFakeJailbreakStateChangedNotification object:self];
            if (completion) completion(YES);
        });
    });
}

@end
