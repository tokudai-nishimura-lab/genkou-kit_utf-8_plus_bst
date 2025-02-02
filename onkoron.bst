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

INTEGERS { output.state before.all mid.sentence after.sentence 
          nameptr namesleft numnames is_roman_name }

STRINGS { s t }

FUNCTION {init.state.consts}
{
  #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
}

FUNCTION {output.nonnull}
{ 's :=
  s #1 #5 substring$ "\\url{" =
    { s write$ }
    { s }
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

FUNCTION {print.bibliography.start}
{ "\begin{thebibliography}{99}" write$
  newline$
  "\itemsep -0.5em" write$
  newline$
}

FUNCTION {print.bibliography.end}
{ newline$
  "\end{thebibliography}" write$
  newline$
}

FUNCTION {check.first.char}
{ 
  #1 #1 substring$
  duplicate$ "A" >= swap$ "z" <= and
}

FUNCTION {format.names}
{ 's :=
  s #1 "{ff }{ll}" format.name$ check.first.char
  'is_roman_name :=
  
  s num.names$ 'numnames :=
  numnames #3 <
    { s #1 "{ll}" format.name$ write$
      numnames #2 =
        { is_roman_name
            { ", " }
            { "，" }
          if$ write$
          s #2 "{ll}" format.name$ write$
        }
        'skip$
      if$
    }
    { s #1 "{ll}" format.name$ write$
      is_roman_name
        { " et al." }
        { " 他" }
      if$ write$
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
        { "，編" * }
        { "，編" * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { is_roman_name
        { """" title * """" * }
        { """" title * """" * }
      if$
    }
}

FUNCTION {format.journal}
{ journal empty$
    { "" }
    { journal }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages }
  if$
}

FUNCTION {article}
{ output.bibitem
  format.authors
  is_roman_name
    { ", " }
    { "，" }
  if$ write$
  journal empty$
    'skip$
    { format.journal write$ }
  if$
  volume empty$
    'skip$
    { is_roman_name
        { ", " }
        { "，" }
      if$ write$
      volume write$
    }
  if$
  number empty$
    'skip$
    { "(" write$
      number write$
      ")" write$
    }
  if$
  pages empty$
    'skip$
    { is_roman_name
        { ", " }
        { "，" }
      if$ write$
      format.pages write$
    }
  if$
  year empty$
    'skip$
    { is_roman_name
        { ", " }
        { "，" }
      if$ write$
      year write$
    }
  if$
  is_roman_name
    { "." }
    { "．" }
  if$ write$
  newline$
}

FUNCTION {inproceedings}
{ article }

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors }
    { format.authors }
  if$
  is_roman_name
    { ", " }
    { "，" }
  if$ write$
  title empty$
    'skip$
    { format.title write$ }
  if$
  "，" write$
  publisher empty$
    'skip$
    { publisher write$ }
  if$
  year empty$
    'skip$
    { is_roman_name
        { ", " }
        { "，" }
      if$ write$
      year write$
    }
  if$
  is_roman_name
    { "." }
    { "．" }
  if$ write$
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

FUNCTION {default.type} { misc }

READ

FUNCTION {set.entry.count}
{ #0 'entry.count := }

EXECUTE {print.bibliography.start}
EXECUTE {set.entry.count}
ITERATE {call.type$}
EXECUTE {print.bibliography.end}