# Package tuda-ci extension

## Requirements
- Package [tuda-ci](https://ctan.org/pkg/tuda-ci)
- Logo [tuda logo](https://www.intern.tu-darmstadt.de/arbeitsmittel/corporate_design_vorlagen/index.de.jsp)

## nyanyan-tudacheatsheet
- A cheatsheet templates using `tudaexercise` as a basis.

### Options
- `color`: The tuda color of the document (Default color = `3b`).
- `columns`: The number of columns to use (Default columns = `2`).
- `columnsep`: The distance between columns Specifies of the `multicols` environment.
- `columnseprule`: The thickness of separator line of the `multicols` environment (Default
  environment visible).
- `languages`: The main language of the document (Default: `english, main=ngerman`).

Examples:
- `color=1b`: The document is in `1b` (blue) color.
- `columns=3`: The document has 3 columns.
- `columnsep=1.5cm=`: The distance between columns is 1.5cm.
- `columnseprule=.2pt`: The thickness of separator line is 0.2pt.
- `languages={main=english}`: The document is in English.

### Example
```tex
%%------------%%
%%--Preamble--%%
%%------------%%

\documentclass[
	color=1b,
	columns=3,
	columnsep=1.5cm,
	columnseprule=.2pt,
	languages={english}
]{nyanyan-tudacheatsheet}


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
    \blindtext
    \columnbreak
    \blindtext
\end{document}
```

## nyanyan-submission
- An exercise submission templates using `tudaexercise` as a basis.

## Requirements
- Package [notepad](https://github.com/nyanyan-tuda/tex-templates/blob/main/classes/tuda-ci/notepad.cls)

### Options
- `color`: The tuda color of the document (Default color = `3b`).
- `languages`: The main language of the document (Default: `english, main=ngerman`).

Examples:
- `color=1b`: The document is in `1b` (blue) color.
- `languages={main=english}`: The document is in English.

### Front matter
- `\authros{name}`: Adds a new author.
- `\matriculations{number}`: Adds a new matriculation number. (Optional)
  - The number of given matriculation numbers must match the number of authors.
- `\deadline{date}`: Adds a deadline. (Optional)
- `\tutor{name}`: Adds an exercise group tutor. (Optional)
- `\group{name}`: Adds an exercise group. (Optional)
- `\sheetnumber{number}`: Adds a sheet number. (Optional)

### Example
```tex
%%------------%%
%%--Preamble--%%
%%------------%%

\documentclass[
	color=3b,
	languages=english,
]{nyanyan-tudasubmission}


%%------------%%
%%--Packages--%%
%%------------%%

\usepackage{blindtext}

%%----------------%%
%%--Front matter--%%
%%----------------%%

\authors{Author 1}
\authors{Author 2}
\authors{Author 3}
\matriculations{123456789}
\matriculations{123456799}
\matriculations{123456989}
\matriculations{123459789}

\deadline{\today}
\tutor{Tutor}
\group{6}
\sheetnumber{7}

%%------------%%
%%--Document--%%
%%------------%%

\begin{document}
	\maketitle
	\begin{task}[points=auto]{Task 1}
        \begin{subtask*}[points=5]{Subtask 1}
            \begin{solution}
                \blindtext
            \end{solution}
            \end{subtask*}
    \end{task}
\end{document}
```
