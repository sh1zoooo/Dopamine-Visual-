# Dopamine Visual (Fake Edition)

⚠️ **Это НЕ настоящий джейлбрейк.** Это шуточный клон интерфейса Dopamine
для розыгрыша. Приложение только рисует UI (кнопки, анимации, фейковые
логи вида "Bypassing PPL...", "Bypassing SPTM..." и т.п.) и не выполняет
никаких реальных действий с системой, не эксплуатирует уязвимости и не
изменяет iOS.

## Сборка

Проект собирается через [XcodeGen](https://github.com/yonaskolb/XcodeGen)
и GitHub Actions (`.github/workflows/build.yml`) на macOS-раннере:

```
xcodegen generate
xcodebuild -project Dopamine.xcodeproj -scheme Dopamine -sdk iphoneos ...
```

Готовый `.ipa` появится в артефактах запуска Action.

## Что было убрано из оригинального Dopamine

Из исходников полностью удалены:
- `BaseBin` (весь бинарный компонент джейлбрейка);
- `Exploits/*`, `Jailbreak/DOJailbreaker*`, `DOExploit*`, `DOBootstrapper*`,
  `DOEnvironmentManager` — всё, что реально патчит/эксплуатирует систему;
- `libgrabkernel2.a`, `libpartial.a` и любые бинарные зависимости эксплойтов;
- приватные entitlements (no-sandbox, TCC allow, mobileinstall SPI и т.д.).

Оставлен только UI-слой, дополненный фейковым классом
`Jailbreak/DOFakeEnvironment`, который просто анимирует "прогресс" через
таймеры — реального выполнения кода/патчинга не происходит.
