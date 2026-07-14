# orchestration-harness — 조합형 에이전트 오케스트레이션 하네스

> 팀 공통 **Claude Code 스킬셋**. 새 프로젝트를 조립하고(setup), 기존 프로젝트에 붙이며(adopt),
> 그 위에서 **PM 지휘자 + 역할 에이전트**가 기획→설계→구현→검증을 굴린다.
> boilerplate가 아니라 *"이 스택에선 이렇게 한다 / 언제 무엇을 쓴다"*는 **판단 기준**을 자산화한다.

두 얼굴을 가진다:
1. **조합기(부트스트래퍼)** — `setup`/`adopt`가 필요한 모듈만 프로젝트 `.claude/`로 조합.
2. **오케스트레이션 하네스** — `pm-orchestrator`가 역할 에이전트를 부려 위임·검증·통합.

---

## 🚀 빠른 시작 (팀원용)

### 1) 스킬셋 받기
```bash
git clone https://github.com/KeykyCode/orchestration-harness.git
```
받은 경로가 `$SRC`(스킬셋 루트)다. 슬래시 명령을 외울 필요 없이 **Claude Code에 자연어로** 말하면 된다.

### 2) 새 프로젝트 만들기 → `setup`
> Claude Code에 입력:
> **"`<새 프로젝트 경로>`에 `<클론경로>/setup` 스킬대로 프로젝트 만들어줘"**

질문 트리(앱/웹 → 백엔드 → 프론트 → 컬러 → AI/LLM → 경로)에 답하면, 필요한 모듈을 `.claude/`로 조합하고 스캐폴딩(create-*, flutter create)까지 해준다.

### 3) 기존(진행 중) 프로젝트에 붙이기 → `adopt`
> Claude Code에 입력:
> **"이 프로젝트에 `<클론경로>/adopt` 스킬대로 워크플로 붙여줘"**

스택을 **자동 감지**하고, 워크플로를 **비파괴(`cp -n`)로 부착**하며, conventions는 **기존 코드·CLAUDE.md에서 추출**해 생성한다. `CLAUDE.md`·기존 파일은 절대 안 건드린다. 스캐폴딩 없음.

### 4) 부착 후 개발 루프
프로젝트 `.claude/`에 스킬·에이전트가 깔리면, 이후엔 슬래시/자연어 둘 다 된다:
```
/plan-features "기능"  → backlog (화면구조·레이어 태스크·우선순위·wave/deps/QA)
/design-ui "화면"      → .tasks/design/ (UI 와이어프레임·위젯트리 / 백엔드는 API 계약)
/develop-task "[태그]" → 코드 (conventions 규칙대로 + 실제 표면 증거 확인)
/test "대상"           → 테스트 (웹 Vitest / Flutter flutter_test / FastAPI pytest)
/iterate               → 진척 스냅샷 + 다음 1수
/document-work         → 완료 요약을 로컬 Obsidian vault에 정리 (vault 없으면 skip)
```
**멀티파트 기능**(백+프론트+DB+AI+검증이 얽힘)은 *"PM처럼 조율해줘"* 라고 하면 `pm-orchestrator`가 지휘자로 붙는다.

---

## 📁 구조

```
orchestration-harness/          (= $SRC, 이 README의 루트)
├── setup/          ★ 새 프로젝트 조합·스캐폴딩 (질문 기반)
├── adopt/          ★ 기존 프로젝트에 비파괴 부착 (감지 기반)
│
├── common/workflow/   항상 복사 (스택 중립)
│   ├── skills: plan-features · design-ui · develop-task · test · iterate · document-work
│   ├── agents: 10개 (아래 로스터)
│   └── .tasks/     backlog · in-progress · done · iterate-log · product-goal 템플릿
│
├── stacks/         언어·프레임 종속 — 질문/감지로 1~2개
│   ├── flutter-app/     Flutter (Riverpod·자체 디자인토큰)
│   ├── py-fastapi/      FastAPI (routers·services·repos)
│   ├── ts-next/         Next App Router
│   └── ts-vite-react/   Vite+React SPA
│
└── crosscutting/   스택 중립 횡단 — 0~N개 (감지/선택)
    ├── design-system/   DESIGN.md+tokens.md (웹 프론트)
    ├── supabase-auth/   서버사이드 인증·RLS
    ├── tanstack-query/  서버상태(쿼리키·useQuery/Mutation)
    ├── api-client/      fetch 래퍼(인증·에러·401)
    └── ai-llm/          RAG·프롬프트·에이전트그래프·eval + ai-engineer 에이전트 (opt-in)
```

## 🎭 에이전트 로스터

지휘자 1 + 역할 9 (common, 항상) + AI 1 (opt-in):

| 에이전트 | 역할 | 단계 |
|---|---|---|
| **pm-orchestrator** | 지휘자 — 위임·직접검증·통합. 나머지를 부린다 | 오케스트레이션 |
| **gap-analyst** | 쪼개기 전 모순·모호·누락제약·위험 read-only 점검 | 기획 앞단 |
| **feature-planner** | 화면구조·레이어 태스크·우선순위 분해 → backlog | 기획 |
| **ui-designer** | 와이어프레임·컴포넌트(위젯)트리·상태 설계 | 설계 |
| **ux-director** | 정보 위계·미학·가시성 총괄, ui-designer 지시·검토 | 설계 총괄 |
| **developer** | conventions 레이어 규칙대로 구현 (스택 중립) | 구현 |
| **tester** | 단위·컴포넌트·시나리오 테스트 작성·실행 | 테스트 |
| **code-reviewer** | 규칙·아키텍처·보안 독립 검증 (기술 축) | 검증 |
| **acceptance-tester** | 가상 사용자 — 목표 워크플로 end-to-end 충족 검증 (목표 축) | 검증 |
| **iterator** | 상태 스냅샷 + 다음 1수 추천 | 진척 |
| **ai-engineer** *(opt-in)* | RAG·프롬프트·에이전트그래프·eval (ai-llm 모듈) | AI |

## 🧱 핵심 원칙 (왜 이렇게 설계했나)

- **SSOT · 규칙 포인터** — 규칙을 여러 곳에 복제하지 않는다. agent는 얇은 페르소나(누가/무엇을/왜), 절차는 skill이 SSOT, 스택 규칙·검증 명령·태그는 conventions가 SSOT. 각자 원천을 **가리키기만** 한다.
- **검증 2축, 구현자와 분리** — `code-reviewer`(기술: 규칙·정확성·보안) + `acceptance-tester`(목표: 가상 사용자 워크스루). self-review 편향 차단. *코드는 멀쩡한데 목표 미달*인 구멍은 후자에서만 잡힌다.
- **정적 게이트 통과 ≠ 완료** — 빌드/타입/테스트만으로 완료 금지. 실제 표면(브라우저·HTTP·CLI)에서 관찰가능 결과를 확인한다.
- **위임은 PM 경유** — 에이전트가 다른 에이전트를 직접 부르지 않는다(Claude Code 서브에이전트 1레벨 제약). 하위는 "다음 단계"를 PM에 반환.
- **살아있는 문서 (래칫)** — 막연한 베스트프랙티스 금지. 규칙 한 줄은 **실제로 터진 실패**에 추적 가능해야 한다. "있으면 좋을 것 같아서"는 넣지 않는다.
- **매뉴얼 말고 맵** — 각 모듈은 짧게(판단 기준 + 포인터). 길어지면 디테일은 코드·conventions로 오프로드.
- **공용 마스터 불변** — 색·프로젝트별 값은 복사된 사본에서만 바꾼다.
- **자기 주장에도 회의 (캘리브레이션·반아첨)** — 과단정 금지·확신도 라벨(확인/추정/미확인)·검증 경계 명시·반사적 동의 금지. "검증 2축"의 개인판(남 코드뿐 아니라 내 주장에도 회의). 상세는 `common/workflow/working-principles.md`, agent들은 포인터로 참조. (실패 추적: "코드소비0→제거안전" 과단정→반박→정정 반복)

---

## 🔧 유지보수자 전용 (원본 관리)

> 팀원은 여기 안 봐도 된다. 원본을 고치는 사람만.

- **원본(실행 원천)** = Obsidian vault 실행본 `…/공통-SKILLS/v1-skill-setup`. 편집·커밋은 여기서.
- **remote 2곳**: `origin`(`stpark89/v1-skill-setup`, 개인 백업) + `keykycode`(`KeykyCode/orchestration-harness`, 팀 공유). 커밋 후 `git push origin main && git push keykycode main`.
- **work_space 사본**(`~/work_space/skill-sets/v1-skill-setup`)은 git 백업 — 원본 push 후 `git pull`로 현행화.
- **모듈 추가 규율(래칫)**: "있으면 좋을 것 같아서" 금지 — 실제 실패가 있을 때만 규칙을 박는다.
- 프로젝트에 이미 깔린 사본은 옛 버전 그대로. 갱신하려면 Claude에게 *"이 프로젝트 .claude를 최신 스킬셋으로 갱신해줘"*.
