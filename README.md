# Navigation App (Diploma Project)

Приложение социальной сети VK для iOS, разработанное в рамках дипломного проекта.
Позволяет пользователям просматривать ленту, ставить лайки и авторизовываться.

## Функциональность
- 🔑 Авторизация через Firebase (Email/Password).
- 🐱 Загрузка ленты изображений и описания dummyjson
- ❤️ Добавление постов в избранное (CoreData).
- 🏗 Архитектура MVVM.
- 📱 Адаптивная верстка (iPhone/iPad).

## Технологии
- Swift 5
- UIKit (Code-only, Auto Layout, SnapKit)
- Firebase Auth
- CoreData
- URLSession

## Установка
1. Клонировать репозиторий.
2. Установить зависимости (если используешь SPM, они подтянутся сами).
3. Добавить свой `GoogleService-Info.plist` (так как он в .gitignore).
4. Запустить проект в Xcode.

## Скриншоты

### iPhone
| Вход | Аккаунт | Подобор слова | Избранное | Карта |
| --- | --- | --- | --- | --- |
| ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/ProfileLogin.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/profile.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/Game.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/Faorites.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/map.png?raw=true) |

### iPad
| Вход | Аккаунт | Подобор слова | Избранное | Карта |
| --- | --- | --- | --- | --- |
| ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/ipadprofileLogin.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/ipadProfile.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/ipadGame.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/ipadFavorites.png?raw=true) | ![image](https://github.com/kubmakk/ios-homeworks/blob/fios_1/Screens/ipadMap.png?raw=true) |
