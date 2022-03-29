%! Class = tuda-cheatsheet
%! Author = Nyanyan
%! Date = 2022/03/29


%%---------------------------%%
%%--Document class settings--%%
%%---------------------------%%

%%--Version--%%
\def\fileversion{1.00}
\def\filedate{2022/03/29}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}

%%--Key-Value Option--%%
\RequirePackage{l3keys2e}

%%--Identification--%%
\ProvidesExplClass{tuda-cheatsheet}
{\filedate}
{\fileversion}
{(TUDa-CI) - Cheatsheet Template}

%%--Preconfiguration--%%
\keys_define:nn {ptxcd/cheatsheet} {
	color .code:n = {\PassOptionsToClass{color=#1}{tudaexercise}},
	color .initial:n=3b,
	columns .int_set:N=\g_ptxcd_cheatsheet_columns_int,
	columns .initial:n=2,
	columnsep .code:n={\setlength{\columnsep}{#1}},
	columnseprule .code:n={\setlength{\columnseprule}{#1}},
	language .code:n={\PassOptionsToPackage{#1}{babel}},
	language .initial:n={english, main=ngerman},
}

\ProcessKeysOptions{ptxcd/cheatsheet}

\LoadClass[
	colorback=false,
]{tudaexercise}

%%--Document color--%%
\newcommand{\documentcolor}{\g_ptxcd_color_accent_tl}


%%------------%%
%%--Packages--%%
%%------------%%

%%--Color--%%
\RequirePackage{xcolor}

%%--Graphics--%%
\RequirePackage{graphicx}
\RequirePackage{tikz}

%%--Import--%%
% Import document content from another direcotry or different document.
\RequirePackage{import}
% Creating standalone documents to add them as sub document to the main document.
\RequirePackage{standalone}

%%--Language--%%
\RequirePackage{babel}
% Quotes
\RequirePackage[babel]{csquotes}

%%--List--%%
\RequirePackage{enumitem}

%%--Math--%%
\RequirePackage{amsmath, amssymb}
% Lightning symbol
\RequirePackage{stmaryrd}
% Bold
\RequirePackage{bm}

%%--Page--%%
\RequirePackage{multicol}

%%--Table--%%
% Beautiful tables
\RequirePackage{booktabs}
% Coloring
\RequirePackage{colortbl}
% Combine rows
\RequirePackage{multirow}


%%----------------%%
%%--Environments--%%
%%----------------%%
\let\olddocument\document
\let\oldenddocument\enddocument

%%--Document--%%
% Multi-column document
\RenewDocumentEnvironment{document}{}
{
	\olddocument
	\begin{multicols*}{\int_use:N \g_ptxcd_cheatsheet_columns_int}
		}
		{
	\end{multicols*}
	\oldenddocument
}

%%----------------%%
%%--Front matter--%%
%%----------------%%

%%--Author--%%
% Author sep for last author
\providecaptionname{ngerman, german}{\authorsep}{und}
\providecaptionname{english, american, british}{\authorsep}{and}

% Author by for headline
\providecaptionname{ngerman, german}{\authorsby}{von}
\providecaptionname{english, american, british}{\authorsby}{of}

\seq_new:N \l__ptxcd_author_seq

% Push students to a sequence
\newcommand{\authors}[1]{
	% Push author name to the right
	\seq_put_right:Nn \l__ptxcd_author_seq {#1}

	% Prepare author convention
	\tl_set:Nx \c__ptxcd_namesr_tl {\seq_item:Nn \l__ptxcd_author_seq {1}}
	% Comma separated authors
	\int_step_inline:nn {\seq_count:N \l__ptxcd_author_seq - 2}  {
		\tl_set:Nx \c__ptxcd_namesr_tl {
			\tl_use:N \c__ptxcd_namesr_tl, \space
			\seq_item:Nn \l__ptxcd_author_seq {\int_eval:n {##1 + 1}}
		}
	}
	% Last author will be separated with "and"
	\int_compare:nNnTF {\seq_count:N \l__ptxcd_author_seq} > {1}
	% If more than two author exists, add an "and, else do nothing
	{
		\tl_set:Nx \c__ptxcd_namesr_tl {
			\tl_use:N \c__ptxcd_namesr_tl\space
			\authorsep\space
			\seq_item:Nn \l__ptxcd_author_seq {\seq_count:N \l__ptxcd_author_seq}
		}
	}{}
	% Set authors
	\author{\tl_use:N \c__ptxcd_namesr_tl}
}

%%--Version--%%
\tl_new:N \g_ptxcd_version_tl
\newcommand{\version}[1]{\tl_gset:Nx \g_ptxcd_version_tl {#1}}
\providecaptionname{ngerman, german}{\versionname}{Version}
\providecaptionname{english, american, british}{\versionname}{Version}

%%--Semester--%%
\tl_new:N \g_ptxcd_semester_tl
\newcommand{\semester}[1]{\tl_gset:Nx \g_ptxcd_semester_tl {#1}}

%%--HeadLine--%%
\ConfigureHeadline{
	headline={
		\usekomafont{author}
		\@title
		\tl_if_empty:NF \g_ptxcd_semester_tl
		{
			\space\tl_use:N \g_ptxcd_semester_tl
		}
		\xdef\@author {\@author}
		\ifx\@author\@empty\else\space\authorsby\space\@author\fi
		\tl_if_empty:NF \g_ptxcd_version_tl
		{
			\hfill
			\textbf{\versionname :}\space\tl_use:N \g_ptxcd_version_tl
		}
	}
}
