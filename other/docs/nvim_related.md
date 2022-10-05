## Links useful for configuring neovim with Lua

- [Lua Ref Manual](https://www.lua.org/manual/5.3/)
- [Neovim Lua doc](https://neovim.io/doc/user/lua.html)

# Nvim Treesitter configurations

- Install nvim/nvim-treesitter plugin

- Check plugin/treesitter_lsp_cmp.lua for configurations
  
  - at present, all language parser is installed. TODO: Shortlist the 1s to use later. and remove others

# Nvim LSP Configurations

- Add [neovim/nvim-lspconfig]([GitHub - neovim/nvim-lspconfig: Quickstart configs for Nvim LSP](https://github.com/neovim/nvim-lspconfig)) for common LSP configurations.

## Lua

- Use [sumneko_lua]([GitHub - sumneko/lua-language-server: A language server that offers Lua language support - programmed in Lua](https://github.com/sumneko/lua-language-server))
- Check `other/useful_scripts/install_sumneko_lau_lsp_server.sh` to intall lua-lsp server

## Python

- Use [pyright]([GitHub - microsoft/pyright: Static type checker for Python](https://github.com/microsoft/pyright))

- To install
  
  - `sudo apt install nodejs npm`
  
  - `sudo npm -g install pyright`

## C, C++ (C based langulages)

- Use clangd

- To install run `sudo nala install clangd`. make sure clangd>=11

- clangd relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html) specified as compile_commands.json, see [Getting started](https://clangd.llvm.org/installation#compile_commandsjson)

## Rust
- Use rust-analyser
- Run this command to install
```bash
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
```