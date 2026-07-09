# skill-sets — 재사용 스킬 모듈

**판단 기준 + 컨벤션**을 자산화한 모듈 모음. boilerplate가 아니라 *"이 스택에선 이렇게 한다 / 언제 무엇을 쓴다"*를 담는다.
새 프로젝트는 **`setup` 스킬이 질문으로 필요한 모듈을 조합**해 깔아준다.

## 구조

```
skill-sets/
├── v1-skill-setup/          ★ 모듈+조합 자산 (이 README가 속한 루트)
│   ├── setup/               ★ 질문 기반 조합 셋업 (create-react-app CLI처럼)
│   │
│   ├── common/              항상 복사 (진짜 스택 중립)
│   │   └── workflow/        plan·design·develop·test·iterate·document-work 스킬 + agents 8(+pm-orchestrator·acceptance-tester) + .tasks 템플릿
│   │
│   ├── stacks/              언어·프레임 종속 — 질문으로 1~2개 선택
│   │   ├── flutter-app/         Flutter 앱 컨벤션 (Riverpod·자체 디자인토큰)
│   │   ├── py-fastapi/          Python FastAPI 백엔드 (routers·services·repos)
│   │   ├── ts-next/             Next App Router 컨벤션
│   │   └── ts-vite-react/       Vite+React SPA 컨벤션
│   │
│   └── crosscutting/        스택 중립 횡단 — 0~N개 얹음
│       ├── design-system/      DESIGN.md+tokens.md (웹 프론트 한정)
│       ├── supabase-auth/      서버사이드 인증·RLS 원칙
│       ├── tanstack-query/     서버상태(쿼리키·useQuery/Mutation)
│       └── api-client/         fetch 래퍼(인증·에러·401)
│
└── react-common-skills/     (레거시 보존)
```

## 새 프로젝트 시작 = `setup` 스킬

```
/setup
  → Q1. 앱 / 웹?
  → (앱)  Q2. Flutter  → Q3. 백엔드? (Supabase / Python / 없음)
  → (웹)  Q2. 풀스택 / 클라이언트만
            ├ 풀스택      → Q3. 백엔드?(Supabase / Python) → Q4. 프론트?(Next / Vite)
            └ 클라이언트만 → Q3. 프론트 스택?(Vite / Next)
  → Q5. 컬러 시드 (#7c6bff …)   ※ 웹 프론트일 때만
  → Q6. 경로/이름?
  → common + 선택 stacks/crosscutting 을 프로젝트 .claude/ 로 복사 + 컬러 적용 + 초기 셋업
```

**조합 예시 (common 항상 + ↓)**
| 제품 | stacks | crosscutting |
|---|---|---|
| SEO + Supabase (예: Proofly) | `ts-next` | `supabase-auth` (+ `tanstack-query`) |
| 로그인 뒤 SPA 툴 | `ts-vite-react` | `api-client` + `tanstack-query` + `design-system` |
| Flutter 앱 + Supabase | `flutter-app` | `supabase-auth` |
| Flutter 앱 + 자체 백엔드 | `flutter-app` + `py-fastapi` | `api-client` |

## 워크플로우 (프로젝트에 복사된 뒤)

```
/plan-features "기능"  → backlog
/design-ui "화면"      → .tasks/design/  (UI 스택=와이어프레임·위젯트리 / FastAPI=엔드포인트·스키마 계약)
/develop-task "[태그]" → 코드 (conventions 규칙대로)
/test "대상"           → 테스트 (웹 Vitest / Flutter flutter_test / FastAPI pytest)
/iterate               → 진척 분석 + 다음 액션
/document-work         → 완료 작업 요약을 로컬 Obsidian vault에 정리(개인 지식 허브·vault 없으면 skip)
```

> 워크플로우 5스킬은 **스택 중립** — 게이트·테스트 프레임워크·설계 산출물을 현 프로젝트 conventions에서 가져와 스택별로 분기한다(웹/Flutter/FastAPI).

에이전트(`developer`·`ui-designer` 등)는 자연어 요청 시 자동 위임.

**멀티파트 기능**(백+프론트+DB+검증이 한 턴에 얽힘)은 `pm-orchestrator` 에이전트가 지휘자로 붙는다 — 작업을 쪼개 역할 에이전트에 정밀 스펙으로 위임하고, **보고를 믿지 않고 conventions의 `## 검증` 게이트·런타임 E2E를 PM이 직접 재실행**한 뒤 `.tasks/in-progress.md`에 기록한다. 순차 조정이 기본, 대규모 독립 작업만 병렬 승격.

> **검증은 두 축, 구현자와 분리**(self-review 편향 차단): `code-reviewer`(기술 — 규칙·정확성·보안) + `acceptance-tester`(목표 — 가상 사용자가 목표 워크플로 end-to-end 충족 여부 워크스루). 코드는 멀쩡한데 *목표 미달*인 구멍(화면 전이 끊김·딥링크 부재 등)은 후자에서만 잡힌다. PM이 둘을 종합 → 수정 지시 → 재검증.

## 업데이트 루프 (살아있는 문서)

복사본이 3개라 **자동 동기화는 없다.** ①(이 레포)이 항상 원본. 별도 스크립트 없이 **Claude에게 말로 시켜** 흐름을 닫는다.

```
① 이 레포 ──(zip 재생성)──▶ ② 조직 스킬(웹 챗) ──setup──▶ ③ 프로젝트 .claude/ 사본
```

- **보강할 게 생기면** → Claude에게 *"○○ 스킬에 이거 추가해줘"* → **레포(①)를 고치고 커밋**. (프로젝트 사본 말고 원본을 고친다)
- **조직(웹 챗)에 반영** → Claude에게 *"조직 zip 다시 만들어줘"* → `dist/project-setup.zip` 재생성 → 조직 스킬에 **재업로드**.
- **Code에서 쓰기** → `~/.claude/skills/`(개인) 또는 프로젝트 `.claude/skills/`. **조직 웹 업로드는 Code에 자동 반영 안 됨** (웹 챗 전용).
- **기존 프로젝트 사본**은 옛 버전 그대로 — 갱신하려면 Claude에게 *"이 프로젝트 .claude를 최신 레포로 갱신해줘"*.

> 규율(래칫): "있으면 좋을 것 같아서"가 아니라 **실제로 터진 실패**가 있을 때만 규칙을 추가한다.

## 원칙

- **판단 기준 > 코드 덩어리.** 통짜 코드는 `api-client`·`supabase-auth`의 보일러플레이트 1개 수준만.
- **작게 쪼개 조합.** 스택 디테일은 `stacks/*`에, 횡단 관심사는 `crosscutting/*`에, 진짜 공통은 `common/`에.
- **살아있는 문서 (래칫).** 막연한 베스트프랙티스는 넣지 않는다. **모든 규칙 한 줄은 *실제로 터진 실패*에 추적 가능**해야 한다 — 버그가 한 번 돌아오면 그걸 막는 규칙이 모듈에 박힌다(예: py-fastapi의 bcrypt 72바이트 `ValueError`). "있으면 좋을 것 같아서"는 금지.
- **매뉴얼 말고 맵.** 각 모듈은 **짧게**(판단 기준 + 포인터). 1000페이지 매뉴얼이 되면 Claude도 안 읽는다. 길어지면 디테일은 코드·외부 문서로 오프로드하고 모듈엔 "어디를 보라"만 남긴다.
- **공용 마스터 불변.** 색·프로젝트별 값은 복사된 사본에서만 바꾼다.

## 사용 방법 (단일 원천 = 이 vault 실행본)

> **원천 경로**: `/Users/ravi/Documents/Obsidian Vault/공통-SKILLS/v1-skill-setup` (이 README가 속한 곳).
> work_space 사본(`/Users/ravi/work_space/skill-sets/v1-skill-setup`)은 **git 백업**일 뿐 — 셋업은 이 vault 실행본을 참조·복사한다.

- 프로젝트를 시작할 경로 확인 (예: `/Users/ravi/work_space/ai-make-service/`)
- Claude Code에 입력: **"`<프로젝트 경로>` 에 vault `공통-SKILLS/v1-skill-setup/setup` 스킬대로 프로젝트 만들어줘"**
- 질문 트리(앱/웹 → 백엔드 → 프론트 → 컬러 → 경로)가 나오면 정상.

