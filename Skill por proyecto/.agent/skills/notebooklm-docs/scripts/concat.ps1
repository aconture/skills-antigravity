$Today = Get-Date -Format "dd-MM-yyyy"

# Capturamos la ruta del espacio de trabajo actual (donde el agente está operando)
$WorkspacePath = Get-Location
$OutputFileName = "docs_$Today.md"
$FullOutputPath = Join-Path $WorkspacePath $OutputFileName

# 1. Limpieza de archivos antiguos en el espacio de trabajo
Get-ChildItem -Path $WorkspacePath -Filter "docs_*.md" | Remove-Item -Force

# 2. Inicialización del archivo de salida con codificación UTF8
"" | Out-File $FullOutputPath -Encoding UTF8

# 3. Definición de la ruta de origen (\docs dentro del proyecto)
$DocsPath = Join-Path $WorkspacePath "docs"

# 4. Verificación y Concatenación
if (Test-Path $DocsPath) {
    Get-ChildItem -Path "$DocsPath\*.md" | ForEach-Object { 
        "### Archivo: $($_.Name)" | Add-Content $FullOutputPath -Encoding UTF8
        Get-Content $_.FullName -Encoding UTF8 | Add-Content $FullOutputPath -Encoding UTF8
        "`n---`n" | Add-Content $FullOutputPath -Encoding UTF8
        Write-Host "Procesado: $($_.Name)" -ForegroundColor Green
    }
    Write-Host "Éxito: Archivo generado en $FullOutputPath" -ForegroundColor Cyan
} else {
    Write-Warning "La carpeta \docs no existe en el workspace actual: $WorkspacePath"
}