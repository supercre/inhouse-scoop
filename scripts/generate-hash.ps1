param(
    [Parameter(Mandatory=$true)]
    [string]$Url
)

Write-Host "URL에서 파일 해시를 생성중: $Url" -ForegroundColor Green

try {
    # 임시 파일 다운로드
    $tempFile = [System.IO.Path]::GetTempFileName()
    Write-Host "파일을 다운로드중..." -ForegroundColor Cyan
    
    Invoke-WebRequest -Uri $Url -OutFile $tempFile -UseBasicParsing
    
    # SHA256 해시 계산
    Write-Host "SHA256 해시를 계산중..." -ForegroundColor Cyan
    $hash = Get-FileHash -Path $tempFile -Algorithm SHA256
    
    # 결과 출력
    Write-Host "`n파일 해시:" -ForegroundColor Green
    Write-Host "sha256:$($hash.Hash.ToLower())" -ForegroundColor Yellow
    
    # 클립보드에 복사 (선택사항)
    "sha256:$($hash.Hash.ToLower())" | Set-Clipboard
    Write-Host "해시가 클립보드에 복사되었습니다." -ForegroundColor Green
    
} catch {
    Write-Host "오류 발생: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
} finally {
    # 임시 파일 정리
    if (Test-Path $tempFile) {
        Remove-Item $tempFile -Force
    }
}
