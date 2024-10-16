echo "Installing dependencies using 'aftman'"
aftman install

echo "Installing packages using 'wally'"
wally install

echo "Generating Rojo sourcemap"
rojo sourcemap -o sourcemap.json default.project.json

# Define an array for directories that need wally-package-types and stylua
$directories = @("./Packages", "./ServerPackages")

foreach ($dir in $directories) {
    if (Test-Path -Path $dir) {
        echo "[INFO] Processing $dir"
        echo "[*] Generating types using 'wally-package-types'"
        wally-package-types -s sourcemap.json $dir

        echo "[*] Formatting code using 'stylua'"
        stylua $dir
    }
}

# Special case for React.lua
$reactPath = "./Packages/React.lua"
if (Test-Path -Path $reactPath) {
    echo "Editing $reactPath to set _G.__DEV__"

    $reactContents = "_G.__DEV__ = game:GetService('RunService'):IsStudio()`n" + (Get-Content -Path $reactPath -Encoding ASCII -Raw)
    Set-Content -Path $reactPath -Value $reactContents -Encoding ASCII
    echo "Successfully edited $reactPath"
}
