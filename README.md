# Vim with [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) support

This vim setup is a very basic setup. Large portions were borrowed from [spf13-vim](https://github.com/spf13/spf13-vim/).

### Some things baked into this project: 

* [NerdTree](https://github.com/preservim/nerdtree) for file browsing
* [Fugative](https://github.com/tpope/vim-fugitive) for git gutter and more
* [vim-go](https://github.com/fatih/vim-go) provides all the formatting,
linting, import, functionality
* [tabularize](https://github.com/godlygeek/tabular) Auto tab aligning
* [vim-rainbow](https://github.com/frazrepo/vim-rainbow) Its easier to follow
  brackets when they aren't all the same color
* [Conquer Of Code](https://github.com/neoclide/coc.nvim)
for Language Server Protocol support (Think snippets and
autocomplete)
  * Language Servers supported so far
    * Go
    * Python
    * Javascript
    * Typescript
    * Terraform
    * Bash
    * Docker
    * Rust
    * JSON
    * Markdown
    * Python
  * Check out the [Language Server](https://github.com/neoclide/coc.nvim/wiki/Language-servers) Page for how to configure additional langage servers
* There's a bunch of others. Check out `./vimrc.plugins.symlink` for the full list.

## Vim Install Guide

### Short instructions

#### More testing needed

```go
if (os.Type == mac){
    fmt.Prinln("then install macvim yourself")
} 
```
Run this script. It works on Linux. Still have to test on Mac. I'm not
supporting windows. Should work in WSL though.
`./bootstrap.sh`

### Long Instructions

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
