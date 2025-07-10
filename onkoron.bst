% onkoron_v2.bst - 日本音響学会研究発表会用 BibTeX スタイルファイル
% Version 2.0 (2025-01-10)
% Enhanced version with additional entry types
% Compliant with ASJ formatting requirements

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    volume
    year
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence nameptr namesleft numnames }

STRINGS { s t }

FUNCTION {init.state.consts}
{
  #0 'before.all :=
  #1 'mid.sentence :=
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  before.all 'output.state :=
}

FUNCTION {is.kanji.str}
{ duplicate$ empty$
    { pop$ #0 }
    { duplicate$ #1 #2 substring$ 
      duplicate$ chr.to.int$ #128 >
      swap$ pop$
    }
  if$
}

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  "" 't :=
  
  s #1 "{ll}" format.name$ is.kanji.str$
    { % 日本語の著者の処理
      numnames #2 >
        { s #1 "{ff}{ll}" format.name$ "~他" * 't := }
        { s #1 "{ff}{ll}" format.name$ 't :=
          numnames #2 =
            { t "，" * s #2 "{ff}{ll}" format.name$ * 't := }
            'skip$
          if$
        }
      if$
    }
    { % 欧文著者の処理
      numnames #2 >
        { s #1 "{ll}" format.name$ " et al." * 't := }
        { s #1 "{ll}" format.name$ 't :=
          numnames #2 =
            { t " and " * s #2 "{ll}" format.name$ * 't := }
            'skip$
          if$
        }
      if$
    }
  if$
  t
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor #1 "{ll}" format.name$ is.kanji.str$
        { "編" * }
        { editor num.names$ #1 >
            { ", eds." * }
            { ", ed." * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages }
  if$
}

FUNCTION {write.comma}
{ "，" write$ }

FUNCTION {write.period}
{ "．" write$ }

FUNCTION {article}
{ output.bibitem
  format.authors empty$
    'skip$
    { format.authors write$ write.comma }
  if$
  journal empty$
    'skip$
    { journal write$ }
  if$
  volume empty$
    'skip$
    { write.comma volume write$ }
  if$
  number empty$
    'skip$
    { " (" write$ number write$ ")" write$ }
  if$
  pages empty$
    'skip$
    { write.comma pages write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  write.period
  newline$
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors empty$
        'skip$
        { format.editors write$ write.comma }
      if$
    }
    { format.authors write$ write.comma }
  if$
  title empty$
    'skip$
    { "``" write$ title write$ "''" write$ write.comma }
  if$
  publisher empty$
    'skip$
    { publisher write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  write.period
  newline$
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors empty$
    'skip$
    { format.authors write$ write.comma }
  if$
  booktitle empty$
    'skip$
    { booktitle write$ }
  if$
  pages empty$
    'skip$
    { write.comma pages write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  write.period
  newline$
}

FUNCTION {incollection}
{ output.bibitem
  format.authors empty$
    'skip$
    { format.authors write$ write.comma }
  if$
  title empty$
    'skip$
    { "``" write$ title write$ "''" write$ write.comma }
  if$
  booktitle empty$
    'skip$
    { booktitle write$ }
  if$
  format.editors empty$
    'skip$
    { write.comma format.editors write$ }
  if$
  chapter empty$
    'skip$
    { write.comma "第" write$ chapter write$ "章" write$ }
  if$
  pages empty$
    'skip$
    { write.comma pages write$ }
  if$
  publisher empty$
    'skip$
    { write.comma publisher write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  write.period
  newline$
}

FUNCTION {techreport}
{ output.bibitem
  format.authors empty$
    'skip$
    { format.authors write$ write.comma }
  if$
  title empty$
    'skip$
    { title write$ write.comma }
  if$
  type empty$
    { "Technical Report" write$ }
    { type write$ }
  if$
  number empty$
    'skip$
    { " " write$ number write$ }
  if$
  write.comma
  institution empty$
    'skip$
    { institution write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  write.period
  newline$
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors empty$
    'skip$
    { format.authors write$ write.comma }
  if$
  title empty$
    'skip$
    { title write$ write.comma }
  if$
  "博士論文" write$ write.comma
  school empty$
    'skip$
    { school write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  write.period
  newline$
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors empty$
    'skip$
    { format.authors write$ write.comma }
  if$
  title empty$
    'skip$
    { title write$ write.comma }
  if$
  "修士論文" write$ write.comma
  school empty$
    'skip$
    { school write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  write.period
  newline$
}

FUNCTION {misc}
{ output.bibitem
  format.authors empty$
    'skip$
    { format.authors write$ write.comma }
  if$
  title empty$
    'skip$
    { title write$ write.comma }
  if$
  howpublished empty$
    { url empty$
        'skip$
        { url write$ }
      if$
    }
    { howpublished write$ }
  if$
  year empty$
    'skip$
    { write.comma year write$ }
  if$
  note empty$
    'skip$
    { write.comma note write$ }
  if$
  newline$
}

FUNCTION {conference} { inproceedings }
FUNCTION {default.type} { misc }

READ

STRINGS { longest.label }
INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{" longest.label * "}" * write$ newline$
  "\setlength{\itemsep}{-1pt}" write$ newline$
  "\setlength{\parsep}{-2pt}" write$ newline$
  "\setlength{\baselineskip}{10pt}" write$ newline$
}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
EXECUTE {end.bib}