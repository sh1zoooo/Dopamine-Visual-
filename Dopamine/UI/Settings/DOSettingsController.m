//
//  DOSettingsController.m
//  Dopamine (Visual Fake Edition)
//
//  Упрощённая ШУТОЧНАЯ версия экрана настроек: выбор темы (косметика)
//  + пара переключателей, которые просто сохраняются в UserDefaults
//  и ни на что в системе не влияют.
//

#import "DOSettingsController.h"
#import "DOUIManager.h"
#import "DOHeaderCell.h"
#import "DOThemeManager.h"
#import "DOSceneDelegate.h"
#import "DOFakeEnvironment.h"

@implementation DOSettingsController

- (void)viewDidLoad
{
    _lastKnownTheme = [[DOThemeManager sharedInstance] enabledTheme].key;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_lastKnownTheme != [[DOThemeManager sharedInstance] enabledTheme].key)
    {
        [DOSceneDelegate relaunch];
        NSString *icon = [[DOThemeManager sharedInstance] enabledTheme].icon;
        [[UIApplication sharedApplication] setAlternateIconName:icon completionHandler:^(NSError * _Nullable error) {
            if (error)
                NSLog(@"Error changing app icon: %@", error);
        }];
    }
}

- (NSArray *)themeIdentifiers
{
    return [[DOThemeManager sharedInstance] getAvailableThemeKeys];
}

- (NSArray *)themeNames
{
    return [[DOThemeManager sharedInstance] getAvailableThemeNames];
}

- (id)specifiers
{
    if (_specifiers == nil) {
        NSMutableArray *specifiers = [NSMutableArray new];

        PSSpecifier *headerSpecifier = [PSSpecifier emptyGroupSpecifier];
        [headerSpecifier setProperty:@"DOHeaderCell" forKey:@"headerCellClass"];
        [headerSpecifier setProperty:@"Settings" forKey:@"title"];
        [specifiers addObject:headerSpecifier];

        // Косметический статус (фейк, ничего не проверяет по-настоящему)
        PSSpecifier *statusGroup = [PSSpecifier emptyGroupSpecifier];
        statusGroup.name = DOLocalizedString(@"Status");
        [specifiers addObject:statusGroup];

        PSSpecifier *statusSpecifier = [PSSpecifier preferenceSpecifierNamed:DOLocalizedString(@"Status_Title_Jailbroken")
                                                                        target:self
                                                                           set:nil
                                                                           get:@selector(fakeStatusValue)
                                                                        detail:nil
                                                                          cell:PSStaticTextCell
                                                                          edit:nil];
        [specifiers addObject:statusSpecifier];

        // Тема — реально косметическая функция, оставляем как есть
        PSSpecifier *themeGroupSpecifier = [PSSpecifier emptyGroupSpecifier];
        themeGroupSpecifier.name = DOLocalizedString(@"Section_Appearance") ?: @"Appearance";
        [specifiers addObject:themeGroupSpecifier];

        PSSpecifier *themeSpecifier = [PSSpecifier preferenceSpecifierNamed:DOLocalizedString(@"Theme") ?: @"Theme"
                                                                        target:self
                                                                           set:@selector(setPreferenceValue:specifier:)
                                                                           get:@selector(readPreferenceValue:)
                                                                        detail:nil
                                                                          cell:PSLinkListCell
                                                                          edit:nil];
        [themeSpecifier setProperty:@YES forKey:@"enabled"];
        [themeSpecifier setProperty:[[DOThemeManager sharedInstance] enabledTheme].key forKey:@"default"];
        [themeSpecifier setProperty:@"themeIdentifiers" forKey:@"valuesDataSource"];
        [themeSpecifier setProperty:@"themeNames" forKey:@"titlesDataSource"];
        [themeSpecifier setProperty:@"enabledTheme" forKey:@"key"];
        [specifiers addObject:themeSpecifier];

        // Пара чисто косметических переключателей (шутки ради) — они просто
        // сохраняются в NSUserDefaults и не запускают вообще никакого кода.
        PSSpecifier *fakeGroupSpecifier = [PSSpecifier emptyGroupSpecifier];
        fakeGroupSpecifier.name = DOLocalizedString(@"Section_Extras") ?: @"Extras";
        [specifiers addObject:fakeGroupSpecifier];

        PSSpecifier *verboseLogsSpecifier = [PSSpecifier preferenceSpecifierNamed:DOLocalizedString(@"Verbose_Logs") ?: @"Verbose Logs"
                                                                             target:self
                                                                                set:@selector(setPreferenceValue:specifier:)
                                                                                get:@selector(readPreferenceValue:)
                                                                             detail:nil
                                                                               cell:PSSwitchCell
                                                                               edit:nil];
        [verboseLogsSpecifier setProperty:@"verboseLogsEnabled" forKey:@"key"];
        [verboseLogsSpecifier setProperty:@NO forKey:@"default"];
        [specifiers addObject:verboseLogsSpecifier];

        _specifiers = specifiers;
    }
    return _specifiers;
}

- (NSString *)fakeStatusValue
{
    return [[DOFakeEnvironment sharedManager] isJailbroken] ? DOLocalizedString(@"Status_Title_Jailbroken") : DOLocalizedString(@"Button_Jailbreak_Title");
}

@end
