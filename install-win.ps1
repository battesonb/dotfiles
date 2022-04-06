$directories = @{
    "vim/.vim" = "$Env:USERPROFILE\vimfiles";
    "intellij/.ideavimrc" = "$Env:USERPROFILE\.ideavimrc";
    "nvim/.config/nvim" = "$Env:LOCALAPPDATA\nvim";
}

foreach ($item in $directories.GetEnumerator()) {
    New-Item -ItemType SymbolicLink -Target "$PSScriptRoot\$($item.Name)" -Path "$($item.Value)"
}

