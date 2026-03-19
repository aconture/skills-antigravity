# Forzar a la consola a usar UTF8 para mostrar caracteres especiales correctamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Today = Get-Date -Format "dd-MM-yyyy"

# Definición de rutas globales (Home)
$homePath = [System.IO.Path]::Combine($env:USERPROFILE, ".gemini")
$targetPath = [System.IO.Path]::Combine($homePath, "antigravity", "skills")
$geminiFile = [System.IO.Path]::Combine($homePath, "GEMINI.md")

# Configuración del archivo de salida (Fijado en la carpeta de skills)
$OutputName = "skills_compiled_$Today.md"
$FullOutputPath = Join-Path $targetPath $OutputName 

# 1. Limpieza de compilaciones anteriores en el destino
if (Test-Path $targetPath) {
    Get-ChildItem -Path $targetPath -Filter "skills_compiled_*.md" | Remove-Item -Force
}

# Inicialización del archivo de salida
# Aseguramos que la carpeta existe antes de crear el archivo
if (!(Test-Path $targetPath)) { 
    New-Item -ItemType Directory -Force -Path $targetPath | Out-Null 
}
"" | Out-File $FullOutputPath -Encoding UTF8

# 2. Compilación de ~/.gemini/GEMINI.md
if (Test-Path $geminiFile) {
    "## Contexto Global: GEMINI.md" | Add-Content $FullOutputPath -Encoding UTF8
    "**Ruta:** $geminiFile`n" | Add-Content $FullOutputPath -Encoding UTF8
    Get-Content $geminiFile -Encoding UTF8 | Add-Content $FullOutputPath -Encoding UTF8
    "`n---`n" | Add-Content $FullOutputPath -Encoding UTF8
    Write-Host "Procesado: GEMINI.md (Global)" -ForegroundColor Yellow
} else {
    Write-Warning "No se encontró el archivo global: $geminiFile"
}

# 3. Compilación de archivos en ~/.gemini/antigravity/skills/
if (Test-Path $targetPath) {
    # Filtramos para no incluir el propio archivo que estamos generando
    Get-ChildItem -Path $targetPath -Filter "*.md" -Recurse -File | Where-Object { $_.Name -ne $OutputName } | ForEach-Object {
        "## Skill Global: $($_.BaseName)" | Add-Content $FullOutputPath -Encoding UTF8
        "**Ruta Origen:** $($_.FullName)`n" | Add-Content $FullOutputPath -Encoding UTF8
        
        Get-Content $_.FullName -Encoding UTF8 | Add-Content $FullOutputPath -Encoding UTF8
        "`n---`n" | Add-Content $FullOutputPath -Encoding UTF8
        
        Write-Host "Procesado Skill: $($_.Name)" -ForegroundColor Cyan
    }
    Write-Host "`nÉxito: Documento generado en $FullOutputPath" -ForegroundColor Green
} else {
    Write-Warning "La carpeta de skills no existe en: $targetPath"
}