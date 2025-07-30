param(
    [Parameter(Mandatory=$false)]
    [string]$ManifestPath = "bucket"
)

Write-Host "Scoop Manifest 파일들을 검증중..." -ForegroundColor Green

$manifestFiles = Get-ChildItem -Path $ManifestPath -Filter "*.json" -Recurse

if ($manifestFiles.Count -eq 0) {
    Write-Host "검증할 manifest 파일이 없습니다." -ForegroundColor Yellow
    exit 0
}

$errors = @()

foreach ($file in $manifestFiles) {
    Write-Host "검증중: $($file.Name)" -ForegroundColor Cyan
    
    try {
        # JSON 구문 검사
        $content = Get-Content $file.FullName -Raw
        $manifest = $content | ConvertFrom-Json
        
        # 필수 필드 검사
        $requiredFields = @('version', 'description', 'url')
        foreach ($field in $requiredFields) {
            if (-not $manifest.$field) {
                $errors += "$($file.Name): 필수 필드 '$field'가 누락되었습니다."
            }
        }
        
        # URL 형식 검사
        if ($manifest.url -and $manifest.url -notmatch '^https?://') {
            $errors += "$($file.Name): URL이 유효하지 않습니다."
        }
        
        Write-Host "✓ $($file.Name) 검증 완료" -ForegroundColor Green
        
    } catch {
        $errors += "$($file.Name): JSON 파싱 오류 - $($_.Exception.Message)"
        Write-Host "✗ $($file.Name) 검증 실패" -ForegroundColor Red
    }
}

if ($errors.Count -gt 0) {
    Write-Host "`n검증 오류:" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host "  $error" -ForegroundColor Red
    }
    exit 1
} else {
    Write-Host "`n모든 manifest 파일이 유효합니다!" -ForegroundColor Green
    exit 0
}
