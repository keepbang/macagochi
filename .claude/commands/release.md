GitHub Actions 릴리스 워크플로우를 실행합니다.

인자: $ARGUMENTS
- 형식: `[bump] [branch]`
- bump: `patch` (기본값) | `minor` | `major`
- branch: `master` (기본값)
- 예시: `/release`, `/release minor`, `/release patch main`

다음 단계를 수행하세요:

1. 인자를 파싱합니다:
   - 첫 번째 인자가 `patch`, `minor`, `major` 중 하나면 bump로 사용, 없으면 `patch`
   - 두 번째 인자가 있으면 branch로 사용, 없으면 `master`

2. 아래 curl 명령어로 GitHub Actions 워크플로우를 트리거합니다:

```bash
curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/keepbang/macagochi/actions/workflows/release.yml/dispatches \
  -d "{\"ref\": \"<branch>\", \"inputs\": {\"branch\": \"<branch>\", \"bump\": \"<bump>\"}}"
```

3. 응답이 없으면 성공(204 No Content)입니다. 실행 결과를 확인합니다:

```bash
curl -s \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/keepbang/macagochi/actions/runs?per_page=1" \
  | python3 -c "import sys,json; r=json.load(sys.stdin)['workflow_runs'][0]; print(f'Run #{r[\"run_number\"]}: {r[\"status\"]} — {r[\"html_url\"]}')"
```

4. 워크플로우 URL을 출력해주세요.

GITHUB_TOKEN 환경변수가 없으면 사용자에게 `! export GITHUB_TOKEN=토큰` 실행을 안내하세요.
