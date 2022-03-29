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
	color .default:n=3b,
	color .initial:n=3b,
	columnsep .code:n={\setlength{\columnsep}{#1}},
	columnseprule .code:n={\setlength{\columnseprule}{#1}},
	language .code:n = {\PassOptionsToClass{main=#1}{babel}},
	language .default:n={\PassOptionsToClass{main=ngerman}{babel}},
}

\ProcessKeysOptions{ptxcd/cheatsheet}

\LoadClass[
	%color=3b,
	colorback=false,
	ngerman,
]{tudaexercise}

% Document color
\newcommand{\documentcolor}{\g_ptxcd_color_accent_tl}


%%------------%%
%%--Packages--%%
%%------------%%

%%--Box--%%
\RequirePackage{tcolorbox}

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
\RequirePackage[english]{babel}
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
%%--Front matter--%%
%%----------------%%

%--Author--%
\providecaptionname{ngerman, german}{\autorname}{
	\int_compare:nNnTF {\seq_count:N \l__ptxcd_author_seq} > {1}
	{Autoren}
	{Autor}
}
\providecaptionname{english, american, british}{\autorname}{
	\int_compare:nNnTF {\seq_count:N \l__ptxcd_author_seq} > {1}
	{Author}
	{Authors}
}

% Author sep for last author
\providecaptionname{ngerman, german}{\authorsep}{und}
\providecaptionname{english, american, british}{\authorsep}{and}

% Author from for headline
\providecaptionname{ngerman, german}{\authorsof}{von}
\providecaptionname{english, american, british}{\authorsof}{of}

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

%--Version--%
\tl_new:N \l__ptxcd_version_tl
\newcommand{\version}[1]{\tl_gset:Nx \l__ptxcd_version_tl {#1}}
\providecaptionname{ngerman, german}{\versionname}{Version}
\providecaptionname{english, american, british}{\versionname}{Version}

%--Semester--%
\tl_new:N \l__ptxcd_semester_tl
\newcommand{\semester}[1]{\tl_gset:Nx \l__ptxcd_semester_tl {#1}}
\providecaptionname{ngerman, german}{\semestername}{Semester}
\providecaptionname{english, american, british}{\semestername}{Semester}

%--HeadLine--%
\ConfigureHeadline{
	headline={
		\usekomafont{author}
		\@title\space
		\tl_if_empty:NF \l__ptxcd_semester_tl
		{
			\tl_use:N \l__ptxcd_semester_tl\space
		}
		\authorsof\space\@author
		\tl_if_empty:NF \l__ptxcd_version_tl
		{
			\hfill
			\textbf{\versionname :}\space\tl_use:N \l__ptxcd_version_tl
		}
	}
}