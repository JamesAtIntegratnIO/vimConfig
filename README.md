# Vim Install Guide

Install vim-nox
link all vim files from dotfiles to $HOME

Install nodejs
[install nodejs from package](https://nodejs.org/en/download/package-manager/)

Install yarn
`npm install -g yarn`

Install missing Go dependencies
`vim +GoInstallBinaries`

Install the plugins
`vim +Pluginstall +q`

Configure coc-vim
`:CocConfig`

```json
{
  "languageserver": {
    "go": {
      "command": "gopls",
      "rootPatterns": ["go.mod"],
      "trace.server": "verbose",
      "filetypes": ["go"]
    }
  },
  "bash": {
    "command": "bash-language-server",
    "args": ["start"],
    "filetypes": ["sh"]
  },
  "dockerfile": {
    "command": "docker-langserver",
    "filetypes": ["dockerfile"],
    "args": ["--stdio"]
  },
  "rust": {
    "command": "rust-analyzer",
    "filetypes": ["rust"],
    "rootPatterns": ["Cargo.toml"]
  },
  "terraform": {
    "command": "terraform-ls",
    "args": ["serve"],
    "filetypes": ["terraform", "tf"],
    "initializationOptions": {}
  }
}
```

Install other coc extensions
`:CocInstall coc-json coc-tsserver coc-markdownlint coc-pyright coc-snippets`

Finish install for MarkdownPreview
`:call mkdp#util#install()`
