# Some dependencies needed

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

<div align="center">

```
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⣿⣿⣿⣿⣦⣄⠀⠀⠠⠰⠶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⡤⢀⣴⣿⣿⣿⠏⠀⠋⢉⣠⣿⣿⣿⣿⣿⣿⣿⣤⣄⡀⠈⠙⢿⣿⣿⣿⣧⡀⠐⠻⣶⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⠟⠁⠉⢠⣾⣿⣿⡿⠁⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠈⠻⣿⣿⣿⣷⡄⠀⢀⠙⢿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠟⢁⡔⠀⣠⣿⣿⣿⡿⠁⣠⣾⣿⣿⠛⣻⣿⣿⡿⠁⠹⣿⣿⣿⣿⣿⣿⣿⣦⡀⠹⣿⣿⣿⣿⡀⠈⢧⡈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⢠⡿⠀⢰⣿⣿⣿⡿⠁⣼⣿⣿⡿⠃⣼⣿⠏⠀⠁⣴⣆⠈⠉⠙⢿⣿⣿⣿⣿⣷⡄⢹⣿⣿⣿⣷⠀⠀⢷⡈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢠⣿⠃⠀⣿⣿⣿⣿⠃⣸⣿⣿⠟⢀⣾⠿⠋⠀⢠⣾⣿⣿⣷⣄⠀⠀⠙⢿⣿⣿⣿⣷⠀⣿⣿⣿⣿⡄⢣⠘⣇⠘⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡟⠀⢰⣿⣿⣿⡟⢀⣿⠟⠀⠰⠛⠋⠀⢠⣾⣿⣿⣿⣿⣿⡿⠟⠂⣀⠀⠉⠙⢿⣿⡇⢸⣿⣿⣿⣇⠘⡄⢹⡀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⡇⠀⠸⣿⣿⣿⡇⠈⠁⠀⠀⡀⠀⢀⣀⣤⣿⣿⣿⣿⣿⣿⣷⣤⣍⣉⣁⣤⣤⣀⠙⠓⠘⣿⣿⣿⣿⠀⣇⢸⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣾⣿⠁⠀⠀⣿⣿⣿⡇⢠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⣿⠻⣿⠛⡆⢻⠸⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⡆⠀⣿⣿⠙⡇⢸⣿⣿⡿⠿⠟⠋⠙⢻⣿⣿⣿⣿⣿⣿⣿⣿⠛⠙⠛⠿⢿⣿⣿⣿⠀⡟⠀⣿⠀⡇⢈⣀⠛⠛⠻⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⢻⣿⡆⢁⠘⣿⣿⣇⣀⣀⣀⣠⣼⣿⣿⣿⣿⣿⣿⣿⣿⣦⣀⣀⠀⢠⣿⣿⣿⠀⠇⢰⣿⠀⡇⢠⣌⣉⣉⠓⠒⠶⠶⠤⠤⣤⣀⠀
              ⠀⠈⠓⠶⢄⠐⠲⠀⡄⢾⣿⣿⣿⣧⠀⠘⣿⡇⠘⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⢸⣿⠀⠁⢸⣿⣿⣿⠇⢰⣀⣄⠠⠒⠉⠀⠀
              ⠀⠀⠀⠀⠀⠀⠘⠛⠇⠀⠹⣿⣿⣿⡄⠀⠹⣷⠀⠁⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⣿⡏⠀⠀⣾⡿⠟⠋⠀⠀⠉⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠉⣙⠛⠀⠀⠙⡆⠀⠀⢻⣿⣿⣿⣿⣿⣿⡿⠿⣿⠿⠿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣇⢀⡾⠀⠇⠀⠀⢀⡠⠄⢀⣠⣶⡇⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣷⡆⠉⠀⠀⠀⠀⠀⠀⠀⢺⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠈⢠⣶⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡄⠀⠀⠸⣿⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠀⠀⠀⣾⠁⠀⣠⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣷⠀⠘⡀⢻⡀⠀⠀⠀⠈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠃⠀⢰⣿⣿⣿⠀⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠸⣿⣿⡀⠀⣧⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⠿⢿⣿⠿⠿⠛⠋⠁⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⢸⣿⣿⡿⢰⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡀⣿⣿⣇⠀⢿⡄⠃⢸⣿⣿⠀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣾⡇⠈⣿⣿⣿⠀⠀⠀⢸⣿⣿⡇⢸⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⣿⡇⣿⣿⣿⡆⠸⣧⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠐⣶⣶⣶⣿⣿⣿⣿⣿⡿⠋⠁⠀⣿⣿⡇⠀⠀⠀⣼⣿⣿⡇⠈⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⣿⡇⣿⣿⣿⣷⠀⢿⡀⠀⣿⣇⠀⠱⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠿⠛⢉⡠⠚⠀⢰⣿⣿⡇⠀⠀⠀⣿⣿⣿⡇⠀⠀⣠⡀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⠀⢰⡆⠀⢹⡇⢹⣿⣿⣿⡇⠸⡇⠀⢸⣿⡄⠀⢄⣉⠛⠒⠒⠦⠤⠤⠤⠤⠒⠒⠉⣁⣤⠂⠀⣸⣿⣿⠇⢨⡰⢀⣿⣿⣿⡇⠀⣰⣿⣷⡀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⠀⢠⣿⡇⠀⠸⡇⢸⣿⣿⣿⣿⠀⣿⠀⢸⣿⣷⠀⠘⣿⣿⡏⡠⠀⣴⠂⣤⠀⣶⠈⣆⠸⠃⠈⢠⣿⣿⣿⠀⣿⡇⢸⣿⣿⣿⡇⢠⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⢠⣿⣿⣿⠀⠀⣧⠸⣿⣿⣿⣿⡇⢸⡇⠀⣿⣿⣇⠀⠘⣿⡇⡇⢸⣿⢠⣿⠄⢿⠀⣿⠀⠀⣠⣿⣿⣿⡟⢠⣿⠃⣼⣿⣿⣿⡇⣾⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀
              ⠀⠀⠀⠀⠀⣼⣿⣿⣿⡇⠀⢸⠀⣿⣿⣿⣿⣿⠈⣿⠀⢿⣿⣿⣄⠁⢘⠀⡄⢸⣿⠈⢀⠀⢘⡀⢻⠀⣴⣿⣿⣿⣿⡇⢸⣿⣤⣿⣿⣿⣿⡇⣿⣿⠛⣿⣿⣿⣆⠀⠀⠀⠀
              ⠀⠀⠀⠀⢠⣿⣿⠃⣸⣿⠀⠸⡄⢻⣿⣿⣿⣿⡄⢻⡆⢸⣿⣿⣿⣿⣿⠀⠃⢈⡇⠀⢸⡄⠈⣇⠘⡆⢻⣿⣿⣿⣿⠁⣾⠇⣼⣿⣿⣿⣿⡇⣿⣿⡆⠘⣿⣿⣿⡆⠀⠀⠀
              ⠀⠀⠀⢀⣾⣿⡏⢀⣿⣿⡇⠀⡇⠸⣿⣿⣿⣿⣇⠸⣧⢸⣿⣿⣿⣿⡇⢸⠀⣿⠇⠀⠉⠉⠀⢿⡀⢳⠸⣿⣿⣿⣿⠀⡿⠀⣿⣿⣿⡏⢹⡇⣿⣿⣧⠀⠸⣿⣿⣿⡄⠀⠀
              ⠀⠀⠀⣼⣿⡿⠀⣼⣿⣿⣿⠀⢱⣶⣿⣿⣿⣿⣿⠀⣿⠈⣿⣿⣿⣿⡇⠈⠀⣿⠀⠀⠀⠀⠀⠸⡇⠸⡀⢿⣿⣿⡏⢰⠃⠀⣿⣿⣿⣧⢸⡇⣿⣿⣿⡆⠀⢹⣿⣿⣿⡀⠀
              ⠀⠀⢠⣿⣿⠁⢠⣿⣿⣿⣿⡄⢸⡇⢻⣿⣿⣿⣿⡆⠀⠃⣿⣿⣿⣿⠀⣾⢸⡿⢀⣤⣤⣤⣤⠀⢿⠀⡇⠸⣿⣿⡇⠘⢠⠀⣿⣿⣿⣿⢸⡇⢹⣿⣿⣷⡀⠀⢿⣿⣿⣧⠀
              ⠀⠀⣾⣿⠏⠀⣼⣿⣿⣿⣿⡇⢸⡇⢸⣿⣿⣿⣿⡇⠀⠀⢻⣿⣿⣿⠀⠉⢸⡇⢸⣿⣿⣿⣿⡇⠸⡇⢻⡀⢿⣿⡇⠀⠀⠀⣿⣿⣿⡇⢸⡇⣼⣿⣿⣿⣇⠀⠘⣿⣿⣿⣧
              ⠀⣸⣿⡟⠀⢠⣿⣿⣿⣿⣿⣿⠈⡇⠈⣿⣿⣿⣿⣷⡆⠀⢸⣿⣿⡏⢠⡇⣼⠃⠀⠀⠀⠀⠀⠀⠀⣷⠘⡇⠸⣿⡇⢀⠀⠀⣿⣿⣿⡇⠈⡇⣿⣿⣿⣿⣿⡄⢆⠸⣿⣿⣿
              ⢠⣿⣿⠁⡌⢸⣿⣿⣿⣿⣿⣿⠀⡇⠀⢿⣿⣿⣿⣿⡇⠀⢸⣿⣿⡇⢘⠇⣿⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⢻⠀⢿⣷⠈⠀⠀⣿⣿⣿⠇⠀⡇⣿⣿⣿⣿⣿⣷⠘⡄⢹⣿⣿
              ⣿⣿⠇⢸⠇⣿⣿⣿⣿⣿⣿⣿⠀⡇⠀⠸⣿⣿⣿⣿⡇⠀⢸⣿⣿⠇⣘⠀⡟⢠⣤⣤⣤⣤⣤⣴⣶⠀⡇⠸⡇⢸⣿⡀⠀⠀⢿⣿⣿⠀⠀⠃⣿⣿⣿⣿⣿⣿⡄⢹⡀⢿⣿
              ⠙⠿⢠⣿⠀⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢻⣿⣿⣿⠀⠀⣾⣿⣿⠀⣿⠀⡇⢸⣿⣿⣿⣿⠿⠿⠿⡇⢸⠀⢻⠈⣿⣧⠀⠀⢸⣿⡏⠠⠀⢰⣿⣿⣿⣿⣿⣿⣷⠀⢷⣸⠟
              ⠷⠄⠈⠋⢠⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠈⢿⣿⡟⠀⠀⣿⣿⣿⠀⠋⢀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡇⠸⡇⢻⣿⣷⡄⠀⣿⠃⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣇⠈⠀⠲
              ⣦⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⢰⡄⠈⢻⠇⠀⢸⣿⣿⣿⠸⡇⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠀⢧⠈⣿⣿⣷⡄⠘⢠⡆⢀⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀
              ⠉⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠈⢿⣦⡈⠀⣠⣿⣿⣿⡟⢠⠇⠘⠀⣤⣤⣤⣤⣤⣤⣤⣤⣴⡆⠸⡇⢸⡄⢹⣿⣿⡷⠀⣿⣧⣼⣿⣿⣿⣿⣿⡿⠟⢉⣤⠂⠀⠀
              ⠀⠀⠀⠀⠲⢤⣉⠛⠻⠿⣿⣿⣿⣿⣿⣶⣼⣿⣷⣀⣹⣿⣿⣿⡇⣼⠀⣿⠀⠛⠛⠛⠛⠋⠋⠉⠉⠉⠉⠀⢿⠈⣧⠈⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠋⣁⣤⠶⠋⣀⠴⠀⠀
              ⠀⠀⠀⠀⠐⠂⠌⠉⠓⠒⠦⠤⠍⠉⠉⠙⠛⠛⠛⠻⠿⠿⠿⠿⠇⠿⠀⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠇⠹⠄⠹⠿⠿⠿⠟⠋⠉⠤⠶⠚⠋⠉⠤⠔⠊⠁⠀⠀⠀
```

</div>

## Runtime & tools

- [Neovim](https://neovim.io/) (**≥ 0.12**) — required because nvim-treesitter is pinned to its `main` branch,
  which uses APIs (e.g. `vim.list`) that only exist in 0.12+. On Homebrew, until 0.12 is released as stable,
  install a dev build with `brew install --HEAD neovim`.
- [Git](https://git-scm.com/) — plugin management (lazy.nvim), gitsigns, diffview and `fff.nvim` frecency
- [RobotoMono Nerd Font](https://www.nerdfonts.com/font-downloads) — the terminal font used by the config (see the sample terminal configs); any Nerd Font works for the icons
- A terminal emulator (optional — pick either one, sample configs are provided):
  - [kitty](https://sw.kovidgoyal.net/kitty/) — see `example-kitty.conf`
  - [Ghostty](https://ghostty.org/) — see `example-ghostty.conf`

## Treesitter

nvim-treesitter is pinned to the `main` branch (see requirement above), which compiles grammars with the
`tree-sitter` CLI rather than a bundled compiler.

- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter) (**≥ 0.26.1**) — for installing/compiling
  nvim-treesitter grammars. Install with `cargo install tree-sitter-cli` (goes to `~/.cargo/bin`, no sudo)
  or `npm install -g tree-sitter-cli`. Note: the Homebrew `tree-sitter` formula currently ships the library
  without a new-enough CLI, so use cargo/npm.
- A C compiler (clang/gcc) — the CLI compiles the generated parser source locally

## File finding & search (fff.nvim)

The old Telescope setup has been replaced by [fff.nvim](https://github.com/dmtrKovalenko/fff.nvim),
which uses a native Rust backend for fuzzy file finding and live grep (`<leader>ff`, `<leader>fr`,
`<leader>fs`, `<leader>fc`, `<leader>fz`).

- [Rust](https://www.rust-lang.org/) toolchain (`cargo`) — needed to build the `fff` binary from source
  if a prebuilt binary cannot be downloaded automatically
- [ripgrep](https://github.com/BurntSushi/ripgrep) — for live grep

## LazyGit

- [LazyGit](https://github.com/jesseduffield/lazygit)

## LSP, formatters & linters (optional — many installed via Mason)

- [Node.js](https://nodejs.org/) — for Prettier, ESLint, TS/JS LSP
- [Python](https://www.python.org/) — for Pyright, pylint, black, isort
- [Go](https://go.dev/) — for gopls, golangci-lint, gofmt
- [Rust](https://www.rust-lang.org/) (rustup) — for rust_analyzer, cargo, rustfmt

## Debugging (nvim-dap, optional)

Adapters (`delve`, `codelldb`, `js-debug-adapter`) are installed via Mason. To actually debug you also need
the matching toolchains:

- [Go](https://go.dev/) — for Delve (`dlv`) debugging
- [Rust](https://www.rust-lang.org/) (`cargo`) — Rust launch builds the crate before debugging with codelldb
- [Node.js](https://nodejs.org/) — for the JS/TS debug adapter

## AI assistants (optional)

- [Claude Code](https://www.anthropic.com/claude-code) CLI (`claude`) — for `claudecode.nvim`
- [cursor-agent](https://cursor.com/) CLI (`cursor-agent`) — for `cursor-agent.nvim`
- [GitHub Copilot](https://github.com/features/copilot) subscription — for `copilot.lua` inline suggestions

## Installation

### 1. Prerequisites (macOS / Homebrew example)

```bash
# Neovim 0.12+ (dev build until 0.12 is stable) — required by nvim-treesitter main branch
brew unlink neovim 2>/dev/null; brew install --HEAD neovim
nvim --version            # expect v0.12.x / v0.13.x-dev

# tree-sitter CLI >= 0.26.1 (compiles treesitter grammars). Homebrew's formula is too old, use cargo/npm:
cargo install tree-sitter-cli      # installs to ~/.cargo/bin (make sure it's on PATH)
tree-sitter --version              # expect >= 0.26.1

# ripgrep for live grep (fff.nvim), plus a C compiler (Xcode CLT provides clang)
brew install ripgrep
```

On Linux use your package manager for ripgrep and a C compiler; get a Neovim 0.12+ build from
[the nightly/release page](https://github.com/neovim/neovim/releases) or your distro's nightly channel.
Optional toolchains (Node.js, Python, Go, Rust/rustup) are only needed for the matching LSPs/debuggers.

### 2. Clone the config into your config path

```bash
git clone git@github.com:0xataru/nvim-conf.git ~/.config/ataru/nvim-conf
```

### 3. Add the launch alias (matches this repo's `NVIM_APPNAME`)

```bash
echo "alias v='NVIM_APPNAME=ataru/nvim-conf nvim'" >> ~/.zshrc && source ~/.zshrc
```

`NVIM_APPNAME=ataru/nvim-conf` keeps this config isolated: its data/plugins live in
`~/.local/share/ataru/nvim-conf/`, separate from any default `~/.config/nvim`.

### 4. First run

Launch with `v` (or `NVIM_APPNAME=ataru/nvim-conf nvim`). On first start:

- lazy.nvim bootstraps and installs all plugins (`:Lazy` to inspect/sync).
- nvim-treesitter installs the grammars from `ensure_installed` (needs the `tree-sitter` CLI from step 1).
- LSP servers and tools (prettier, stylua, pylint, golangci-lint, …) install via Mason on first use or `:Mason`.

Verify everything with `:checkhealth` (in particular `:checkhealth nvim-treesitter`).
