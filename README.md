#   `l10n`—Localization support for Urbit apps.

Localization is important for apps to render front-end details correctly
for all users.  This localization library for Urbit provides string table and locale parsing services.  It is a library (`/lib`), not a data store (`/app`), so each client app using it must maintain its own string table.

The `l10n` library exposes two doors:

- `++le` for handling string tables; and
- `++ul` for handling various character conversions such as extended upper-case/lower-case support in Unicode.


##  Locales

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

We have a custom search core for handling this behavior.

##  String Tables

String tables can be defined at two levels:  they are formally a `(map locale (map label tape))`, so you need both a locale and a label to access a particular string.

For instance, your app may have a greeting message `%hello`, and support the languages (but not regions) `en`, `jp`, and `de`.  In that case, part of your string table would look like this:

├── app
│   ├── l10n-store.hoon
│   └── my-app
├── casepairs.csv


```
├── [%en %$ %$]
│  ├── %hello
│  │   ├── "Hello"
│  └── ...
├── [%jp %$ %$]
│  ├── %hello
│  │   ├── "こんにちは"
│  └── ...
└── [%de %$ %$]
   ├── %hello
   │   ├── "Hallo"
   └── ...
```


Standard usage of the 

```hoon
(~(get le app) locale string-label)
(~(gets le app) 'en-US' string-label)
(~(put le app) locale string-label string)
(~(puts le app) 'en-US' string-label string)
```

Each client app will create its own instance:

```hoon
/+  *l10n
/*  locale-data  %hoon  /app/my-app/string-table/hoon
=/  words  (parse-strings:le locale-data)
```

  (~(get le words) [%en %$ %$] %autonym)
  (~(getd le words) %autonym)
  (~(gets le words) 'en-Dsrt-US' %autonym)

We recommend putting your app's string table at `/lib/app-name/strings/hoon`.  It is up to the app to change the default locale if the strings source should be overridden.

Two-letter and three-letter codes are NOT unified.  Pick a lane!


##  Character Conversions

`++ul` offers `++cass` (to lower-case) and `++cuss` (to upper-case) for Unicode characters beyond ASCII:  Cyrillic, Greek, Armenian, Georgian, Deseret, Cherokee, Coptic, etc.  The core also defines and provides conversion services for `calf`, a relative of `tape` which doesn't split multi-byte UTF-8 characters into separate entries in the string, but leaves them unified as a single `@t` character.

- `++lasso` accepts a `tape` and yields a `calf`.
- `++brand` accepts a `calf` and yields a `tape`.

`++cass:ul` and `++cuss:ul` operate on a `tape`, convert to a `calf` internally, but ultimately yield a `tape` in response.  (Special positional forms that are directly encoded, like Greek terminal sigma `σ`/`ς`, are not handled by this algorithm.)

```hoon
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
