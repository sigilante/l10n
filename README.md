#   `l10n` Localization support for Urbit apps.

Localization is important for apps to render front-end details correctly
for all users.  For instance, knowing the locale allows the app to
adaptively display strings in the appropriate language and script and to
render date and time strings as preferred.

A locale consists of a language code, a script code, and a region code.

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

The `%$` alphabet used in the absence of any other information is presumed
to be the 26-letter Latin ASCII alphabet.

(Many combinations are invalid or absurd.  We do not lint for these.)

%l10n-store represents these as three-element tuples of type unions.

```hoon
+$  language  ?(iso-639-1-leys iso-639-2-keys)
+$  script    ?(iso-15924-keys)
+$  region    ?(iso-3166-keys)
+$  locale  [language script region]
```

We have a custom search core for handling this behavior.

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
(~(get le words) [%en %$ %$] autonym)
(~(getd le words) autonym)
(~(gets le words) 'en-Dsrt-US' autonym)
```

We recommend putting your app's string table at `/lib/l10n/string-table/hoon`.
It is up to the app to change the default locale if the strings source should be
overridden.

