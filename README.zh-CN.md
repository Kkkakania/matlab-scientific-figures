# MATLAB Scientific Figures

[English](README.md) | 中文

一个 clean-room 重写的 MATLAB 科研绘图库，用于生成可复现、可检查、适合论文和工程报告的科学图表。

这个仓库不收录私人素材包、期刊截图、第三方源码包、本地模板归档或隐藏 helper。你可以直接使用 `sftPlot*.m` API 处理自己的数据，也可以运行合成数据示例来学习图表结构、导出方式和质量检查流程。

当前公开版本：`v3.7.1`。项目仍处于早期公开维护阶段：gallery、CLI 和质量检查已经可用，但不会宣称广泛采用、下载量或任何外部福利项目的通过保证。

## 适合谁

- 需要用 MATLAB 生成论文图、课程报告图、实验对比图的学生和研究者。
- 需要在中文论文、课程报告或工程图里保持中英文标签字体一致的用户。
- 需要把一次性脚本整理成可复现图表流程的工程师。
- 想学习图表类型、配色、导出和质量检查边界的科研绘图用户。
- 想把 clean-room 图表模板接入 CI 或 agent workflow 的维护者。

## 5 分钟开始

先列出模板，不渲染图：

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh list
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh info heatmap
```

渲染一个模板到临时目录：

```bash
SFT_OUTPUT_DIR=/tmp/sft-first-render MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh heatmap
```

运行内置 CSV 示例：

```bash
SFT_OUTPUT_DIR=/tmp/sft-csv-example MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh csv-example
```

让 CLI 检查一个 CSV/Excel 文件、推荐图形并生成报告：

```bash
SFT_OUTPUT_DIR=/tmp/sft-data MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh data-file examples/data/experiment_signal.csv
```

如果你只想看 standalone domain examples：

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh pv-power
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh directional-rose
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh marginal-scatter
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh raincloud
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh ribbon
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh vector-field
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh polar-bubble
```

## 用自己的 CSV/Excel 数据

当前版本提供基础 CSV 示例、可复用 `sftPlot*.m` API，以及第一版数据接入 workflow：

- `sftInspectDataFile`：检查 CSV/Excel 表格结构。
- `sftRecommendFigure`：根据数据形状给出透明的图形推荐。
- `sftRenderDataFile`：渲染第一版图，并生成 `figure_report.md` 和 `figure_report.json`。

现在可以从这些文档开始：

- [CSV/Excel 教程](docs/tutorial-csv-excel-data.md)
- [使用自己的数据](docs/use-with-your-data.md)
- [图表选择指南](docs/chart-selection-guide.md)

如果图里有中文、日文或韩文标签，可以让主题系统自动选择当前机器上可用的 CJK 友好字体：

```matlab
theme = sftTheme("TextScript", "cjk");
xlabel("时间");
ylabel("响应");
sftApplyTheme(gca, theme);
```

如果实验室或期刊要求某个字体，但协作者机器上未必安装，可以显式提供 fallback：

```matlab
theme = sftTheme("FontName", "Journal Sans", ...
    "FontFallbacks", ["Arial", "Helvetica", "DejaVu Sans"]);
```

## 图库范围

主 gallery 目前有 30 个 clean-room 模板，覆盖折线、置信区间、散点、密度散点、热图、双三角热图、局部放大图、日历热图、气泡矩阵、箱线加抖动、棒棒糖排序、桑基流、雷达图、平行坐标和 3D 曲面等常见科研图。

这些图使用确定性合成数据生成。它们的目的不是冒充真实论文数据，而是提供可以复现、可以检查、可以改造的图表结构。

## 项目生态

这个仓库是 MATLAB 科研绘图小生态里的主 gallery：

| 仓库 | 作用 |
|---|---|
| [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures) | clean-room MATLAB gallery、示例、主题、导出 helper 和文档。 |
| [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) | 检查 gallery 输出、来源边界、隐私痕迹、风险文件和 release 状态。 |
| [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) | 面向 agent/Codex 的数据到图表选择与渲染 workflow。 |

三个仓库一起维护，但职责分开：模板和图表 API 在这里，自动化检查在 `matlab-figure-ci`，agent-facing 工作流在 `matlab-plotting-skill`。

## 主题和全局默认值

一般情况下，建议用 `theme = sftTheme(...)` 创建样式，再把它传给 `sftApplyTheme(gca, theme)`。这种方式只影响当前图，不会改变 MATLAB 会话里其他工具箱或脚本的图形默认值。

如果你确实想让当前一段代码里的新图都继承同一套默认字体、字号和线宽，可以使用带清理句柄的写法：

```matlab
[theme, cleanup] = sftTheme('ApplyDefaults', true);
% 这里创建的新图会使用共享默认值
clear cleanup  % 恢复调用前的 root 默认值
```

如果只是想清掉本库写入的 root 图形默认值，可以调用 `sftResetTheme()`。它只处理 `sftTheme(..., 'ApplyDefaults', true)` 写过的几项默认值，不会重置整个 MATLAB 会话。

## 质量检查

本仓库的 CI badge 说明静态质量和 figure-quality 检查通过，不代表 GitHub-hosted runner 已经安装 MATLAB 或重新生成了全部图。需要完整验证时，在本地运行：

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

更多说明见 [Quality gates](docs/quality-gates.md) 和 [Release checklist](docs/release-checklist.md)。

## 来源和版权边界

本项目采用 clean-room 策略。允许进入公开仓库的内容包括：

- 为本仓库原创编写的 MATLAB 代码。
- 代码中生成的确定性合成数据。
- 为本仓库撰写的文档。
- 图表家族和表达任务层面的想法，例如“方向频率”“局部放大”“矩阵比较”。

不允许进入公开仓库的内容包括：

- 私人模板包、书籍配套源码、第三方 helper 库。
- `.mat`、`.fig`、`.p`、`.opju`、Office 文件、压缩包等不适合作为公开源码的素材。
- Nature/Science 图集、期刊截图、OCR 原文包或水印素材。
- 包含个人信息、本地路径、邮箱、账号名或不清楚来源的文件。

详细规则见 [Provenance policy](docs/provenance-policy.md)。

## 反馈

- Gallery/API 首次使用反馈：[`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9)
- Agent-assisted 渲染反馈：[`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11)

请使用合成数据或脱敏后的形状说明，不要上传私人数据、第三方源码包、期刊图片或本地完整路径。
