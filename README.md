# Inhouse Tools Scoop Bucket

이 저장소는 사내 도구들을 위한 Scoop bucket입니다.

## 사용법

```powershell
# bucket 추가
scoop bucket add supercre https://github.com/supercre/inhouse-scoop.git

# 패키지 설치
scoop install supercre/your-app
```

## Bucket에 포함된 도구들

- 추가 예정

## 기여하기

새로운 도구를 추가하려면:

1. `bucket/` 폴더에 manifest 파일 생성
2. Pull Request 제출
3. 리뷰 후 병합

## Manifest 파일 작성 가이드

Manifest 파일은 JSON 형식으로 작성되며, 다음과 같은 구조를 가집니다:

```json
{
    "version": "1.0.0",
    "description": "Application description",
    "homepage": "https://example.com",
    "license": "MIT",
    "url": "https://example.com/download/app-1.0.0.zip",
    "hash": "sha256:...",
    "bin": "app.exe",
    "checkver": "github",
    "autoupdate": {
        "url": "https://example.com/download/app-$version.zip"
    }
}
```
