---
name: quarto-tree-slide
description: 'Author or edit Quarto revealjs slides built on the tree-slide template (custom.scss). Use when writing slide content with custom fragments (highlight-forestgreen, highlight-indianred, highlight-steelblue, highlight-current-*, highlight-bold, highlight-current-bold, highlight-back, highlight-current-back, blur), inline tags (rtag, ltag, nftag, bltag, brtag), inline images (inlineimg), background highlight boxes (custom-box), thank-you slides, or when applying tree-slide conventions for speaker notes, callouts, footnotes, columns, overflow handling, iframes, and absolute positioning.'
argument-hint: 'Describe the slide content or the effect you want (e.g. "highlight three terms in sequence")'
---

# Quarto tree-slide: Custom Syntax and Conventions

Guide for writing slide **content** in `.qmd` files that use the tree-slide theme (`theme: [serif, custom.scss]`). Every class below is defined in `custom.scss`; do not invent classes that are not listed here.

Out of scope: Quarto CLI usage (preview/publish/options), YAML front-matter setup, project scaffolding. The only CLI use is the render check in [Validate After Editing](#validate-after-editing).

## Syntax Rules (read first)

- Prefer Pandoc span syntax: `[text]{.fragment .<effect> fragment-index=N}`. Pandoc emits `data-fragment-index` automatically.
- In raw HTML, write `data-fragment-index=N` (reveal.js ignores a bare `fragment-index`):
  `<span class="fragment highlight-steelblue" data-fragment-index="1">text</span>`
- Every effect class needs `.fragment` as well.
- Fragments sharing the same index trigger together; without an index, they trigger in document order.
- Colors are fixed to the three template colors: **forestgreen**, **indianred**, **steelblue**. For other colors, use `highlight-back` with `--bg-color`.

## Fragment Effects

### Choose the effect

| Goal | Class | Before trigger | At trigger | After (next fragment) |
|------|-------|----------------|------------|-----------------------|
| Color stays | `highlight-forestgreen` / `-indianred` / `-steelblue` | normal, visible | color + bold | color (not bold) |
| Color only while current | `highlight-current-forestgreen` / `-indianred` / `-steelblue` | normal, visible | color + bold | normal |
| Emphasis stays, keep color | `highlight-bold` | normal | bold + shadow | bold + shadow |
| Emphasis only while current | `highlight-current-bold` | normal | bold + shadow | normal |
| Marker background stays | `highlight-back` | normal | colored background | colored background |
| Marker background only while current | `highlight-current-back` | normal | colored background | normal |
| Reveal hidden text | `blur` | blurred (5px) | sharp | sharp |
| reveal.js default colors | `highlight-red` / `-green` / `-blue` (and `highlight-current-*`) | normal | recolored to indianred / forestgreen / steelblue | same as reveal.js |

All custom effects keep the text **visible before triggering** (unlike `.fragment` alone, which hides it).

### Examples

Sequential persistent highlights:

```markdown
- [forest green]{.fragment .highlight-forestgreen fragment-index=1},
- [indian red]{.fragment .highlight-indianred fragment-index=2}, and
- [steel blue]{.fragment .highlight-steelblue fragment-index=3}.
```

Walk-through where only the current item stands out:

```markdown
- [Step one]{.fragment .highlight-current-steelblue fragment-index=1}
- [Step two]{.fragment .highlight-current-steelblue fragment-index=2}
- [Step three]{.fragment .highlight-current-steelblue fragment-index=3}
```

Bold without changing color (useful on colored text or inside callouts):

```markdown
- [bold (current)]{.fragment .highlight-current-bold fragment-index=1}
- [bold (persistent)]{.fragment .highlight-bold fragment-index=2}
```

Marker-pen background; override the default translucent yellow via `--bg-color`:

```markdown
The key term is [entropy]{.fragment .highlight-back fragment-index=1}.
Also [this one]{.fragment .highlight-current-back fragment-index=2 style="--bg-color: rgba(70,130,180,0.3);"}.
```

Blur-then-reveal (e.g. answers, punchlines):

```markdown
- Answer: [42]{.fragment .blur fragment-index=1}
```

## Inline Tags

Small rounded labels. Combine with `.fragment` to make them appear on click.

| Class | Float | Color |
|-------|-------|-------|
| `nftag` | none (inline) | dark cyan |
| `rtag` | right | dark cyan |
| `ltag` | left | dark cyan |
| `brtag` | right | black |
| `bltag` | left | black |

```markdown
- Hello World [a no-floating tag]{.nftag .fragment fragment-index=1}
- Hello World [a align-right tag]{.rtag .fragment fragment-index=2}
- Hello World [a align-left tag]{.ltag .fragment fragment-index=3}
```

Gotcha: a floating tag (`rtag`/`ltag`/`brtag`/`bltag`) attaches to the **succeeding** element, even across line breaks. To keep a tag alone on its own line, follow it with the blank Braille character `⠀` (U+2800).

## Inline Image

Scale an image to the text line height (icons, logos inside a sentence):

```markdown
- Run it with ![](julia-logo.png){.inlineimg} Julia.
```

## Thank-you Slide

```markdown
## {.unlisted}

::: thankyou
Thank you!
:::
```

Use `thankyou-gold` instead for a gold label-style variant.

## Background Highlight Box (`custom-box`)

An absolutely-positioned rounded rectangle drawn **behind** slide content. Position and style through CSS variables in `style`:

| Variable | Default |
|----------|---------|
| `--left`, `--top` | `20px` |
| `--width`, `--height` | `150px` |
| `--bg-color` | `#3fb618` |
| `--radius` | `20px` |

Use `--bg-color` (not `--background-color`, which is ignored).

To make the box glide between items, repeat the slide with the same title, add `{auto-animate=true}`, and keep the same `data-id`:

```markdown
## Key points {auto-animate=true}

::: {data-id="box1" .custom-box style="--left: 200px; --top: 100px; --width: 250px; --height: 70px; --bg-color: #2780e3;"}
:::

- First point
- Second point

## Key points {auto-animate=true .unlisted}

::: {data-id="box1" .custom-box style="--left: 200px; --top: 170px; --width: 250px; --height: 70px; --bg-color: #2780e3;"}
:::

- First point
- Second point
```

Use sparingly: hard-coded pixel positions break when content changes. Prefer fragment effects when they suffice.

## Convention and Paradigm

### Slide structure

- `#` = section (appears in TOC), `##` = slide, `###` = sub-heading within a slide (TOC depth is 3).
- `## {}` creates a slide with no title.
- Add `{.unlisted}` to slides that should not appear in the TOC (continuation slides, thank-you slide).

### Speaker notes, callouts, footnotes

```markdown
::: {.notes}
Speaker note, visible only in speaker view (press S).
:::

::: {.callout-tip}
Callout types: tip | note | caution | warning | important.
:::

::: aside
Footnote-like text at the bottom of the slide.
:::
```

Inline footnotes use `^[This is a footnote]`.

### Columns and margin

```markdown
::: {.column-margin}
Side content.
:::

:::: {.columns}
::: {.column width="50%"}
- A-1
- A-2
:::
::: {.column width="50%"}
- B-1
- B-2
:::
::::
```

Use two columns for parallel/contrasting concepts.

### Overflow decision logic

When content overflows a slide:

1. **Default:** split into a new slide with the **same title** plus `{.unlisted}` so the TOC has no duplicate entries.
2. If splitting is not applicable (e.g., a single image is itself too large):
   - Add `{.scrollable}` to the slide. The slide heading scrolls away with the content.
   - If the heading or top content must stay fixed, wrap only the overflowing part in a scroll container:

     ```markdown
     ::: {.scroll-container style="overflow-y: scroll; height: 800px;"}
     ![](large-figure.png){width="1920px" fig-align="center"}
     :::
     ```

Never nest a scroll container inside a `{.scrollable}` slide; the presenter cannot tell which one scrolls.

### Embedding and positioning

- External page: `<iframe width="780" height="500" src="https://..." title="..."></iframe>`
- Absolute image: `![](figure.png){.absolute top=100 right=100 width="800px"}`
- Right-aligned text: `[Text]{style="float:right;text-align:right;"}`

## Validate After Editing

After editing a `.qmd`, render it once to catch syntax errors and typos. Nothing more (no preview, no publish, no extra flags):

```bash
cd <directory-of-the-qmd> && quarto render <file>.qmd
```

- Non-zero exit code or `ERROR` → fix the reported line and re-render.
- `WARN` lines (e.g. unresolved crossref, missing image) → fix if caused by your edit; otherwise mention them to the user.
- Do not inspect or edit the generated `.html` / `_files/` output.

## Checklist Before Finishing

- [ ] Every effect span has both `.fragment` and the effect class.
- [ ] Raw HTML uses `data-fragment-index`, not `fragment-index`.
- [ ] Only classes from this skill are used; colors limited to forestgreen / indianred / steelblue (or `--bg-color`).
- [ ] Overflowing slides are split with `{.unlisted}` before resorting to scrolling.
- [ ] `custom-box` uses `--bg-color` and matching `data-id` across auto-animate slides.
- [ ] `quarto render` completed without errors.
