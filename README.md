#   `l10n`—Localization support for Urbit apps.

Localization is important for apps to render front-end details correctly
for all users.  This localization library for Urbit provides string table and locale parsing services.  As currently configured, `l10n` is a library (`/lib`), not a data store (`/app`), so each client app using it must maintain its own string table.  Ultimately, having an adjacent data store (and thus a global locale and preferred fallback) is desirable.

The `l10n` library exposes two doors:

- `++le` for handling string tables; and
- `++ul` for handling various character conversions such as extended upper-case/lower-case support in Unicode.

In short, use `++le` when you need to look up a localized string:

```hoon
> (~(get le words) [%fr %$ %fr] %phrase)
'J\'ai vu quelque chose de méchant dans le bûcher.'
```

and use `++ul` when you need to manipulate such a string:

```hoon
> (cass:ul (trip 'J\'ai vu quelque chose de méchant dans le bûcher.'))
"J'Aİ VU QUELQUE CHOSE DE MÉCHANT DANS LE BÛCHER."
```


##  Locale

The locale allows the app to adaptively display strings in the appropriate language and script and to render date and time strings as preferred.  A locale consists of a language code, a script code, and a region code.

Languages are indicated by two-letter ISO 639-1 codes or three-letter
ISO 639-2 codes only if an appropriate two-letter code is not defined.

Writing systems are indicated using an optional four-letter ISO 15924
script code.  Of course all strings are represented using UTF-8, but a few
languages may be written using multiple scripts (including English:  Latin,
Shavian, Deseret; and Mongolian:  Hudum Mongol bichig, Cyrillic, ’Phags-pa). 

Regions are indicated with two-letter ISO 3166 codes.

Additional support features included with this localization library include
the associated Unicode character range for each alphabet, case pairs, and
writing direction.  These are available in parallel cores TODO.

Having combined all of these, we arrive at locale codes such as:

- `en_US` or `[%en %$ %us]` for American English written in the default
  script.
- `en_Dsrt_US` or `[%en %dsrt %us]` for American English written in the
  Deseret alphabet.
- `zh_Hant_HK` or `[%zh %hant %hk]` for Mandarin Chinese written in
  traditional Han symbols.

Many possible locale combinations are invalid or absurd.  We do not lint for these in `l10n`.

%l10n-store represents these as three-element tuples of type unions.

```hoon
+$  language  ?(iso-639-1-leys iso-639-2-keys)
+$  script    ?(iso-15924-keys)
+$  region    ?(iso-3166-keys)
+$  locale  [language script region]
```

The tricky part is that locales should “nest” inside of each other, rather
like auras.  Thus if we cannot locate `'en_Latn_GB'`, we should check first
for `'en_GB'` then `'en'`.  This means we actually search components:  we
look for language, then script, then region, and fall back on our best prior
match if we can't find a perfect match.

`l10n` has a custom search core for handling this behavior.


##  String Table

String tables can be defined at two levels:  they are formally a `(map locale (map label tape))`, so you need both a locale and a label to access a particular string.

For instance, your app may have a greeting message `%hello`, and support the languages (but not regions) `en`, `jp`, and `de`.  In that case, part of your string table would look like this:

```
├── [%en %$ %$]
│  ├── %hello
│  │   └── "Hello"
│  └── ...
├── [%jp %$ %$]
│  ├── %hello
│  │   └── "こんにちは"
│  └── ...
└── [%de %$ %$]
   ├── %hello
   │   └── "Servus"
   └── ...
```


Standard usage of the 

```hoon
(~(get le app) locale string-label)
(~(gets le app) 'en-US' string-label)
(~(put le app) locale string-label string)
(~(puts le app) 'en-US' string-label string)
```

Each client app will create its own instance.  This should be maintained in the app's state.

There are currently no standard labels, but be careful to use `@tas` `term`s and not text constants (like `%1`, which is not a `term`).

An example string table looks like this:

```hoon
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
==
```

The above string table, saved as `/app/my-app/string-table.hoon`, can be loaded and used in the Dojo:

```hoon
/+  *l10n
/*  locale-data  %hoon  /app/my-app/string-table/hoon
=/  example  (trip (need (~(getd le:l10n words) %autonym)))
...
```

Every instance requires a default locale, altho this is not checked for by `++le`.

Arms of `++le` include:

- `++parse-locale` attempts to parse a locale string into a locale.
- `++puts` adds a key-value pair by locale string (e.g. `'en-US'`)
- `++put` adds a key-value pair by locale (e.g. `[%en %$ %us]`)
- `++putd` adds a key-value pair to the default locale
- `++gets` retrieves a value by key by locale string (e.g. `'en-US'`)
- `++get` retrieves a value by key by locale (e.g. `[%en %$ %us]`)
- `++getd` retrieves a value by key by the defaule locale
- `++gett` retrieves a value by key but offers fallback down the tree by removing first script, then region
- `++hass` checks for existence of a value by key by locale string (e.g. `'en-US'`)
- `++has` checks for existence of a value by key by locale (e.g. `[%en %$ %us]`)
- `++hasd` checks for existence of a value by key by the default locale
- `++hast` checks for existence of a value by key but offers fallback down the tree by removing first script, then region
- `++dels` removes a key-value pair by locale string (e.g. `'en-US'`)
- `++del` removes a key-value pair by locale (e.g. `[%en %$ $us]`)

For instance, compare these getters:

```hoon
(~(get le words) [%en %$ %$] %autonym)
(~(getd le words) %autonym)
(~(gets le words) 'en-Dsrt-US' %autonym)
```

We recommend putting your app's string table at `/app/app-name/string-table/hoon`.  It is up to the app to change the default locale if the strings source should be overridden.

Two-letter and three-letter codes are NOT unified.  Pick a lane!

> Right now, the tree search behavior only falls back up the tree.  That is, `'en-GB'` will not fall back to `'en-US'`, only to `'en'`.  This behavior may change in the future.


##  Character Conversions

`++ul` offers `++cass` (to lower-case) and `++cuss` (to upper-case) for Unicode characters beyond ASCII:  Cyrillic, Greek, Armenian, Georgian, Deseret, Cherokee, Coptic, etc.  The core also defines and provides conversion services for `calf`, a relative of `tape` which doesn't split multi-byte UTF-8 characters into separate entries in the string, but leaves them unified as a single `@t` character.  Formally a `calf` is a `(list @t)` like a `tape`, but a `tape` enforces one byte per list entry.

- `++lasso` accepts a `tape` and yields a `calf`.
- `++brand` accepts a `calf` and yields a `tape`.

(Mnemonic:  you lasso a calf to corral it, then you brand it before you set it free.)

`++cass:ul` and `++cuss:ul` operate on a `tape`, convert to a `calf` internally, but ultimately yield a `tape` in response.  (Special positional forms that are directly encoded, like Greek terminal sigma `σ`/`ς`, are not handled by this algorithm.)

```hoon
> (cuss:ul "J'ai vu quelque chose de méchant dans le bûcher.")
"J'Aİ VU QUELQUE CHOSE DE MÉCHANT DANS LE BÛCHER."

> (cuss:ul "Ꮧꮣꮄꮒꮝꭼ Ꭷꮓꭾꮫ ꭱꭾꭲ, ꭰꮄ ꮎꮝꭹ Ꭷꮓꭾꮫ Ꭴꮑꮃꮕꭿ ꭲꮷꮃꭽ ꭰꮑꭾꭲ, ꭰꮄ ꮎꮝꭹ Ꭷꮓꭾꮫ Ꭴꮑꮃꮕꭿ ꭸꮞꭲ.")
"ᏗᏓᎴᏂᏍᎬ ᎧᏃᎮᏛ ᎡᎮᎢ, ᎠᎴ ᎾᏍᎩ ᎧᏃᎮᏛ ᎤᏁᎳᏅᎯ ᎢᏧᎳᎭ ᎠᏁᎮᎢ, ᎠᎴ ᎾᏍᎩ ᎧᏃᎮᏛ ᎤᏁᎳᏅᎯ ᎨᏎᎢ."

> (cuss:ul "𐐆𐑁 𐐷𐐭 𐐿𐐳𐐼 𐐸𐐴 𐐻𐐭 𐐗𐐬𐑊𐐪𐐺")
"𐐆𐐙 𐐏𐐅 𐐗𐐋𐐔 𐐐𐐌 𐐓𐐅 𐐗𐐄𐐢𐐂𐐒"

> (cuss:ul "Μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος")
"ΜἨΝΙΝ ἌΕΙΔΕ ΘΕᾺ ΠΗΛΗΪΆΔΕΩ ἈΧΙΛἨΟΣ"
```

##  Resources

### Locales

- [ISO 639 language codes at Wikipedia](https://en.wikipedia.org/wiki/ISO_639)
- [ISO 15924 script codes at Wikipedia](https://en.wikipedia.org/wiki/ISO_15924)
- [ISO 3166 region codes at Wikipedia](https://en.wikipedia.org/wiki/ISO_3166)
- [Locale Planet](https://www.localeplanet.com/)

### Unicode

- [UnicodePlus resource](https://unicodeplus.com/)
- [UTF-8 at Wikipedia](https://en.wikipedia.org/wiki/UTF-8)
