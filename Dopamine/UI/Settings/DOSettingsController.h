//
//  DOSettingsController.h
//  Dopamine (Visual Fake Edition)
//
//  Упрощённая ШУТОЧНАЯ версия экрана настроек. Никаких эксплойтов,
//  PAC/PPL bypass-пикеров или системных операций тут больше нет —
//  только косметические переключатели и выбор темы.
//

#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import "DOPSListController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DOSettingsController : DOPSListController
{
    NSString *_lastKnownTheme;
}

@end

NS_ASSUME_NONNULL_END
