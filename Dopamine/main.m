//
//  main.m
//  Dopamine (Visual Fake Edition)
//
//  Внимание: это ШУТОЧНАЯ версия интерфейса. Никакого реального джейлбрейка
//  или обхода защит iOS здесь нет — приложение ничего не делает с системой.
//

#import <UIKit/UIKit.h>
#import "DOAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([DOAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
