# GitHub Project 看板设置说明

[English](github-project-board.md) | 中文

这份文档给中文维护者使用。它不是新的路线图，也不替代公开 GitHub Project。它的用途是把当前三仓库的维护事项整理成一套可以照着执行的看板设置步骤，等 GitHub Projects 权限可用后，直接按这里建立或核验公开看板。

目标看板名称：

```text
MATLAB Scientific Figure Ecosystem
```

看板应服务三个仓库：

- [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures)，主 gallery、MATLAB API、主题、导出和文档。
- [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci)，gallery、隐私、来源、风险文件和发布状态检查。
- [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill)，面向 agent 的数据到图表选择、MATLAB CLI 渲染和反馈收集。

## 当前状态

公开看板的创建任务记录在 [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31)。

截至 2026-06-04，本地维护用的 `gh` token 可以读写 issue，但没有 GitHub Projects 权限。运行下面的命令会返回缺少 `read:project` scope：

```bash
gh project list --owner Kkkakania --limit 20
```

如果要用 CLI 建立或核验看板，先刷新权限：

```bash
gh auth refresh -s read:project -s project
```

然后再次运行：

```bash
gh project list --owner Kkkakania --limit 20
```

如果暂时不能刷新权限，就先使用仓库里的临时检查脚本：

```bash
./scripts/check_github_project_board_status.sh --allow-pending
./scripts/check_ecosystem_triage_status.sh
```

第一个脚本记录看板是否仍处于 pending 状态。第二个脚本列出三个仓库当前开放的 issue 和 PR。它们只是维护快照，不代表公开看板已经建好。

## 建议字段

看板字段保持少量，便于每周维护。

| 字段 | 类型 | 建议值 |
|---|---|---|
| Status | Single select | Backlog, Ready, In progress, Needs review, Blocked, Done |
| Repository | Single select | scientific-figures, figure-ci, plotting-skill |
| Track | Single select | Gallery/API, Quality gate, Agent workflow, Documentation, Release, Feedback |
| Priority | Single select | P0, P1, P2, Later |
| Evidence level | Single select | Official/source-backed, Dogfooded, Needs user feedback, Proposal |
| Release target | Text | v3.x, v2.x, v0.x, no release planned |

不要使用细到小数点的评分。这个生态现在更需要可验证的状态、下一步动作和证据等级。

## 建议视图

### Roadmap

用于看仍在推进的事项。筛选条件是 `Status is not Done`，按 `Track` 分组，再按 `Priority` 排序。

### Triage

用于处理新 issue、外部建议和 fork 线索。筛选条件是 `Status is Backlog`，按 `Repository` 分组，按创建时间排序。

### Release Readiness

用于收拢发布前检查。筛选条件是 `Track is Release`，按 `Release target` 分组。

### Feedback Loops

用于放首次使用反馈、dogfooding 状态和 adoption report。筛选条件是 `Track is Feedback`，按 `Evidence level` 分组。

### Cross-Repo Dependencies

用于看跨仓库依赖。先按 `Repository` 分组，再人工检查相关 issue 链接。

## 网页创建步骤

如果用 GitHub 网页创建：

1. 打开账号的 Projects 页面。
2. 新建项目，名称填写 `MATLAB Scientific Figure Ecosystem`。
3. 描述填写：

   ```text
   Cross-repository roadmap for MATLAB scientific figures, figure quality checks,
   and agent-assisted data-to-figure workflows.
   ```

4. 按上面的字段表建立字段。
5. 建立 Roadmap、Triage、Release Readiness、Feedback Loops 和 Cross-Repo Dependencies 五个视图。
6. 把下面的 seed queue 加入看板。
7. 为每个条目设置仓库、track、优先级、证据等级和 release target。
8. 把公开看板 URL 回填到 [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31)。

不要在没有公开 URL 或没有核验结果时关闭 `#31`。

## 第一批 seed queue

这些条目来自当前公开 issue。它们代表真实维护面，而不是为了填满看板制造任务。

| 条目 | 仓库 | Track | 建议状态 | 建议优先级 | 证据等级 | Release target | 下一步 |
|---|---|---|---|---|---|---|---|
| [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31) | scientific-figures | Documentation | In progress | P1 | Dogfooded | no release planned | 创建或核验公开 GitHub Project 看板。 |
| [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) | scientific-figures | Gallery/API | Needs review | P2 | Dogfooded | no release planned | 等待 PV 与 harmonic-spectrum 示例反馈，再决定是否扩展电气工程 pack。 |
| [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | scientific-figures | Feedback | Ready | P1 | Needs user feedback | no release planned | 收集 fresh-clone 首次使用反馈。 |
| [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | figure-ci | Release | Backlog | P1 | Official/source-backed | v2.x | 等 package name 和安装检查都最新后，再准备 PyPI。 |
| [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | plotting-skill | Feedback | Ready | P1 | Needs user feedback | no release planned | 收集第一次 MATLAB 渲染反馈。 |

## 每周维护节奏

每周只需要做一次轻量更新：

1. 用 `./scripts/check_ecosystem_triage_status.sh` 看三个仓库的开放 issue 和 PR。
2. 新事项先放 Backlog，确认下一步动作后再移到 Ready。
3. In progress 保持少量，避免看板变成堆积清单。
4. 只有本地检查和 CI 都通过后，release 相关条目才移到 Needs review。
5. 事项完成后，链接对应 issue、PR 或 release note，再移动到 Done。

这个节奏的重点是让维护状态可检查。它不应该制造虚假的活跃度，也不应该把每次文档修补都变成 release。

## 不要放进看板的内容

不要把这些内容放进公开看板：

- 私人数据、raw 素材包、OCR 中间文件。
- 期刊截图、第三方 plotting 源码、未确认授权的模板。
- 下载量、star、采用规模或外部福利项目通过率声明。
- 没有公开 issue、没有验证动作、没有证据等级的想法。
- 只为了显得忙碌而建立的任务。

看板应该让别人看到这个生态怎么维护、怎么验证、下一步要做什么。它不用于包装采用规模，也不用于承诺任何审核结果。
