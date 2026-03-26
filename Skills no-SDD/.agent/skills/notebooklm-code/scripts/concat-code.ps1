# Forzar codificacion UTF8 para caracteres especiales
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Today = Get-Date -Format "dd-MM-yyyy"

# 1. Definicion de Rutas y Archivo de Salida
$WorkspacePath = Get-Location
$OutputFileName = "code_$Today.md"
$FullOutputPath = Join-Path $WorkspacePath $OutputFileName

# CONFIGURACION: Lista de directorios a excluir (Configurable)
$ExcludeDirs = @("docs", ".agent", "venv", ".git", "__pycache__", "build", "dist")

# 2. Limpieza de compilaciones anteriores en el workspace
Get-ChildItem -Path $WorkspacePath -Filter "code_*.md" | Remove-Item -Force

# 3. Inicializacion del archivo de salida
"# ==============================================================================" | Out-File $FullOutputPath -Encoding UTF8
"# COMPILACION DE CODIGO FUENTE - FECHA: $Today" | Add-Content $FullOutputPath -Encoding UTF8
"# PROYECTO: $($WorkspacePath.Path)" | Add-Content $FullOutputPath -Encoding UTF8
"# ==============================================================================" | Add-Content $FullOutputPath -Encoding UTF8
"" | Add-Content $FullOutputPath -Encoding UTF8

# 4. Obtencion y filtrado de archivos *.py (Recursivo)
$Files = Get-ChildItem -Path $WorkspacePath -Filter "*.py" -Recurse | Where-Object {
    $itemPath = $_.FullName
    $shouldExclude = $false
    # Excluimos el propio archivo de salida para evitar recursion infinita
    if ($_.Name -eq $OutputFileName) { $shouldExclude = $true }
    
    foreach ($dir in $ExcludeDirs) {
        if ($itemPath -like "*\$dir\*") { 
            $shouldExclude = $true
            break 
        }
    }
    -not $shouldExclude
}

# 5. Concatenacion con encabezados comentados
if ($Files.Count -gt 0) {
    foreach ($File in $Files) {
        $RelativePath = $File.FullName.Replace($WorkspacePath.Path, "")
        
        "" | Add-Content $FullOutputPath -Encoding UTF8
        "# ------------------------------------------------------------------------------" | Add-Content $FullOutputPath -Encoding UTF8
        "# ARCHIVO: $RelativePath" | Add-Content $FullOutputPath -Encoding UTF8
        "# ------------------------------------------------------------------------------" | Add-Content $FullOutputPath -Encoding UTF8
        "" | Add-Content $FullOutputPath -Encoding UTF8
        
        '```python' | Add-Content $FullOutputPath -Encoding UTF8
        Get-Content $File.FullName -Encoding UTF8 | Add-Content $FullOutputPath -Encoding UTF8
        '```' | Add-Content $FullOutputPath -Encoding UTF8
        "" | Add-Content $FullOutputPath -Encoding UTF8
        
        Write-Host "Procesado: $RelativePath" -ForegroundColor Green
    }
    Write-Host "Exito: Codigo compilado en $FullOutputPath" -ForegroundColor Cyan
} else {
    Write-Warning "No se encontraron archivos .py para procesar en $WorkspacePath"
}
