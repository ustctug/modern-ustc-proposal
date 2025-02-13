# USTC proposal

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/ustc-ivclab/ustc-proposal/main.svg)](https://results.pre-commit.ci/latest/github/ustc-ivclab/ustc-proposal/main)
[![github/workflow](https://github.com/ustc-ivclab/ustc-proposal/actions/workflows/main.yml/badge.svg)](https://github.com/ustc-ivclab/ustc-proposal/actions)

[![github/downloads](https://shields.io/github/downloads/ustc-ivclab/ustc-proposal/total)](https://github.com/ustc-ivclab/ustc-proposal/releases)
[![github/downloads/latest](https://shields.io/github/downloads/ustc-ivclab/ustc-proposal/latest/total)](https://github.com/ustc-ivclab/ustc-proposal/releases/latest)
[![github/issues](https://shields.io/github/issues/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/discussions)
[![github/milestones](https://shields.io/github/milestones/all/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/milestones)
[![github/forks](https://shields.io/github/forks/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/network/members)
[![github/stars](https://shields.io/github/stars/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/stargazers)
[![github/watchers](https://shields.io/github/watchers/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/watchers)
[![github/contributors](https://shields.io/github/contributors/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/commits)
[![github/release-date](https://shields.io/github/release-date/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/releases/latest)

[![github/license](https://shields.io/github/license/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal)
[![github/languages/top](https://shields.io/github/languages/top/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal)
[![github/directory-file-count](https://shields.io/github/directory-file-count/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal)
[![github/code-size](https://shields.io/github/languages/code-size/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal)
[![github/repo-size](https://shields.io/github/repo-size/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal)
[![github/v](https://shields.io/github/v/release/ustc-ivclab/ustc-proposal)](https://github.com/ustc-ivclab/ustc-proposal)

![screenshot](template/images/main-1.png)

## Dependencies

- [华文字体](https://github.com/chengda/popular-fonts)
- [中易字体](https://github.com/StellarCN/scp_zh/tree/master/fonts)
- [方正字体](https://github.com/Kangzhengwei/androidFront)
- [Times New Roman](https://github.com/siaimes/pytorch/tree/main/fonts)
- [font-awesome](https://github.com/FortAwesome/Font-Awesome)

## Usage

```sh
typst init @preview/ustc-proposal
```

## Development

```sh
mkdir -p ~/.local/share/typst/packages/preview/ustc-proposal
cd ~/.local/share/typst/packages/preview/ustc-proposal
git clone --depth=1 https://github.com/ustc-ivclab/ustc-proposal 0.0.1
cd 0.0.1
nix run '.#build'
# Or download all required fonts, then
typst compile main.typ
```

## Related Projects

### USTC proposal template

- [docx](https://cicpi.ustc.edu.cn/indico/conferenceDisplay.py?confId=971)
- [LaTeX](https://github.com/cgdsss/thesis_proposal_ustc)
