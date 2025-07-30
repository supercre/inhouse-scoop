# Scoop Bucket 관리 스크립트들

## validate-manifests.ps1
모든 manifest 파일의 유효성을 검사합니다.

## update-manifests.ps1  
자동 업데이트가 설정된 manifest들을 업데이트합니다.

## generate-hash.ps1
파일의 SHA256 해시를 생성합니다.

사용법:
```powershell
# 모든 manifest 검증
.\scripts\validate-manifests.ps1

# 특정 manifest 업데이트
.\scripts\update-manifests.ps1 -Name "example-app"

# 파일 해시 생성
.\scripts\generate-hash.ps1 -Url "https://example.com/file.zip"
```
