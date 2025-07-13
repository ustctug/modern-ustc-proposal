# My proposal

## Dependencies

- [华文字体](https://github.com/chengda/popular-fonts): pre-installed on Windows
- [中易字体](https://github.com/StellarCN/scp_zh/tree/master/fonts):
  pre-installed on Windows
- [方正字体](https://github.com/Kangzhengwei/androidFront): pre-installed on
  Windows
- [Times New Roman](https://github.com/siaimes/pytorch/tree/main/fonts):
  pre-installed on Windows
- [font-awesome](https://github.com/FortAwesome/Font-Awesome)

## Build

Download [needed fonts](template). If you use nix, nix will
download it automatically.

```sh
typst compile main.typ
# or use nix
nix run '.#build'
```

See compiled `main.pdf` to know usage.
