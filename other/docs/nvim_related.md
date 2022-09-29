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

- Download linux x64 tar file from release link in the github repo

- Extract it and add the `<extracted>/bin` to `$PATH`

- nvim looks for lsp-language-server in `$PATH`

## Python

- Use [pyright]([GitHub - microsoft/pyright: Static type checker for Python](https://github.com/microsoft/pyright))

- To install
  
  - `sudo apt install nodejs npm`
  
  - `sudo npm -g install pyright`

- # C, C++ (C based langulages)

- Use clangd

- To install run `sudo nala install clangd`. make sure clangd>=11

- clangd relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html) specified as compile_commands.json, see [Getting started](https://clangd.llvm.org/installation#compile_commandsjson)

- 