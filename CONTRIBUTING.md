# Contributing to Inhouse Tools Scoop Bucket

이 bucket에 기여해주셔서 감사합니다!

## 새로운 애플리케이션 추가하기

1. **Fork** 이 저장소를 포크합니다.

2. **Branch 생성** 새로운 기능 브랜치를 만듭니다:
   ```
   git checkout -b add-new-app
   ```

3. **Manifest 작성** `bucket/` 폴더에 새로운 JSON manifest 파일을 만듭니다:
   ```json
   {
       "version": "1.0.0",
       "description": "Your application description",
       "homepage": "https://github.com/your-org/your-app",
       "license": "MIT",
       "url": "https://github.com/your-org/your-app/releases/download/v1.0.0/your-app.zip",
       "hash": "sha256:actual_hash_here",
       "bin": "your-app.exe"
   }
   ```

4. **해시 생성** 스크립트를 사용하여 파일 해시를 생성합니다:
   ```powershell
   .\scripts\generate-hash.ps1 -Url "https://your-download-url.zip"
   ```

5. **검증** manifest 파일을 검증합니다:
   ```powershell
   .\scripts\validate-manifests.ps1
   ```

6. **테스트** 로컬에서 설치 테스트를 진행합니다:
   ```powershell
   scoop install .\bucket\your-app.json
   ```

7. **Pull Request** 변경사항을 커밋하고 PR을 제출합니다.

## Manifest 파일 작성 가이드

### 필수 필드
- `version`: 애플리케이션 버전
- `description`: 애플리케이션 설명
- `url`: 다운로드 URL
- `hash`: 파일의 SHA256 해시

### 권장 필드
- `homepage`: 프로젝트 홈페이지
- `license`: 라이선스 정보
- `bin`: 실행 파일 경로
- `shortcuts`: 바로가기 생성 정보
- `checkver`: 버전 확인 설정
- `autoupdate`: 자동 업데이트 설정

### 예제
```json
{
    "version": "2.1.0",
    "description": "A useful development tool",
    "homepage": "https://github.com/company/tool",
    "license": "Apache-2.0",
    "url": "https://github.com/company/tool/releases/download/v2.1.0/tool-windows.zip",
    "hash": "sha256:abc123...",
    "extract_dir": "tool-v2.1.0",
    "bin": [
        "bin/tool.exe"
    ],
    "shortcuts": [
        [
            "bin/tool.exe",
            "Development Tool"
        ]
    ],
    "checkver": {
        "github": "https://github.com/company/tool"
    },
    "autoupdate": {
        "url": "https://github.com/company/tool/releases/download/v$version/tool-windows.zip",
        "extract_dir": "tool-v$version"
    }
}
```

## 리뷰 프로세스

모든 PR은 다음 사항들이 검토됩니다:

1. **JSON 문법** 올바른 JSON 형식인지 확인
2. **필수 필드** 모든 필수 필드가 포함되어 있는지 확인
3. **URL 유효성** 다운로드 URL이 접근 가능한지 확인
4. **해시 정확성** 제공된 해시가 올바른지 확인
5. **테스트** 실제 설치가 정상적으로 동작하는지 확인

## 도움이 필요하신가요?

- Issue를 통해 질문해주세요
- 기존 manifest 파일들을 참고하세요
- [Scoop 공식 문서](https://github.com/ScoopInstaller/Scoop/wiki)를 확인하세요
