# Package notepad

- Creation of notepads

## Options

- `color`: Specifies the default box color (Default color = note-gray).

## Environment
- `note`: Creates a notepad.
  - Option `title`: Specifies the title of the notepad.
  - Option `color`: Specifies the color of the notepad.

    Examples:
    - `\begin{note}[title=Example,color=red} ... \end{note}`: A red notepad with the title
      "Example".

## Example
```tex
%%------------%%
%%--Preamble--%%
%%------------%%

\documentclass[11pt]{article}


%%------------%%
%%--Packages--%%
%%------------%%

\usepackage[
    color=note-red,
]{notepad}

\usepackage{blindtext}


%%------------%%
%%--Document--%%
%%------------%%

\begin{document}
	\begin{note}
	    \blindtext
	\end{note}

	\begin{note}[title=Custom color, color=note-blue]
	    \blindtext
	\end{note}
\end{document}
```
