$Today = Get-Date -Format "dd-MM-yyyy"
# Capturamos la raíz del proyecto actual para garantizar la persistencia local [1, 2]
$Workspace = Get-Location 
$OutputName = "agent_$Today.md"
$FullOutputPath = Join-Path $Workspace $OutputName 

# Limpieza previa de archivos agent_*.md anteriores dentro del workspace [2]
Get-ChildItem -Path $Workspace -Filter "agent_*.md" | Remove-Item -Force

# Usamos la ruta del workspace para localizar la carpeta .agent del repositorio [3, 4]
$targetPath = Join-Path $Workspace ".agent"

if (Test-Path $targetPath) {
    # Inicializamos el archivo en el workspace con codificación UTF8
    "" | Out-File $FullOutputPath -Encoding UTF8

    Get-ChildItem -Path $targetPath -Recurse -File | ForEach-Object {
        # Calculamos la ruta relativa respecto al workspace actual
        $RelativePath = $_.FullName.Replace($Workspace.Path, ".")
        
        "### Archivo: $RelativePath" | Add-Content $FullOutputPath -Encoding UTF8
        Get-Content $_.FullName -Encoding UTF8 | Add-Content $FullOutputPath -Encoding UTF8
        "`n---`n" | Add-Content $FullOutputPath -Encoding UTF8
        
        Write-Host "Procesado: $($_.Name)" -ForegroundColor Cyan
    }
    Write-Host "Éxito: Archivo generado en $FullOutputPath" -ForegroundColor Green
} else {
    Write-Warning "La carpeta .agent no existe en el workspace actual: $Workspace" [3]
}