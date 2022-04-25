%! Class = tuda-cheatsheet
%! Author = nyanyan
%! Date = 2022/04/12

%%---------------------------%%
%%--Document class settings--%%
%%---------------------------%%

%%--Version--%%
\def\fileversion{1.0.3}
\def\filedate{2022/03/29}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}

%%--Key-Value Option--%%
\RequirePackage{l3keys2e}

%%--Identification--%%
\ProvidesExplClass{nyanyan-tudasubmission}
{\filedate}
{\fileversion}
{Nyanyan (TUDa-CI) - Submission Template}

%%--Color--%%
% Needs to be loaded before class
\RequirePackage[table]{xcolor}

%%--Preconfiguration--%%
\keys_define:nn {nyanyan/tuda/submission} {
	color .code:n = {\PassOptionsToClass{color=#1}{tudaexercise}},
	color .initial:n=3b,
	language .code:n={\PassOptionsToPackage{#1}{babel}},
	language .initial:n={english, main=ngerman},
}

\ProcessKeysOptions{nyanyan/tuda//submission}

\LoadClass[
	colorback=false,
	solution=true,
]{tudaexercise}

%%--Document color--%%
\DeclareDocumentCommand{\documentcolor}{}{\g_ptxcd_color_accent_tl}

%%------------%%
%%--Packages--%%
%%------------%%

%%--Caption--%%
% Centering caption
\RequirePackage[justification=centering]{caption}

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

%%--Notes--%
\RequirePackage[color=\g_ptxcd_color_accent_tl]{notepad}

%%--Page--%%
\RequirePackage{multicol}
\RequirePackage{pdflscape}

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

%%--Author--%%
% Author name
\providecaptionname{ngerman, german}{\authorname}{Autor}
\providecaptionname{english, american, british}{\authorname}{Author}
\providecaptionname{ngerman, german}{\coauthorname}{Co-Autor}
\providecaptionname{english, american, british}{\coauthorname}{Co-Author}

% Author sep for last author
\providecaptionname{ngerman, german}{\authorsep}{und}
\providecaptionname{english, american, british}{\authorsep}{and}

% Author by for headline
\providecaptionname{ngerman, german}{\authorsby}{von}
\providecaptionname{english, american, british}{\authorsby}{of}

% Contains authors
\seq_new:N \g_nyanyan_tuda_submission_authors_seq

% Syntax: \authors{name} (Name of the (co-)author)
\DeclareDocumentCommand{\authors}{m}{
	% Push author name to the right
	\seq_gput_right:Nn \g_nyanyan_tuda_submission_authors_seq {#1}

	% Prepare author convention
	\tl_set:Nf \l__nyanyan_tuda_submission_author_name_tl
	{
		\seq_item:Nn \g_nyanyan_tuda_submission_authors_seq {1}
	}
	% Comma separated authors
	\int_step_inline:nn {\seq_count:N \g_nyanyan_tuda_submission_authors_seq - 2}  {
		\tl_set:Nx \l__nyanyan_tuda_submission_author_name_tl {
			\tl_use:N \l__nyanyan_tuda_submission_author_name_tl, \space
			\seq_item:Nn \g_nyanyan_tuda_submission_authors_seq {\int_eval:n {##1 + 1}}
		}
	}
	% Last author will be separated with "and"
	\int_compare:nNnTF {\seq_count:N \g_nyanyan_tuda_submission_authors_seq} > {1}
	{
		% If more than two author exists, add an "and, else do nothing
		\tl_set:Nx \l__nyanyan_tuda_submission_author_name_tl {
			\tl_use:N \l__nyanyan_tuda_submission_author_name_tl\space
			\authorsep\space
			\seq_item:Nn \g_nyanyan_tuda_submission_authors_seq
			{\seq_count:N \g_nyanyan_tuda_submission_authors_seq}
		}
	}{}
	% Set authors
	\author{\tl_use:N \l__nyanyan_tuda_submission_author_name_tl}
}

%%--Matriculation number--%%
% Contains matriculation number
\seq_new:N \g_nyanyan_tuda_submission_matriculation_numbers_seq

% Syntax: \matriculations{number} (Matriculation number)
\DeclareDocumentCommand{\matriculations}{m}{
	\seq_gput_right:Nn \g_nyanyan_tuda_submission_matriculation_numbers_seq {#1}
}

%%--Task--%%
% Task names
\RenewDocumentCommand{\thetask}{}{\arabic{task}}
\RenewDocumentCommand{\thesubtask}{}{\arabic{subtask}}
\RenewDocumentCommand{\subtaskformat}{}{\taskname\space\thetask.\thesubtask\enskip}

% Credit position
\RenewDocumentCommand{\creditformat}{m}{\hfill #1}

% Seperator
\renewcommand*\sectionlinesformat[4]{%
	\parbox{\linewidth}{
		\bool_if:cT {g__ptxcd_ruled_#1_bool} {
			\rule[5\g_ptxcd_titlerule_dim]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
		}
		\@hangfrom{%
			\hskip #2#3}{
			\tl_if_eq:nnT {#1} {task} {
				\exp_args:No \tl_if_empty:nF {#4}
				{~} % Insert your task seperator here. Default ~: Whitespace
				\bool_if:NT \l__ptxcd_points_auto_bool {
					\exp_args:NNx \prop_get:NnN \g__ptxcd_loaded_points_prop {\thetask} \l_ptxcd_tmp_tl
					\quark_if_no_value:NF \l_ptxcd_tmp_tl {
						\fp_set:Nn \l_ptxcd_ex_task_points_fp {\l_ptxcd_tmp_tl}
					}
				}
			}
			#4
			\tl_if_in:nnT {#1} {task} {
				\tl_if_empty:cTF{l_ptxcd_ex_#1_credit_tl}
				{\pointformat{\fp_to_decimal:c {l_ptxcd_ex_#1_points_fp}}}
				{\creditformat{\tl_use:c {l_ptxcd_ex_#1_credit_tl}}}
			}
			\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
		\skip_vertical:n {\ptxcd_titlerule_sep: -\dp\strutbox}
		\bool_if:cT {g__ptxcd_ruled_#1_bool} {\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}}
	}}

%%--Exercise--%%
% Exercise group leader
\tl_new:N \g_nyanyan_tuda_submission_exercise_group_leader_tl
\DeclareDocumentCommand{\tutor}{m}
{
	\tl_gset:Nx \g_nyanyan_tuda_submission_exercise_group_leader_tl {#1}
}
\providecaptionname{ngerman, german}{\exercisegroupleadername}{Übungsgruppenleiter}
\providecaptionname{english, american, british}{\exercisegroupleadername}{Exercise group leader}

% Exercise group
\tl_new:N \g_nyanyan_tuda_submission_exercise_group_tl
\DeclareDocumentCommand{\group}{m}{\tl_gset:Nx \g_nyanyan_tuda_submission_exercise_group_tl {#1}}
\providecaptionname{ngerman, german}{\exercisegroupname}{Übungsgruppe}
\providecaptionname{english, american, british}{\exercisegroupname}{Exercise group}

% Deadline
\tl_new:N \g_nyanyan_tuda_submission_deadline_tl
\DeclareDocumentCommand{\deadline}{m}{\tl_gset:Nx \g_nyanyan_tuda_submission_deadline_tl {#1}}
\providecaptionname{ngerman, german}{\deadlinename}{Abgabefrist}
\providecaptionname{english, american, british}{\deadlinename}{Deadline}

%%--Solution title--%%
\providecaptionname{ngerman, german}{\solutiontitle}{Lösungsvorschläge}
\providecaptionname{english, american, british}{\solutiontitle}{Solutions}

%%--Title style--%%
\newcommand{\@titleformat}{
	% Authors must be set with \authors{name} and cannot be empty
	\seq_if_empty:NTF \g_nyanyan_tuda_submission_authors_seq
	{
		\msg_error:nn {nyanyan/tuda/submission}{No~authors~given,~please~use~\authors}
	}
	{}

	% If matriculation numbers are given, they must match the number of authors
	\seq_if_empty:NTF \g_nyanyan_tuda_submission_matriculation_numbers_seq
	{}
	{
		\int_compare:nNnTF{\seq_count:N \g_nyanyan_tuda_submission_authors_seq}
		=
		{\seq_count:N \g_nyanyan_tuda_submission_matriculation_numbers_seq}
		{}
		{
			\msg_error:nn {nyanyan/tuda/submission}{Number~mismatch~authors~and~matriculation~numbers}
		}
	}
	% Prepare left side
	\seq_clear:N \l_tmpa_seq
	% Author
	\seq_put_right:Nn \l_tmpa_seq {
		\textbf{\authorname}:\space
		\seq_item:Nn \g_nyanyan_tuda_submission_authors_seq {1}
		\seq_if_empty:NTF \g_nyanyan_tuda_submission_matriculation_numbers_seq
		{}
		{
			\space(\seq_item:Nn \g_nyanyan_tuda_submission_matriculation_numbers_seq {1})
		}
	}
	% Co-Author
	\int_step_inline:nn {\seq_count:N \g_nyanyan_tuda_submission_authors_seq - 1}  {
		\seq_put_right:Nn \l_tmpa_seq {
			\textbf{\coauthorname}:\space
			\seq_item:Nn \g_nyanyan_tuda_submission_authors_seq {\int_eval:n {##1 + 1}}
			\seq_if_empty:NTF \g_nyanyan_tuda_submission_matriculation_numbers_seq
			{}
			{
				\space(\seq_item:Nn \g_nyanyan_tuda_submission_matriculation_numbers_seq
				{\int_eval:n {##1 + 1}})
			}
		}
	}

	% Prepare right minipage
	\seq_clear:N \_tmpb_seq
	% Deadline

	\tl_if_empty:NTF \g_nyanyan_tuda_submission_deadline_tl
	{}
	{
		\seq_put_right:Nn \l_tmpb_seq {
			\textbf{\deadlinename}:\space
			\g_nyanyan_tuda_submission_deadline_tl
		}
	}
	% Exercise group
	\tl_if_empty:NTF \g_nyanyan_tuda_submission_exercise_group_leader_tl
	{}
	{
		\seq_put_right:Nn \l_tmpb_seq {
			\textbf{\exercisegroupleadername}:\space
			\g_nyanyan_tuda_submission_exercise_group_leader_tl
		}
	}
	%
	\tl_if_empty:NTF \g_nyanyan_tuda_submission_exercise_group_tl
	{}
	{
		\seq_put_right:Nn \l_tmpb_seq {
			\textbf{\exercisegroupname}:\space\g_nyanyan_tuda_submission_exercise_group_tl
		}
	}
	\seq_put_right:Nn \l_tmpb_seq {
		\textbf{\sheetname}:\sheetsep\two@digits{\g_ptxcd_ex_sheetnum_tl}
	}

	% Minipage for maketitle
	\begin{minipage}[t]{.475\textwidth}
		\int_step_inline:nn {\seq_count:N \l_tmpa_seq - 1}  {
			\seq_item:Nn \l_tmpa_seq {##1}\\
		}
		\seq_item:Nn \l_tmpa_seq {\seq_count:N \l_tmpa_seq}
	\end{minipage}
	\hfill
	\begin{minipage}[t]{.475\textwidth}
		\begin{flushright}
			\int_step_inline:nn {\seq_count:N \l_tmpb_seq - 1}  {
				\seq_item:Nn \l_tmpb_seq {##1}\\
			}
			\seq_item:Nn \l_tmpb_seq {\seq_count:N \l_tmpb_seq}
		\end{flushright}
	\end{minipage}
}

%--Title format--%%
\renewcommand*{\@maketitle}{%
	\global\@topnum=\z@
	\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
	\vspace*{-\dim_eval:n {
			\headheight
			-\c_ptxcd_largerule_dim -\c_ptxcd_rulesep_dim
			+\headsep
			+\ht\strutbox
			+\p@
		}}
	\par
	\nointerlineskip
	\begingroup
	\setlength{\fboxsep}{\z@}
	\bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{\parbox[t]{\linewidth}{
			\rule{0pt}{\bool_if:NTF \g_ptxcd_smalltitle_bool {.25} {.5}\c_ptxcd_logoheight_dim}
			\par\nointerlineskip
			\raisebox{-\height}{%
				\begin{minipage}[t]{\dimexpr\linewidth-2.2\c_ptxcd_logoheight_dim-1ex}
					\bool_if:NT \g_ptxcd_colorback_bool  {\begin{addmargin}{3mm}}
							\raggedright
							\bool_if:NT \g_ptxcd_colorback_bool {\color{textonaccentcolor}}
							\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
							\leavevmode\usekomafont{title}%
							{\usekomafont{title}\bool_if:NTF \g_ptxcd_smalltitle_bool {\LARGE} {\huge} {\@title\par}}%
							\vskip 1em
							\bool_if:NF \g_ptxcd_ex_compatibility_bool
							{
								{\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
								\gdef\@subtitle{}
								\vskip .5em
							}
							{}
							\vskip .5em
							\bool_if:NTF \g_ptxcd_colorback_bool {\end{addmargin}} {\par}
				\end{minipage}}
			\tl_if_empty:NF \g_ptxcd_logofile_tl {
				\hfill\raisebox{\dim_eval:n {
						\bool_if:NTF \g_ptxcd_colorback_bool
						{-\height}
						{-.9\c_ptxcd_logoheight_dim}
					}}
				[0pt]
				[\dim_eval:n {
						\bool_if:NTF \g_ptxcd_smalltitle_bool
						{\bool_if:NTF \g_ptxcd_colorback_bool {1.15}{1}}
						{\bool_if:NTF \g_ptxcd_colorback_bool {1.5}{1.3}
						}\c_ptxcd_logoheight_dim}]
				{\makebox[2.2\c_ptxcd_logoheight_dim][l]{\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}}}
			}
			\par\medskip
		}}
	\par
	\nointerlineskip
	\rule{\linewidth}{\g_ptxcd_titlerule_dim}
	% subtitle fields if not compat
	\exp_args:Nf \tl_if_empty:nF {\g_ptxcd_ex_sheetnum_tl\use:c {@subsubtitle}\@subtitle}{
		\par\nointerlineskip
		\bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{
			\parbox{\linewidth}{
				\begin{minipage}{\linewidth}
					\bool_if:NT \g_ptxcd_colorback_bool {
						\color{textonaccentcolor}
						\begin{addmargin}{3mm}
							}
							\null\par
							\def\ptxcd_nextsep{}
							\clist_map_inline:nn {@subtitle, @subsubtitle} {
								\tl_if_empty:cF {##1} {\ptxcd_nextsep\use:c {##1}\def\ptxcd_nextsep{\\}}
							}
							\@titleformat
							\bool_if:NT \g_ptxcd_colorback_bool {\end{addmargin}}
				\end{minipage}
				\vspace*{\dp\strutbox}
			}}\par\nointerlineskip
		\rule{\linewidth}{\g_ptxcd_titlerule_dim}
	}
	\par
	\bool_if:NT  \g_ptxcd_headontitle_bool {
		\if@twoside
			\box_use:N \g_ptxcd_ex_headline_odd_box
		\else
			\box_use:N \g_ptxcd_ex_headline_oneside_box
		\fi
		\par
		\rule{\linewidth}{\g_ptxcd_titlerule_dim}
		\par
	}
	\endgroup
	\vskip 2em
	\ConfigureHeadline{}
}%

%%--maketitle--%
\subtitle{\solutiontitle}

%%--HeadLine--%%
% Sheetname Sheetnumber: Solutiontitle Authors
\makeatletter
\ConfigureHeadline{
	headline={
		\sheetname\sheetsep\two@digits{\g_ptxcd_ex_sheetnum_tl}:\space\solutiontitle\space\authorsby
		\space\@author
	}
}
\makeatother
