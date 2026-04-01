# Project Rules

## 목적

이 문서는 현재 UYOUNG 프로젝트의 실제 구조를 기준으로, 기능 추가와 유지보수를 더 일관되게 진행하기 위한 작업 규칙을 정리합니다.

핵심 원칙은 다음과 같습니다.

- 현재 구조를 유지하면서 점진적으로 정리한다.
- 더미 데이터보다 실데이터 연동을 우선한다.
- 화면, 상태관리, 데이터 접근 책임을 분리한다.
- 한 번에 크게 바꾸기보다 작은 단위로 안정적으로 개선한다.

## 현재 표준 구조

현재 프로젝트의 기본 구조는 아래를 기준으로 사용합니다.

```text
lib/
├── app.dart
├── main.dart
├── data/
│   ├── model/
│   ├── repositories/
│   └── sources/
├── src/
│   ├── view/
│   │   ├── common/
│   │   └── pages/
│   └── viewModel/
```

### 폴더 역할

- `lib/data/model`
  - 화면/도메인에서 사용하는 데이터 모델 정의
- `lib/data/repositories`
  - ViewModel과 data source 사이의 중간 계층
- `lib/data/sources`
  - 로컬 더미 데이터, 저장소, 외부 데이터 접근
- `lib/data/sources/supabase`
  - Supabase 연동 전용 코드
- `lib/src/view/pages`
  - 실제 화면 단위 위젯
- `lib/src/view/common`
  - 여러 화면에서 재사용하는 공통 위젯
- `lib/src/viewModel`
  - `ChangeNotifier` 기반 상태관리

## 상태관리 규칙

- 기본 상태관리는 `provider + ChangeNotifier`를 사용합니다.
- View는 ViewModel을 구독하고, 직접 Supabase를 호출하지 않습니다.
- ViewModel은 repository를 호출합니다.
- Repository는 source/service를 호출합니다.
- Supabase RPC 또는 테이블 접근은 `data/sources/supabase/...` 내부로 한정합니다.

## 데이터 연동 규칙

### Supabase 우선

- 새 기능 연결 시, 가능하면 더미 데이터 대신 Supabase 실데이터를 우선 사용합니다.
- 기존 이미지/하드코딩 화면이 있어도, UI 구조를 유지하면서 데이터만 실제 연동으로 교체하는 방식을 우선합니다.

### RPC 사용 규칙

- RPC 호출은 View 또는 ViewModel에서 직접 하지 않습니다.
- 반드시 service/source 계층에서 감싸고 repository를 통해 노출합니다.
- RPC 응답 구조가 애매할 때는 별도 모델을 만들어 해석합니다.

### 사용자별 데이터

- 현재 로그인 사용자 기준 데이터는 기존 Supabase 패턴을 따릅니다.
- current user 확인은 service/source 레벨에서 처리하고, UI 쪽에 인증 로직을 흩뿌리지 않습니다.

## UI 작업 규칙

- 기존 프로젝트의 화면 스타일과 흐름을 최대한 유지합니다.
- 실기능 연결이 목적일 때는 전체 화면을 새로 다시 만들기보다, 기존 레이아웃을 살리고 동작만 연결합니다.
- 공통으로 2회 이상 재사용되는 위젯만 `common`으로 이동합니다.
- 한 화면에서만 쓰이는 조각 UI는 해당 page 근처에 유지합니다.

### 반응형 규칙

- 새로 만드는 화면이나 수정하는 화면은 일반적인 모바일 해상도에서 깨지지 않아야 합니다.
- 텍스트가 들어가는 카드, 반복 리스트, 버튼 영역은 고정 폭/고정 높이만으로 설계하지 않습니다.
- `Expanded`, `Flexible`, `LayoutBuilder`, `MediaQuery`, `FittedBox` 같은 Flutter 기본 반응형 도구를 우선 사용합니다.
- `Positioned`를 사용할 때는 반드시 작은 화면에서 오버플로우가 나지 않는지 함께 점검합니다.
- 이미지 중심 화면이라도 텍스트/버튼 레이어는 화면 크기에 따라 자연스럽게 줄어들거나 재배치되도록 작성합니다.
- 레이아웃 수정 시에는 먼저 국소적인 반응형 보완을 시도하고, 전체 UI 재구성은 필요할 때만 진행합니다.

## 네이밍 규칙

- 파일명은 `snake_case.dart`
- 클래스명은 `PascalCase`
- ViewModel은 `...ViewModel`
- Repository는 `...Repository`
- Service/Source는 역할이 드러나는 이름 사용

예:

- `profile_view_model.dart`
- `notification_repository.dart`
- `attendance_service.dart`

## 구현 시 피해야 할 것

- 요청 없이 전체 구조를 `feature-first`로 갈아엎지 않기
- 요청 없이 대규모 파일 이동/이름 변경하지 않기
- 이미 연결된 실제 화면이 있는데 fake/image-only 화면을 다시 연결하지 않기
- UI에서 직접 Supabase 호출하지 않기
- 관련 없는 더미 데이터 파일을 무분별하게 늘리지 않기

## 더미 데이터와 레거시 처리 원칙

현재 프로젝트에는 일부 더미 데이터와 실데이터가 함께 존재합니다.

원칙:

- 새로운 기능은 실데이터 우선
- 기존 더미 경로를 건드릴 때는, 바로 없애기 어려우면 TODO를 남겨 명확히 표시
- 레거시 코드는 갑자기 대규모 정리하지 말고, 실제 이슈를 해결하는 범위 안에서만 손봅니다

예:

- member inquiry는 실데이터로 연결
- memory preview는 아직 더미/legacy 구조가 남아 있다면 TODO를 남기고 후속 정리 대상으로 둠

## 브랜치/PR 규칙

- `develop`에서 직접 작업하지 않습니다.
- 작업 하나당 새 브랜치를 만듭니다.
- 이미 머지 이력이 복잡한 오래된 브랜치는 재사용하지 않습니다.
- PR은 한 가지 목적만 담도록 유지합니다.

예:

- `feat/home-connect`
- `feat/mypage-connect`
- `docs/project-rules`

## 커밋 규칙

- 커밋은 기능 단위로 나눕니다.
- 데이터 계층 추가, 상태관리 연결, UI 연결을 분리할 수 있으면 분리합니다.
- 단, 파일이 강하게 얽혀 있으면 과도한 분리보다 의미 있는 단위로 묶습니다.

좋은 예:

- `feat: 사용자 검색 모델 및 Supabase 검색 구조 추가`
- `feat: 멤버 검색 결과 리스트와 선택 chip UI 구현`
- `fix: 프로필 저장 로직을 insert/update 분기 방식으로 수정`

## 검증 규칙

코드 변경 후 기본적으로 아래를 우선합니다.

```bash
flutter analyze
```

가능하면 변경 파일 기준으로 먼저 확인하고, 필요 시 범위를 넓힙니다.

## 현재 프로젝트에서 특히 조심할 점

### 1. provider scope

- provider를 생성한 직후, 바깥 `BuildContext`에서 바로 읽지 않도록 주의합니다.
- 이런 경우 `builder:` 또는 하위 위젯으로 분리해서 provider 아래 context를 사용합니다.

### 2. 화면 연결 중복

- 동일 기능에 대한 임시 화면과 실제 화면이 동시에 존재할 수 있습니다.
- 새 연결 작업 시, 어떤 화면이 현재 실제 연결 대상인지 먼저 확인합니다.

### 3. Supabase RLS / 관계 조회

- Supabase 관계 select가 항상 안정적으로 동작하지 않을 수 있습니다.
- 관계 조회가 실패하면 2단계 조회 방식으로 우회하는 것이 허용됩니다.

### 4. 이미지 중심 화면

- 일부 화면은 스크린샷 기반으로 빠르게 구현된 흔적이 있습니다.
- 이런 화면은 기능 연결 시 레이아웃을 크게 바꾸기보다, 실제 데이터 흐름만 붙이는 방향을 우선합니다.
- 다만 이미지 기반 화면이라도 작은 기기에서 오버플로우가 나면 반드시 반응형 보완을 먼저 수행합니다.

## 후속 정리 우선순위 제안

나중에 구조를 더 깔끔하게 만들고 싶다면 우선순위는 아래 순서를 권장합니다.

1. 더미 데이터와 Supabase 실데이터 경계 명확화
2. page/common/widget 네이밍 혼용 정리
3. 오타/레거시 파일명 정리
4. 출석/홈/기억섬 등 화면군별 공통 컴포넌트 추출

지금 단계에서는 위 항목들을 한 번에 진행하기보다, 기능 작업 중 자연스럽게 점진 정리하는 방식을 권장합니다.
