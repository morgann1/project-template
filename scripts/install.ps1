echo "🚀 Running 'aftman install'"
aftman install

echo "🚀 Running 'wally install'"
wally install

echo "🚀 Generating Rojo sourcemap"
rojo sourcemap -o sourcemap.json default.project.json

if (Test-Path -Path "./Packages") {
    echo "🚀 Generating types for Packages/ via wally-package-types"
    wally-package-types -s sourcemap.json Packages/

    echo "🚀 Styling Packages/ via stylua"
    stylua Packages/
}

if (Test-Path -Path "./ServerPackages") {
    echo "🚀 Generating types for ServerPackages/ via wally-package-types"
    wally-package-types -s sourcemap.json ServerPackages/

    echo "🚀 Styling ServerPackages/ via stylua"
    stylua ServerPackages/
}

if (Test-Path -Path "./Packages/React.lua") {
    echo "🚀 Editing Packages/React.lua to include _G.__DEV__"

    $reactContents = "_G.__DEV__ = game:GetService('RunService'):IsStudio()`n"
    $reactContents = $reactContents + (Get-Content -Path .\Packages\React.lua -Encoding ASCII -Raw)
    Set-Content -Path .\Packages\React.lua -Value $reactContents -Encoding ASCII
}
