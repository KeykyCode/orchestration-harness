---
name: py-fastapi
description: Python FastAPI 백엔드를 새로 만들거나 엔드포인트·기능을 추가할 때 사용. 폴더구조(routers/services/repositories/schemas)·레이어 규칙·Pydantic 스키마·의존성 주입·명명·셋업 컨벤션을 적용한다. 프론트(Flutter/Next/Vite)는 api-client 횡단 모듈로 이 API를 호출한다.
---

# Python FastAPI Conventions

> 짝 모듈: 프론트엔드는 `api-client`(이 API를 호출하는 fetch 래퍼 원칙)로 붙는다.
> Supabase를 쓰는 구성이면 이 스택 대신 `supabase-auth`만으로 충분할 때가 많다 — **커스텀 서버 로직이 실제로 필요할 때만** FastAPI를 둔다.

## 셋업

```bash
uv init <name> && cd <name>          # 또는 python -m venv .venv && source .venv/bin/activate
uv add fastapi "uvicorn[standard]" pydantic pydantic-settings
uv add sqlalchemy alembic asyncpg     # DB 쓸 때 (Postgres 기준)
uv add --dev ruff mypy pytest httpx   # 린트·타입·테스트
uv run uvicorn app.main:app --reload  # 개발 서버
```

- `app/core/config.py`에 `pydantic-settings`로 환경변수 로드. `.env`는 **gitignore** + `.env.example` 커밋(키는 사본에만).
- CORS: 프론트(웹)에서 호출하면 `CORSMiddleware`에 허용 오리진 명시 — 와일드카드는 개발용만.

## 폴더 구조

```
app/
├── main.py            # FastAPI 인스턴스 + 라우터 등록 + 미들웨어
├── core/              # config(settings), security(인증), 공통 의존성
├── routers/           # 엔드포인트 정의 — 얇게. 검증→service 호출→응답만
├── services/          # 비즈니스 로직 — 라우터·DB 무관한 순수 도메인 로직 우선
├── repositories/      # DB 접근 (SQLAlchemy 쿼리). I/O 격리
├── schemas/           # Pydantic 모델 (요청/응답 DTO) — ORM 모델과 분리
├── models/            # ORM 모델 (SQLAlchemy 테이블)
└── tests/
```

## 레이어 규칙 (단방향)

```
schemas(DTO) ─┐
              ├─ routers → services → repositories → models(DB)
core(config·security·deps) ─ 횡단
```

- **routers는 얇게**: 입력 검증(Pydantic)·인증 의존성·service 호출·응답 변환만. 비즈니스 로직·쿼리를 라우터에 쓰지 마라.
- **services에 비즈니스 로직**: 가능한 순수하게. DB가 필요하면 repository를 주입받아 호출(직접 쿼리 X).
- **repositories가 유일한 DB 접근 지점**: 세션/쿼리를 여기 가둔다. service·router는 ORM 세션을 직접 만지지 않는다.
- **schemas(DTO) ≠ models(ORM)**: 응답에 ORM 객체를 그대로 노출하지 말고 Pydantic 스키마로 변환(`from_attributes`).
- **의존성 주입**: DB 세션·현재 사용자·설정은 `Depends`로 주입. 전역 import로 끌어오지 마라.

## 비동기

- 라우터·service는 `async def` 기본. DB는 async 드라이버(`asyncpg`) + `AsyncSession`.
- 블로킹 I/O(파일·동기 라이브러리)는 `run_in_threadpool`로 격리.

## 명명 규칙

| 대상 | 규칙 | 예 |
|---|---|---|
| 파일/모듈 | snake_case | `user_router.py`, `auth_service.py` |
| 함수/변수 | snake_case | `get_user_by_id` |
| 클래스(스키마/모델) | PascalCase | `UserCreate`, `UserModel` |
| 라우터 prefix | 복수 명사 | `/users`, `/games` |

## 새 기능(엔드포인트) 추가 순서

`schemas/`(DTO) → `models/`(필요 시 ORM·마이그레이션) → `repositories/` → `services/` → `routers/` → `main.py` 등록

## 태스크 태그 (workflow와 연동)

`[Schema]` `[Model]` `[Repo]` `[Service]` `[Router]` `[Migration]`
- `[Router]` = 엔드포인트, `[Service]` = 비즈니스 로직, `[Repo]` = DB 접근, `[Migration]` = Alembic.

## 검증

`uv run ruff check .` · `uv run mypy app` · `uv run pytest`. DB 스키마 변경 시 `alembic revision --autogenerate` → `alembic upgrade head`.
