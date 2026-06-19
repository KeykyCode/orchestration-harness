# skill-sets — 재사용 스킬 모듈

**판단 기준 + 컨벤션**을 자산화한 모듈 모음. boilerplate가 아니라 *"이 스택에선 이렇게 한다 / 언제 무엇을 쓴다"*를 담는다.
새 프로젝트는 **`setup` 스킬이 질문으로 필요한 모듈을 조합**해 깔아준다.

## 구조

```
skill-sets/
├── v1-skill-setup/          ★ 모듈+조합 자산 (이 README가 속한 루트)
│   ├── setup/               ★ 질문 기반 조합 셋업 (create-react-app CLI처럼)
│   │
│   ├── common/              공통 — 항상 복사
│   │   ├── design-system/   DESIGN.md(토큰·컴포넌트) + tokens.md(색값·중립) + 규칙
│   │   └── workflow/        plan·design·develop·test·iterate 스킬 + agents 6 + .tasks 템플릿 (스택 중립)
│   │
│   └── modules/             선택·조합 대상
│       ├── vite-react-conventions/   Vite+React SPA 컨벤션
│       ├── next-conventions/         Next App Router 컨벤션
│       ├── supabase-auth/            서버사이드 인증·RLS
│       ├── tanstack-query/           서버상태(쿼리키·useQuery/Mutation)
│       └── api-client/               fetch 래퍼(인증·에러·401)
│
└── react-common-skills/     (레거시 보존)
```

## 새 프로젝트 시작 = `setup` 스킬

```
/setup
  → Q1. 프론트/백/풀스택?
  → Q2. Vite / Next?
  → Q3. Supabase / REST / 없음?
  → Q4. TanStack Query?
  → Q5. 컬러 시드 (#7c6bff …)?
  → Q6. 경로/이름?
  → common + 선택 modules 를 프로젝트 .claude/ 로 복사 + 컬러 적용 + 초기 셋업
```

**조합 예시**
| 제품 | 조합 (common + ↓) |
|---|---|
| SEO + Supabase (예: Proofly) | `next-conventions` + `supabase-auth` (+ `tanstack-query`) |
| 로그인 뒤 SPA 툴 | `vite-react-conventions` + `api-client` + `tanstack-query` |

## 워크플로우 (프로젝트에 복사된 뒤)

```
/plan-features "기능"  → backlog
/design-ui "화면"      → .tasks/design/
/develop-task "[태그]" → 코드 (conventions 규칙대로)
/test "대상"           → 테스트
/iterate               → 진척 분석 + 다음 액션
```

에이전트(`developer`·`ui-designer` 등)는 자연어 요청 시 자동 위임.

## 원칙

- **판단 기준 > 코드 덩어리.** 통짜 코드는 `api-client`·`supabase-auth`의 보일러플레이트 1개 수준만.
- **작게 쪼개 조합.** 스택 디테일은 `modules/*-conventions`에, 횡단 관심사는 별도 모듈에, 공통은 `common/`에.
- **살아있는 문서.** Claude가 매번 틀리는 지점을 발견하면 해당 모듈에 한 줄씩 추가한다.
- **공용 마스터 불변.** 색·프로젝트별 값은 복사된 사본에서만 바꾼다.

## 사용 방법

- 다운받은 skill 경로를 확인 -> /Users/ravi/work_space/skill-sets/v1-skill-setup
- 프로젝트를 시작하고자 하는 경로 확인 -> /Users/ravi/work_space/ai-make-service/
- claude code 에 입력 /Users/ravi/work_space/ai-make-service/ 디렉토리에 /Users/ravi/work_space/skill-sets/v1-skill-setup/setup 스킬대로 프로젝트 만들어줘

- 아래처럼 질문이 나오면 정상
<img width="998" height="869" alt="image" src="https://github.com/user-attachments/assets/2d542dfb-7727-4922-b7d0-07d4d5d4f191" />

