  :: string-table.hoon
:::: App localization string table demo.
::
/+  *l10n
::  Default locale
:-  `locale`[%en %$ %$]
^-  (map locale griffe)
::  String table
%-  malt
^-  (list (pair locale griffe))
:~
::  English
:-  `locale`[%en %$ %$]
%-  griffe
%-  malt
^-  (list (pair label @t))
:~  :-  %autonym      'English'
    :-  %welcome      'Hello'
    :-  %goodbye      'Goodbye'
    :-  %warning      'Warning'
    :-  %error        'Error'
    :-  %success      'Success'
    :-  %man          'man'
    :-  %woman        'woman'
    :-  %number-1     'one'
    :-  %number-2     'two'
    :-  %number-3     'three'
    :-  %number-4     'four'
    :-  %number-5     'five'
    :-  %number-6     'six'
    :-  %number-7     'seven'
    :-  %number-8     'eight'
    :-  %number-9     'nine'
    :-  %number-10    'ten'
==
::  English in Deseret alphabet
:-  `locale`[%en %dsrt %$]
%-  griffe
%-  malt
^-  (list (pair label @t))
:~  :-  %autonym      '𐐆𐑍𐑀𐑊𐐮𐑇'
    :-  %welcome      '𐐐𐐲𐑊𐐬'
    :-  %goodbye      '𐐘𐐳𐐼𐐺𐐴'
    :-  %warning      '𐐎𐐫𐑉𐑌𐐮𐑍'
    :-  %error        '𐐇𐑉𐐲𐑉'
    :-  %success      '𐐝𐐲𐐿𐑅𐐯𐑅'
    :-  %man          '𐐣𐐰𐑌'
    :-  %woman        '𐐎𐐳𐑋𐐲𐑌'
    :-  %number-1     '𐐎𐐲𐑌'
    :-  %number-2     '𐐓𐐭'
    :-  %number-3     '𐐛𐑉𐐨'
    :-  %number-4     '𐐙𐐫𐑉'
    :-  %number-5     '𐐙𐐴𐑂'
    :-  %number-6     '𐐝𐐮𐐿𐑅'
    :-  %number-7     '𐐝𐐯𐑂𐐲𐑌'
    :-  %number-8     '𐐁𐐻'
    :-  %number-9     '𐐤𐐴𐑌'
    :-  %number-10    '𐐓𐐯𐑌'
==
::  Proto-Indo-European
:-  `locale`[%pie %$ %$]
%-  griffe
%-  malt
^-  (list (pair label @t))
:~  :-  %welcome      '*gʷem-'
    :-  %goodbye      '*h₁ei-'
    :-  %warning      '*bʰegʷ-'
    :-  %error        '*-'
    :-  %success      '*bʰed-'
    :-  %man          '*H₂ner-'
    :-  %woman        '*gʷén-eH₂-'
    :-  %number-1     '*óynos'
    :-  %number-2     '*dwóh₁'
    :-  %number-3     '*tréyes'
    :-  %number-4     '*kʷetwóres'
    :-  %number-5     '*pénkʷe'
    :-  %number-6     '*séḱs'
    :-  %number-7     '*septḿ̥'
    :-  %number-8     '*oḱtṓ'
    :-  %number-9     '*h₁néwn̥'
    :-  %number-10    '*déḱm̥'
==
::  Hopi
:-  `locale`[%hop %$ %$]
%-  griffe
%-  malt
^-  (list (pair label @t))
:~  :-  %welcome      'pay lolma'
    :-  %goodbye      'pay yuk pölö'
    :-  %warning      'um paasni'
    :-  %error        'qa\'àntipu'
    :-  %success      'pö\'àaqa'
    :-  %man          'taaqa'
    :-  %woman        'wùuti'
    :-  %number-1     'suukya\''
    :-  %number-2     'lööyö\''
    :-  %number-3     'pàayo\''
    :-  %number-4     'naalöyöm\''
    :-  %number-5     'tsivot'
    :-  %number-6     'navay'
    :-  %number-7     'tsange’'
    :-  %number-8     'nanalt'
    :-  %number-9     'pevt'
    :-  %number-10    'pakwt'
==
::  Hittite
:-  `locale`[%hit %xsux %$]
%-  griffe
%-  malt
^-  (list (pair label @t))
:~  :-  %autonym      '𒌷𒉌𒅆𒇷'
    :-  %welcome      ''
    :-  %goodbye      ''
    :-  %warning      ''
    :-  %error        ''
    :-  %success      ''
    :-  %man          '𒁉𒌍𒈾𒀸'
    :-  %woman        '*kuwanz'
    :-  %number-1     '*ās\''
    :-  %number-2     'dān'
    :-  %number-3     'tēries\''
    :-  %number-4     'meyawes\''
    :-  %number-5     ''
    :-  %number-6     ''
    :-  %number-7     ''
    :-  %number-8     ''
    :-  %number-9     ''
    :-  %number-10    ''
==
==
