# CHANGELOG — orchestration-harness

> 팀 공통 Claude Code 스킬셋. 레포: `github.com/KeykyCode/orchestration-harness`
> 개발자 공유용 요약. 상세는 각 스킬의 `SKILL.md`·`README.md` 참조.

## 2026-07 — 오케스트레이션·컨텍스트·도입 라이프사이클 강화

### 🆕 새 스킬 / 에이전트

| 이름 | 무엇 | 언제 / 어떻게 |
|---|---|---|
| **`adopt`** 스킬 | 기존 프로젝트에 워크플로 **비파괴 부착** (스택 자동감지, conventions는 기존 코드에서 추출) | "이 프로젝트에 adopt 해줘" |
| **`update`** 스킬 | 이미 깐 프로젝트를 **최신으로 갱신** (harness만 덮고 conventions·상태·색은 보존) | "이 프로젝트 스킬 최신으로 갱신해줘" |
| **`checkpoint`** 스킬 + `resume.md` | **컨텍스트 수명 관리** — 청크 끝에 상태 저장 → `/clear` → 새 세션 재시작 | 세션 길어지면 "체크포인트" |
| **`gap-analyst`** 에이전트 | 기획 전 요구사항 **모순·모호·누락·위험** 1패스 점검 (read-only) | 크고 모호한 요청 앞단 |
| **`ai-engineer`** 에이전트 (`ai-llm` 모듈) | RAG·프롬프트·에이전트그래프·eval 전담 (**opt-in**) | AI 프로젝트 setup 시 선택 |

### ⚙️ 자동으로 걸리는 품질 규율 (개발자가 신경 안 써도 적용)

| 규율 | 내용 |
|---|---|
| **표면 증거** | 빌드/테스트 통과 ≠ 완료. 실제 화면·HTTP·CLI에서 동작 확인해야 완료 |
| **오염 없는 검증** | 게이트 raw 로그를 PM 컨텍스트에 안 쏟음 (verifier 위임 / tail·요약) |
| **보안 렌즈** | code-reviewer가 injection·XSS·쿠키·비밀키·민감정보 자동 점검 |
| **모델 라우팅** | 작업 크기별 자동 위임 (기계적=haiku / 표준=sonnet / 고난도=opus) |
| **계획 메타** | backlog 태스크에 wave·deps·QA 시나리오 부기 → 병렬성·완료판정 근거 |
| **인식론(working-principles)** | 과단정 금지·확신도 라벨(확인/추정/미확인)·반사적 동의 금지 |

### 🧱 내부 구조 (리팩터)

- **SSOT · 규칙 포인터**: agent=얇은 페르소나(누가/무엇을/왜), skill=절차, conventions=스택 규칙. 규칙 복제 없이 원천을 가리키기만.
- **스택 중립**: 웹 하드코딩 제거 → 웹/Flutter/FastAPI를 conventions로 분기.
- **위임은 PM 경유**: 에이전트→에이전트 직접 위임 제거(Claude Code 서브에이전트 1레벨 제약).

### 🚀 시작하기 (3형제)

```
새 프로젝트     → "이 경로에 <클론>/setup 스킬대로 만들어줘"
기존 프로젝트   → "이 프로젝트에 <클론>/adopt 해줘"
이미 깐 것 갱신  → "이 프로젝트 스킬 최신으로 갱신해줘"  (update)
```
> 팀원은 먼저 `git clone` (갱신 시 `git pull`). 갱신 후엔 **새 세션**이라야 새 스킬 인식.
