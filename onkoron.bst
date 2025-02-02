ENTRY
  { address
    author
    title
    journal
    booktitle
    volume
    number
    pages
    year
    publisher
    howpublished
    note
    editor
    key
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence nameptr namesleft numnames }

STRINGS { s t }

FUNCTION {init.state.consts}
{
  #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
}

FUNCTION {output.nonnull}
{ 's :=
  s write$
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ write$
  newline$
}

FUNCTION {is.kanji.str}
{ duplicate$ #1 #2 substring$ 
  duplicate$ chr.to.int$ #128 >
  swap$ pop$
}

FUNCTION {format.name}
{ 's :=
  s #1 "{ll}" format.name$
}

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  
  s #1 "{ll}" format.name$ is.kanji.str$
    { % 日本語の著者の処理
      numnames #3 <
        { s #1 "{ll}" format.name$ write$
          numnames #2 =
            { "，" write$
              s #2 "{ll}" format.name$ write$
            }
            'skip$
          if$
        }
        { s #1 "{ll}" format.name$ write$
          "~他" write$
        }
      if$
    }
    { % 欧文著者の処理
      numnames #3 <
        { s #1 "{ll}" format.name$ write$
          numnames #2 =
            { " and " write$
              s #2 "{ll}" format.name$ write$
            }
            'skip$
          if$
        }
        { s #1 "{ll}" format.name$ write$
          " \textit{et al.}" write$
        }
      if$
    }
  if$
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
      editor num.names$ #1 >
        { ", eds." * }
        { ", ed." * }
      if$
    }
  if$
}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{99}" write$ newline$
  "\setlength{\itemsep}{-1pt}" write$ newline$
  "\setlength{\parsep}{-2pt}" write$ newline$
  "\setlength{\baselineskip}{10pt}" write$ newline$
}

FUNCTION {article}
{ output.bibitem
  author empty$
    'skip$
    { format.authors "，" write$ }
  if$
  journal write$
  volume empty$
    'skip$
    { "，" write$
      volume write$ }
  if$
  number empty$
    'skip$
    { " (" write$
      number write$
      ")" write$ }
  if$
  pages empty$
    'skip$
    { "，" write$
      pages write$ }
  if$
  year empty$
    'skip$
    { "，" write$
      year write$ }
  if$
  "．" write$
  newline$
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { editor empty$
        'skip$
        { format.editors "，" write$ }
      if$
    }
    { format.authors "，" write$ }
  if$
  title write$
  "，" write$
  publisher write$
  year empty$
    'skip$
    { "，" write$
      year write$ }
  if$
  "．" write$
  newline$
}

FUNCTION {inproceedings}
{ output.bibitem
  author empty$
    'skip$
    { format.authors "，" write$ }
  if$
  booktitle write$
  pages empty$
    'skip$
    { "，" write$
      pages write$ }
  if$
  year empty$
    'skip$
    { "，" write$
      year write$ }
  if$
  "．" write$
  newline$
}

FUNCTION {misc}
{ output.bibitem
  howpublished empty$
    'skip$
    { howpublished write$ }
  if$
  note empty$
    'skip$
    { note write$ }
  if$
  newline$
}

FUNCTION {conference} { inproceedings }
FUNCTION {default.type} { misc }

READ

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}