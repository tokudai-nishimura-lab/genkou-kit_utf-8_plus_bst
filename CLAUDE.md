# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a LaTeX template for papers submitted to the Acoustical Society of Japan (ASJ) biannual meetings (日本音響学会研究発表会). It provides custom styling and bibliography formatting that complies with ASJ standards.

## Build Commands

### Local Build
```bash
# Build the LaTeX document (uses latexmk with configuration from latexmkrc)
latexmk sample.tex

# Clean build artifacts
latexmk -c sample.tex

# Clean all build artifacts including PDF
latexmk -C sample.tex
```

### Build Configuration
The repository uses `platex` (Japanese LaTeX) with `dvipdfmx` for PDF generation. The build process is configured in `latexmkrc` and optimized for Overleaf.

## Key Files and Architecture

### Core Template Files
- **`onkoron.sty`**: Custom style file that implements ASJ paper formatting requirements (165mm × 255mm text area, two-column layout, Japanese typography)
- **`onkoron.bst`**: Custom BibTeX style file for ASJ-compliant reference formatting (created with LLM assistance)
- **`sample.tex`**: Example paper demonstrating proper template usage

### Important Technical Details
- **Encoding**: UTF-8 throughout (important for Japanese text)
- **LaTeX Engine**: platex (NOT pdflatex or xelatex)
- **BibTeX Engine**: pbibtex (Japanese-aware BibTeX)
- **Font Size**: Default 11pt, can use 10pt if content doesn't fit

## Common Tasks

### Adding References
1. Edit `myrefs.bib` to add new bibliography entries
2. Use `\cite{}` commands in the LaTeX document
3. The custom `onkoron.bst` will format references according to ASJ standards

### Modifying Paper Layout
- Section formatting is controlled by `onkoron.sty`
- Two-column layout with 7mm separation is hardcoded in the style file
- Page dimensions should not be modified (ASJ requirement)

## Special Considerations

1. This template is specifically for ASJ conference papers - do not modify core formatting
2. The custom BibTeX style was created using LLM, so verify reference formatting
3. Japanese text handling requires platex, not standard LaTeX engines
4. The template is maintained at: https://github.com/tokudai-nishimura-lab/genkou-kit_utf-8_plus_bst