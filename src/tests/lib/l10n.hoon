/+  *test, *l10n
|%
::  Test parsers for locale.
++  test-locale
  ;:  weld
  %+  expect-eq
    !>  `locale`[%en %$ %$]
    !>  (parse-locale:le 'en')
  %+  expect-eq
    !>  `locale`[%eng %$ %$]
    !>  (parse-locale:le 'eng')
  %+  expect-eq
    !>  `locale`[%en %$ %us]
    !>  (parse-locale:le 'en-US')
  %+  expect-eq
    !>  `locale`[%eng %$ %us]
    !>  (parse-locale:le 'eng-US')
  %+  expect-eq
    !>  `locale`[%en %dsrt %us]
    !>  (parse-locale:le 'en-Dsrt-US')
  %+  expect-eq
    !>  `locale`[%eng %dsrt %us]
    !>  (parse-locale:le 'eng-Dsrt-US')
  %+  expect-eq
    !>  `locale`[%en %$ %us]
    !>  (parse-locale:le 'en_US')
  %+  expect-eq
    !>  `locale`[%eng %$ %us]
    !>  (parse-locale:le 'eng_US')
  %+  expect-eq
    !>  `locale`[%en %dsrt %us]
    !>  (parse-locale:le 'en_Dsrt_US')
  %+  expect-eq
    !>  `locale`[%eng %dsrt %us]
    !>  (parse-locale:le 'eng_Dsrt_US')
  %+  expect-eq
    !>  `locale`[%en %latn %$]
    !>  (parse-locale:le 'en_Latn')
  %+  expect-eq
    !>  `locale`[%eng %latn %$]
    !>  (parse-locale:le 'eng_Latn')
  %-  expect-fail
    |.  (parse-locale:le 'English')
  ==
::  Test map operations (for griffe).
++  test-griffe
  ;:  weld
  ::  Latin alphabet
  %+  expect-eq
    !>  (malt `(list (pair @tas @t))`~[[%autonym 'English']])
    !>  (~(put by *griffe) %autonym 'English')
  ==
++  test-phrases
  =/  words  (~(put le [%en %$ %$] *(map locale griffe)) `locale`[%en %latn %gb] %phrase 'I saw something nasty in the woodshed.')
  =/  words  (~(put le words) `locale`[%fr %latn %fr] %phrase 'J\'ai vu quelque chose de méchant dans le bûcher.')
  =/  words  (~(put le words) `locale`[%de %latn %de] %phrase 'Ich habe etwas Ekelhaftes im Holzschuppen gesehen.')
  =/  words  (~(put le words) `locale`[%en %dsrt %us] %phrase '𐐌 𐑅𐐫 𐑅𐐲𐑋𐑃𐐮𐑍 𐑌𐐰𐑅𐐻𐐨 𐐮𐑌 𐑄 𐐶𐐳𐐼𐑇𐐯𐐼.')
  =/  words  (~(put le words) `locale`[%ja %jpan %jp] %phrase '森の小屋で何か厄介なものを見ました。.')
  ;:  weld
  %+  expect-eq
    !>  :-  [%en %$ %$]
        %-  malt
        ^-  (list (pair @tas @t))
        :~  [%autonym 'English']  ==
    !>  words
  ==
++  test-cases
  ::  First line of a Mormon hymn, in Deseret alphabet
  =/  p-0  "𐐆𐑁 𐐷𐐭 𐐿𐐳𐐼 𐐸𐐴 𐐻𐐭 𐐗𐐬𐑊𐐪𐐺"
  =/  l-0  "𐐮𐑁 𐐷𐐭 𐐿𐐳𐐼 𐐸𐐴 𐐻𐐭 𐐿𐐬𐑊𐐪𐐺"
  =/  u-0  "𐐆𐐙 𐐏𐐅 𐐗𐐋𐐔 𐐐𐐌 𐐓𐐅 𐐗𐐄𐐢𐐂𐐒"
  ::  First line of the Gospel of John, in Cherokee alphabet
  =/  p-1  "Ꮧꮣꮄꮒꮝꭼ Ꭷꮓꭾꮫ ꭱꭾꭲ, ꭰꮄ ꮎꮝꭹ Ꭷꮓꭾꮫ Ꭴꮑꮃꮕꭿ ꭲꮷꮃꭽ ꭰꮑꭾꭲ, ꭰꮄ ꮎꮝꭹ Ꭷꮓꭾꮫ Ꭴꮑꮃꮕꭿ ꭸꮞꭲ."
  =/  l-1  "ꮧꮣꮄꮒꮝꭼ ꭷꮓꭾꮫ ꭱꭾꭲ, ꭰꮄ ꮎꮝꭹ ꭷꮓꭾꮫ ꭴꮑꮃꮕꭿ ꭲꮷꮃꭽ ꭰꮑꭾꭲ, ꭰꮄ ꮎꮝꭹ ꭷꮓꭾꮫ ꭴꮑꮃꮕꭿ ꭸꮞꭲ."
  =/  u-1  "ᏗᏓᎴᏂᏍᎬ ᎧᏃᎮᏛ ᎡᎮᎢ, ᎠᎴ ᎾᏍᎩ ᎧᏃᎮᏛ ᎤᏁᎳᏅᎯ ᎢᏧᎳᎭ ᎠᏁᎮᎢ, ᎠᎴ ᎾᏍᎩ ᎧᏃᎮᏛ ᎤᏁᎳᏅᎯ ᎨᏎᎢ."
  ::  First line of the Iliad, in Greek
  =/  p-2  "Μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος"
  =/  a-2  "Μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆοσ"
  =/  l-2  "μῆνιν ἄειδε θεὰ πηληϊάδεω ἀχιλῆοσ"
  =/  m-2  "μῆνιν ἄειδε θεὰ πηληϊάδεω ἀχιλῆος"
  ::  Note that terminal σ/ς must be handled directly in many cases
  =/  u-2  "ΜἨΝΙΝ ἌΕΙΔΕ ΘΕᾺ ΠΗΛΗΪΆΔΕΩ ἈΧΙΛἨΟΣ"
  ;:  weld
  ::  To lower.
  %+  expect-eq
    !>  l-0
    !>  (cass:ul p-0)
  %+  expect-eq
    !>  l-0
    !>  (cass:ul u-0)
  %+  expect-eq
    !>  l-1
    !>  (cass:ul p-1)
  %+  expect-eq
    !>  l-1
    !>  (cass:ul u-1)
  ::  These are complicated because terminal sigma is encoded directly.
  %+  expect-eq
    !>  m-2
    !>  (cass:ul p-2)
  %+  expect-eq
    !>  l-2
    !>  (cass:ul a-2)
  ::  To upper.
  %+  expect-eq
    !>  u-0
    !>  (cuss:ul p-0)
  %+  expect-eq
    !>  u-0
    !>  (cuss:ul l-0)
  %+  expect-eq
    !>  u-1
    !>  (cuss:ul p-1)
  %+  expect-eq
    !>  u-1
    !>  (cuss:ul l-1)
  %+  expect-eq
    !>  u-2
    !>  (cuss:ul p-2)
  %+  expect-eq
    !>  u-2
    !>  (cuss:ul l-2)
  ==


--
