# GitHub Project 看板设置说明

[English](github-project-board.md) | 中文

这份文档给中文维护者使用。它不是新的路线图，也不替代公开 GitHub Project。它的用途是把当前 MATLAB 科研绘图仓库和几个小型 plotting Skill 的维护事项整理成一套可以照着执行的看板设置步骤，等 GitHub Projects 权限可用后，直接按这里建立或核验公开看板。

目标看板名称：

```text
MATLAB Scientific Figure Ecosystem
```

看板应服务这些公开仓库：

- [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures)，主 gallery、MATLAB API、主题、导出和文档。
- [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci)，gallery、隐私、来源、风险文件和发布状态检查。
- [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill)，面向 agent 的数据到图表选择、MATLAB CLI 渲染和反馈收集。
- [`scientific-diagram-skill`](https://github.com/Kkkakania/scientific-diagram-skill)，面向 agent 的 Mermaid 和 draw.io / diagrams.net 科研示意图 workflow。
- [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill)，早期 Python 兄弟 Skill，用小型 Matplotlib gallery 验证跨语言选图思路。

## 当前状态

公开看板的创建任务记录在 [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31)。

截至 2026-06-22，本地维护用的 `gh` token 可以读写 issue，但仍然没有 GitHub Projects 权限。当前 `gh auth status` 显示的 scope 是：

```text
Token scopes: 'gist', 'read:org', 'repo', 'workflow'
```

也就是说，它能做普通仓库维护和 Actions 工作流相关操作，但不能读取或创建 GitHub Projects。运行下面的命令仍会返回缺少 `read:project` scope：

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

第一个脚本记录看板是否仍处于 pending 状态。第二个脚本列出当前跟踪的 plotting 仓库开放 issue 和 PR。它们只是维护快照，不代表公开看板已经建好。

新 issue 还会由 `.github/workflows/issue-triage.yml` 自动收到一条维护者检查清单。这条评论只提醒维护者设置 track、证据等级、下一步状态，以及在涉及私有数据时要求合成复现。它不会创建 GitHub Project 条目，也不需要 `project` 或 `read:project` 权限。

同时保持当前开放 issue 的标签可读。标签不能替代 Project 看板，但在看板 pending 时，它们能让临时 triage 状态更容易被别人看见：

| Issue | 临时标签 |
|---|---|
| [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31) | `documentation`, `ci` |
| [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) | `template`, `enhancement` |
| [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | `first-use`, `help wanted`, `good first issue`, `question` |
| [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | `enhancement` |
| [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | `testing`, `feedback` |
| [`scientific-diagram-skill#1`](https://github.com/Kkkakania/scientific-diagram-skill/issues/1) | `documentation`, `question` |
| [`python-plotting-skill#1`](https://github.com/Kkkakania/python-plotting-skill/issues/1) | `documentation`, `question` |
| [`python-plotting-skill#2`](https://github.com/Kkkakania/python-plotting-skill/issues/2) | `enhancement`, `good first issue` |

维护者可以用下面的脚本核验这些标签是否还在：

```bash
./scripts/check_ecosystem_issue_labels.sh
```

## 建议字段

看板字段保持少量，便于每周维护。

| 字段 | 类型 | 建议值 |
|---|---|---|
| Status | Single select | Inbox, Triaged, Accepted, In progress, Awaiting feedback, Done |
| Repository | Single select | scientific-figures, figure-ci, plotting-skill, diagram-skill, python-skill |
| Track | Single select | gallery, agent, ci, ecosystem-docs |
| Priority | Single select | P0, P1, P2, Later |
| Evidence level | Single select | none, single-report, reproducible, ci-covered |
| Release target | Text | v3.x, v2.x, v0.x, PyPI candidate；没有计划发布时留空 |

不要使用细到小数点的评分。这个生态现在更需要可验证的状态、下一步动作和证据等级。

这里最值得保留的是 `Awaiting feedback`。很多事项不是维护者忘了做，而是正在等外部反馈，比如首次使用报告、领域样例包反馈、Windows/MATLAB 版本差异反馈。把状态写成 `Awaiting feedback`，别人一眼就知道这不是普通 backlog，也不是已经接受但还没开工的任务。

证据等级按保守原则使用：

- `none`：只是想法或线索，还没有可复现依据。
- `single-report`：有一次外部反馈，或一次维护者观察。
- `reproducible`：有明确 commit 和命令，别人可以照着复跑。
- `ci-covered`：已经被当前 CI 或静态检查守住。

`Track` 不按“宣传分类”来分，而是按维护时的上下文切换成本来分：`gallery` 对应 MATLAB 模板、渲染和导出；`agent` 对应 MATLAB、Python 或 diagram Skill；`ci` 对应 `matlab-figure-ci`；`ecosystem-docs` 对应跨仓库文档、看板和维护协调。

## 建议视图

### Roadmap

用于看真正值得投入维护时间的事项。建议保存的筛选条件：

```text
is:open
field:Status != Done
field:"Evidence level" != none
field:"Release target" not empty
```

按 `Track` 分组，再按 `Priority` 降序、`Repository` 排序。

### Triage

用于处理新 issue、外部建议和 fork 线索。筛选条件是 `Status is Inbox`，按 `Repository` 分组，按创建时间排序。

### Release Readiness

用于收拢发布前检查。筛选条件是 `field:"Release target" not empty`，按 `Release target` 分组。

### Feedback Loops

用于放首次使用反馈、dogfooding 状态和等待外部确认的事项。筛选条件是 `Status is "Awaiting feedback"`，按更新时间从旧到新排序。一个合理的维护目标是：这个视图里不要有超过 14 天完全没有维护者 ping 或等待说明的条目。

### Cross-Repo Dependencies

用于看跨仓库依赖。先按 `Repository` 分组，再人工检查相关 issue 链接。

## 网页创建步骤

如果用 GitHub 网页创建：

1. 打开 `https://github.com/projects`，先确认浏览器当前登录账号是 `Kkkakania`，再点击 `New project`。`gh` CLI 账号和浏览器登录账号可能不是同一个。
2. 如果页面标题、头像菜单或 URL 显示的是其他 owner，先停止创建，切换到 `Kkkakania` 后再继续。
3. 新建项目，名称填写 `MATLAB Scientific Figure Ecosystem`。
4. 描述填写：

   ```text
   Cross-repository roadmap for MATLAB scientific figures, figure quality checks,
   MATLAB/Python agent-assisted data-to-figure workflows, and research diagram Skills.
   ```

5. 按上面的字段表建立字段。
6. 建立 Roadmap、Triage、Release Readiness、Feedback Loops 和 Cross-Repo Dependencies 五个视图。
7. 把下面的 seed queue 加入看板。
8. 为每个条目设置仓库、track、优先级、证据等级和 release target。没有计划发布或上传时，`Release target` 留空。
9. 把公开看板 URL 回填到 [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31)。

不要在没有公开 URL 或没有核验结果时关闭 `#31`。

## 第一批 seed queue

这些条目来自当前公开 issue。它们代表真实维护面，而不是为了填满看板制造任务。

| 条目 | 仓库 | Track | 建议状态 | 建议优先级 | 证据等级 | Release target | 下一步 |
|---|---|---|---|---|---|---|---|
| [`matlab-scientific-figures#31`](https://github.com/Kkkakania/matlab-scientific-figures/issues/31) | scientific-figures | ecosystem-docs | In progress | P1 | reproducible | （留空） | 创建或核验公开 GitHub Project 看板。 |
| [`matlab-scientific-figures#30`](https://github.com/Kkkakania/matlab-scientific-figures/issues/30) | scientific-figures | gallery | Awaiting feedback | P2 | ci-covered | （留空） | 等待 PV、harmonic-spectrum 与 three-phase 示例反馈，再决定是否扩展电气工程 pack。 |
| [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | scientific-figures | gallery | Awaiting feedback | P1 | single-report | （留空） | 收集 fresh-clone 首次使用反馈。 |
| [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | figure-ci | ci | Triaged | P1 | ci-covered | PyPI candidate | 等 package name 和安装检查都最新后，再准备 PyPI。 |
| [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | plotting-skill | agent | Awaiting feedback | P1 | single-report | （留空） | 收集第一次 MATLAB 渲染反馈。 |
| [`scientific-diagram-skill#1`](https://github.com/Kkkakania/scientific-diagram-skill/issues/1) | diagram-skill | agent | Awaiting feedback | P2 | single-report | （留空） | 收集 Mermaid 草图、`.drawio` 源文件和 diagram provenance 规则的首次使用反馈。 |
| [`python-plotting-skill#1`](https://github.com/Kkkakania/python-plotting-skill/issues/1) | python-skill | agent | Awaiting feedback | P2 | single-report | （留空） | 先收集 Python plotting 首次使用反馈，再决定是否扩展模板。 |
| [`python-plotting-skill#2`](https://github.com/Kkkakania/python-plotting-skill/issues/2) | python-skill | agent | Inbox | P2 | none | v0.2 candidate | 只有出现重复反馈后，才整理成小范围 v0.2 模板需求。 |

## 每周维护节奏

每周只需要做一次轻量更新：

1. 用 `./scripts/check_ecosystem_triage_status.sh` 看当前 plotting 仓库的开放 issue 和 PR。
2. 新事项先放 Inbox，确认范围、证据和下一步动作后移到 Triaged。
3. In progress 保持少量，避免看板变成堆积清单。
4. 如果事项主要卡在外部反馈，就放到 Awaiting feedback，并在超过两周前补一次 ping 或写清楚等待原因。
5. 事项完成后，链接对应 issue、PR 或 release note，再移动到 Done。

issue-triage workflow 只能给出第一次提醒，不能替维护者判断问题是否有效、是否需要进入路线图、是否需要等待反馈。

这个节奏的重点是让维护状态可检查。它不应该制造虚假的活跃度，也不应该把每次文档修补都变成 release。

## 不要放进看板的内容

不要把这些内容放进公开看板：

- 私人数据、raw 素材包、OCR 中间文件。
- 期刊截图、第三方 plotting 源码、未确认授权的模板。
- 下载量、star、采用规模或外部福利项目通过率声明。
- 没有公开 issue、没有验证动作、没有证据等级的想法。
- 只为了显得忙碌而建立的任务。

看板应该让别人看到这个生态怎么维护、怎么验证、下一步要做什么。它不用于包装采用规模，也不用于承诺任何审核结果。
