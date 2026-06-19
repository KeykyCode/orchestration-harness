---
name: flutter-app
description: Flutter 앱(모바일/웹)을 새로 만들거나 화면·기능을 추가할 때 사용. 폴더구조(config/models/data/services/state/widgets/pages)·Riverpod 레이어·명명·디자인 토큰(theme.dart)·셋업 컨벤션을 적용한다. 백엔드는 횡단 모듈(supabase-auth / api-client)에 위임한다. iOS·Android·웹 빌드.
---

# Flutter App Conventions

> 적용 전 함께 읽을 모듈: `supabase-auth`(인증·RLS 원칙), `api-client`(자체 백엔드면 HTTP 호출 원칙).
> **디자인은 이 모듈이 자체 내장**한다(웹의 `design-system`/shadcn은 Flutter에 안 씀). 아래 "디자인 토큰" 참조.

## 셋업

```bash
flutter create <name> && cd <name>
flutter pub add flutter_riverpod shared_preferences http
# 백엔드별: Supabase → supabase_flutter / 자체 REST → (http 만으로 충분)
flutter pub add supabase_flutter        # Supabase 쓸 때만
```

- `lib/config/env.dart`는 **gitignore** + `env.example.dart` 커밋(키는 사본에만). 앱 시작 시 `Supabase.initialize`/baseUrl 주입.
- 앱 루트를 `ProviderScope`로 감싼다(Riverpod).
- 톤은 `lib/theme.dart`에 토큰으로 정의(아래).

> ⚠️ **버전 핀 함정**: 플러그인이 `flutter.compileSdkVersion` 등 신 API를 요구해 구 Flutter에서 Gradle/컴파일 실패할 수 있다. transitive 의존(예: `app_links`)은 호환 버전으로 **핀**하고, 이유를 `pubspec.yaml` 주석에 남겨라. (Flame 등 Color API 변경에 민감한 패키지도 동일.)

## 폴더 구조

```
lib/
├── config/      # env.dart(gitignored) + env.example.dart, flags.dart — 설정만
├── models/      # 도메인 모델 (순수 데이터 클래스, fromJson/toJson)
├── data/        # 데이터 계층 — Supabase 조회 / HTTP 호출. 순수(상태변경 X)
├── services/    # 순수 로직 (점수·코덱·오디오 등 — UI·상태 의존 X)
├── state/       # Riverpod 컨트롤러/프로바이더 — 전역 상태만
├── widgets/     # 공용 재사용 위젯
├── pages/       # 화면 (state 구독 / data 호출)
└── theme.dart   # 디자인 토큰 (AppColors / AppRadius / AppSpacing)
```

## 레이어 규칙 (단방향)

```
models → data(순수 API) → state(Riverpod) → pages/widgets
services = 순수 로직 (어느 레이어서나 호출, 부수효과 X)
```

- **data 계층은 순수**: Supabase/HTTP 조회만 하고 **상태를 바꾸지 않는다**. 전역 클라이언트는 단축 접근자로(`SupabaseClient get supabase => Supabase.instance.client`).
- **전역 상태만 `state/`(Riverpod)**. 화면 전용 일시 상태는 `StatefulWidget`/`setState`로 화면 안에 둔다 — Riverpod에 올리지 마라.
- **인증 판단은 서버/RLS 기준**(`supabase-auth`). 클라 불린으로 권한 결정 금지.
- UI에서 색·radius·spacing **하드코딩 금지** — `theme.dart` 토큰 사용(아래).

## 상태관리 (Riverpod)

- 불변 State 클래스 + `copyWith` 패턴. `Notifier`/`StateNotifier`로 노출, 프로바이더로 주입.
- 화면은 `ConsumerWidget`/`ConsumerStatefulWidget`에서 `ref.watch`(구독)/`ref.read`(액션)로 접근.
- data 함수를 컨트롤러가 호출해 State를 갱신 — **위젯이 data를 직접 호출하지 않는다**(읽기 전용 일회성 제외).

## 디자인 토큰 (theme.dart 자체 내장)

웹 `design-system`을 쓰지 않는다. 대신 `lib/theme.dart`에 시맨틱 토큰을 둔다:

- **`AppColors`** — grey ramp(중립 00→950) → 시맨틱 alias(`bg`/`surface`/`surfaceHi`/`border`/`textMuted`/기능색). 화면에선 raw grey보다 **시맨틱 토큰 우선**.
- **`AppRadius`** / **`AppSpacing`** — radius·간격 상수. 매직넘버 금지.
- 톤 변경은 `theme.dart`만 고치면 전체 반영. 새 색이 필요하면 ramp→시맨틱 순으로 추가.

## 명명 규칙

| 대상 | 규칙 | 예 |
|---|---|---|
| 위젯/페이지 클래스 | PascalCase | `GamePlayPage`, `TypewriterText` |
| 파일 | snake_case | `game_play_page.dart`, `auth_controller.dart` |
| 컨트롤러 | `xxx_controller.dart` | `auth_controller.dart` |
| data API | `xxx_api.dart` / `xxx_repository.dart` | `leaderboard_api.dart` |
| 프로바이더 | `xxxProvider` | `authControllerProvider` |

## 새 기능 추가 순서

`models/` → `data/`(순수 호출) → `state/`(컨트롤러) → `pages/`·`widgets/`

## 태스크 태그 (workflow와 연동)

`[Model]` `[Data]` `[Service]` `[State]` `[Page]` `[Widget]`
- `[Data]` = data 계층 순수 호출, `[State]` = Riverpod 컨트롤러, `[Service]` = 순수 로직.

## 검증

`flutter analyze` · `flutter test` · `flutter build web --no-tree-shake-icons`(또는 타깃 플랫폼 빌드). 린트 자동수정 `dart fix --apply <file>`.
