param(
    [Parameter(Mandatory=$false)]
    [string]$Name = "",
    [Parameter(Mandatory=$false)]
    [string]$ManifestPath = "bucket"
)

Write-Host "Manifest 파일들을 업데이트중..." -ForegroundColor Green

if ($Name) {
    $manifestFiles = Get-ChildItem -Path $ManifestPath -Filter "$Name.json"
} else {
    $manifestFiles = Get-ChildItem -Path $ManifestPath -Filter "*.json"
}

if ($manifestFiles.Count -eq 0) {
    Write-Host "업데이트할 manifest 파일이 없습니다." -ForegroundColor Yellow
    exit 0
}

foreach ($file in $manifestFiles) {
    Write-Host "처리중: $($file.Name)" -ForegroundColor Cyan
    
    try {
        $content = Get-Content $file.FullName -Raw
        $manifest = $content | ConvertFrom-Json
        
        # autoupdate가 설정되어 있는지 확인
        if ($manifest.autoupdate) {
            Write-Host "  자동 업데이트 설정이 발견되었습니다." -ForegroundColor Yellow
            
            # checkver를 통해 최신 버전 확인
            if ($manifest.checkver -and $manifest.checkver.github) {
                Write-Host "  GitHub에서 최신 버전을 확인중..." -ForegroundColor Cyan
                # 실제 구현은 scoop의 checkver 기능을 사용해야 합니다
                Write-Host "  수동으로 scoop checkver $($file.BaseName)을 실행하세요." -ForegroundColor Yellow
            }
        } else {
            Write-Host "  자동 업데이트가 설정되지 않았습니다." -ForegroundColor Gray
        }
        
    } catch {
        Write-Host "  오류: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n업데이트 확인이 완료되었습니다." -ForegroundColor Green
Write-Host "실제 업데이트를 위해서는 'scoop checkver' 및 'scoop update' 명령을 사용하세요." -ForegroundColor Yellow
