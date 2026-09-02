//
//  DOFakeEnvironment.h
//  Dopamine (Visual Fake Edition)
//
//  Полностью фейковый класс "состояния джейлбрейка". Не взаимодействует
//  с системой, ядром, файловой системой или чем-либо ещё — только
//  хранит булево значение и присылает уведомления для анимации UI.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSNotificationName const DOFakeJailbreakStateChangedNotification;

@interface DOFakeEnvironment : NSObject

+ (instancetype)sharedManager;

// Фейковый статус — просто in-memory флаг на время жизни процесса.
@property (nonatomic, readonly) BOOL isJailbroken;

// Строка вида "18.0b2 - 18.7.1 (PPL, SPTM)" для отображения в UI.
@property (nonatomic, copy, readonly) NSString *fakeSupportedVersionString;

// Запускает "фейковый джейлбрейк": имитация прогресса через таймеры/делеи,
// колбэк на каждом псевдо-этапе, в конце помечает isJailbroken = YES.
// Никакого реального кода выполнения/патчинга/эксплуатации не производится.
- (void)startFakeJailbreakWithStepHandler:(void (^)(NSString *stepDescription, float progress))stepHandler
                                completion:(void (^)(BOOL success))completion;

- (void)resetFakeState;

@end

NS_ASSUME_NONNULL_END
