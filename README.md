# UYOUNG

UYOUNG는 소중한 사람들과 기억을 함께 기록하고, 초대 링크를 통해 기억섬에 참여하며, 일상 속 추억을 쌓아가는 Flutter 기반 모바일 앱입니다.

## 주요 기능

- 홈: 캐릭터 메인 화면, 출석 체크, 알림 화면
- 기억섬: 기억 목록 조회, 상세 화면, 멤버 초대 링크 진입
- 캘린더: 날짜 기반 기록 탐색
- 마이페이지: 메인 화면, 진주 충전소, 친구 목록, 친구 프로필, 친구 초대
- 로그인: `Supabase OAuth` 기반 소셜 로그인

## 기술 스택

- `Flutter`
- `Dart`
- `Provider`
- `Supabase`
- `app_links`
- `google_maps_flutter`

## 프로젝트 구조

```text
lib/
├── app.dart
├── data/
│   ├── model/
│   ├── repositories/
│   └── sources/
├── src/
│   └── view/
│       ├── common/
│       └── pages/
└── viewModel/
```

- [main.dart](/Users/choseoungeun/dev/UYOUNG/lib/main.dart)
  앱 시작점, Supabase 초기화, 딥링크 수신, 인증 게이트 처리
- [app.dart](/Users/choseoungeun/dev/UYOUNG/lib/app.dart)
  하단 탭 기반 메인 앱 진입
- [auth_view_model.dart](/Users/choseoungeun/dev/UYOUNG/lib/src/viewModel/auth/auth_view_model.dart)
  로그인/로그아웃 인증 로직
- [supabase_config.dart](/Users/choseoungeun/dev/UYOUNG/lib/data/sources/supabase/supabase_config.dart)
  Supabase URL, 키, 초대 링크 베이스 URL 관리

## 실행 방법

### 1. 패키지 설치

```bash
flutter pub get
```

### 2. 앱 실행

```bash
flutter run
```

### 3. 환경값 주입이 필요한 경우

현재 프로젝트는 `String.fromEnvironment`를 통해 Supabase 설정을 받을 수 있습니다.

```bash
flutter run \
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY \
  --dart-define=MEMORY_INVITE_BASE_URL=https://momenture.app/invite
```

설정을 따로 주지 않으면 [supabase_config.dart](/Users/choseoungeun/dev/UYOUNG/lib/data/sources/supabase/supabase_config.dart)의 기본값을 사용합니다.

## 로그인 및 딥링크 관련 파일

- [login_main_page.dart](/Users/choseoungeun/dev/UYOUNG/lib/src/view/pages/login/login_main_page.dart)
  소셜 로그인 버튼 UI
- [auth_view_model.dart](/Users/choseoungeun/dev/UYOUNG/lib/src/viewModel/auth/auth_view_model.dart)
  Supabase OAuth 로그인/로그아웃 처리
- [AndroidManifest.xml](/Users/choseoungeun/dev/UYOUNG/android/app/src/main/AndroidManifest.xml)
  Android 딥링크 스킴 및 앱 링크 설정
- [Info.plist](/Users/choseoungeun/dev/UYOUNG/ios/Runner/Info.plist)
  iOS URL scheme 설정
- [Runner.entitlements](/Users/choseoungeun/dev/UYOUNG/ios/Runner/Runner.entitlements)
  iOS universal link 설정

## 에셋 및 폰트

- 이미지 에셋: `assets/images/`
- 마이페이지 전용 에셋: `assets/images/mypage/`
- 커스텀 폰트:
  - `memomentKkukkkuk`
  - `PretendardStatic`
  - `PretendardVariable`

## 개발 메모

- 하단 네비게이션 기반으로 주요 화면을 전환합니다.
- 인증 상태는 `AuthGate`에서 세션 기준으로 분기합니다.
- 초대 링크 진입과 로그인 콜백은 `app_links`로 수신합니다.
- 상태 관리는 `Provider` 기반으로 구성되어 있습니다.
