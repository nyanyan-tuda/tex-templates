# Package star-rating

- A cheatsheet templates using `tudaexercise` as a basis.

## Options

- `color`: The tuda color of the document (Default color = `3b`).
- `columnsep`: The distance between columns Specifies of the `multicols` environment.
- `columnseprule`: The thickness of separator line of the `multicols` environment (Default
  environment visible).
- `language`: The main language of the document (Default: `english, main=ngerman`).

Examples:
- `color=1b`: The document is in `1b` (blue) color.
- `columnsep=1.5cm=`: The distance between columns is 1.5cm.
- `columnseprule=.2pt`: The thickness of separator line is 0.2pt.
- `language={main=english}`: The document is in English (Default language = ngerman).

## Example

```tex
%%------------%%
%%--Preamble--%%
%%------------%%

\documentclass[
	color=1b,
	columnsep=1.5cm,
	columnseprule=.2pt,
	languages={english}
]{tuda-cheatsheet}


%%------------%%
%%--Packages--%%
%%------------%%

\usepackage{blindtext}

%%----------------%%
%%--Front matter--%%
%%----------------%%

\title{Cheatsheet - Example}
\authors{John Doe}
\version{1.00} % Optional
\semester{WS 2021} % Optional

%%------------%%
%%--Document--%%
%%------------%%

\begin{document}
	\begin{multicols}{2}
		\blindtext
		\columnbreak
		\blindtext
	\end{multicols}
\end{document}
```
