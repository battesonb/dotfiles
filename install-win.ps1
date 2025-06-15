$directories = @{
    "vim/.vim" = "$Env:USERPROFILE\vimfiles";
    "intellij/.ideavimrc" = "$Env:USERPROFILE\.ideavimrc";
    "nvim/.config/nvim" = "$Env:LOCALAPPDATA\nvim";
    "vscode/.config/Code/User/settings.json" = "$Env:APPDATA\Code\User\settings.json";
}

foreach ($item in $directories.GetEnumerator()) {
    New-Item -ItemType SymbolicLink -Target "$PSScriptRoot\$($item.Name)" -Path "$($item.Value)"
}

