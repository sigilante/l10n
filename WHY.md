#   `i18n`, `l10n`, and so forth

### Internationalization

Internationalization (_i18n_) describes designing software to have general interfaces suitable to many different languages and output needs.  Localization (_L10n_) is the reciprocal process of preparing a language- and region-specific version of a software, typically an internationalized software package.

Typical concerns of design include:

1.  data encoding
2.  data and documentation
3.  software construction
4.  hardware device support
5.  user interactions

Each of these poses special problems for the project of internationalization.

**Data Encoding**.  Although encoding has become less of a concern on modern systems due to the relative popularity of Unicode, many legacy and embedded systems retain encoding systems requiring code pages and other modifications.  Software needs to be designed to support encoding on input and output channels (if UTF-8 is used internally), or to specify encodings with strings if no transformation will be made.

**Data and Documentation**.  The availability of internal data and supporting documentation in various languages needs to be considered.  Frequently, this is accomplished by the use of resource string tables (discussed in the next module).  However, other local considerations like variable paper sizes; analog encoding conventions; formats for telephone numbers, currency, and address; and  should all be considered.  It's a good idea to not hard-code formats in general:  load them from a configuration file.

**Software Construction**.  The software should be designed modularly so that localized components of libraries or resources can be loaded.

**Hardward Device Support**.  Many languages have their own keyboards or ten-keys for input.  (Chinese, for instance, can use a ten-key to input Chinese characters.)  Also consider whether a user is inputting with a ten-key style keypad or a telephone-style keypad, which are $y$-flipped relative to each other.

![](https://upload.wikimedia.org/wikipedia/commons/a/ac/Albanian_keyboard_layout.jpg)

**User Interactions**.  Interfaces need to be adaptive to many format requirements:  number of digits in a phone number or the particular fields of an address.  Data validation needs to be flexible.


### Localization

There are more than 5,000 languages spoken in the world today, and several hundred have had elements implemented for computer use.  Many writing systems and modes of expression have to be accommodated in order for localization to be possible to target markets.

What issues can arise in localization?  At a minimum, the following must be kept in mind (Hall1996):

1.  Writing direction.
    1.  Left-to-right:  most European languages and languages recorded by linguists.
    2.  Right-to-left:  Arabic, Hebrew.
    3.  Vertical top-to-bottom:  Chinese, Japanese.
    4.  Vertical bottom-to-top:  Ogham
    5.  Boustrophedonic (alternating left-to-right and right-to-left):  Ancient Greek, Ancient Hungarian.
    6.  Variable:  Egyptian hieroglyphs.
2.  Letterform accommodation.
    1.  Ligatures:  ash æ, Eszett ß, ligature ﬆ, etc.  Consider cursive abjads like Arabic.
    2.  Variant forms:   epsilons ε, ϵ; sometimes these carry semantic content as in mathematical expressions.
    3.  Context-based forms:  sigma σ in running text, sigma ς in word-final position.
3.  Changes in string size.
    1.  Wrapping and scrolling.  Text in one language may not trigger a scroll bar in a dialog, while in another language it is necessary.
    2.  Accessibility and word-order.
4.  Keyboard shortcuts.
5.  Multi-byte characters.  Typically this is handled by an OS or low-level library, but lookup times can be affected, for instance by the variable-byte UTF-8.

Machine translation is frequently used for translating software packages, with human translators working through everything in a second pass to ensure consistency and good expression.  Translation is discussed in more detail in the next module.


### Locales

Many writing schemes exist:  alphabets, abjads, scripts, ideograms, etc.  Aside from encoding and translation issues, the common way to internationalize software is to utilize _resource string tables_, or libraries of values you can look up and swap out as necessary.  Resources are organized by locales, which consist of language codes and country codes.

Languages are designated by two- or three-digit language codes.  Two-digit language codes, specified by [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes), are preferred for modern languages.

| Language | Code | Language | Code | Language | Code |
| -------- | ---- | -------- | ---- | -------- | ---- |
| Afrikaans | af | Basque | eu | Catalan | ca |
| Chinese | zh | Danish | da | French | fr |
| Gaelic | gd | Gujarati | gu | Hindi | hi |
| Latin | la | Latvian | lv | Persian | fa |
| Russian | ru | Tamil | ta | | |

Three-digit codes ([ISO 639-2](https://en.wikipedia.org/wiki/List_of_ISO_639-2_codes)) support many ancient, extinct, and constructed languages as well, and find utility in classics, linguistics, anthropology, and humanities:

| Language | Code | Type | Language | Code | Type |
| -------- | ---- | ---- | -------- | ---- | ---- |
| Ainu | ain | Living | Akkadian | akk | Ancient |
| Old English (ca. 450–1100) | ang | Historical | Apache languages | apa |  |
| Arabic | ara | Living | Aramaic | arc |  Ancient |
| Aragonese | arg | Living | Arapaho | arp | Living |
| Artificial languages | art | Constructed | | | |

Language codes are used to identify the target usage of a localized resource.  They are frequently paired with country codes ([ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1)) to indicate the locale.

| Language | Country | Locale |
| -------- | ------- | ------ |
| English  | U.S.A.  | en-US  |
| Russian  | Russia  | ru-RU  |
| Danish   | Denmark | da-DK  |
| Chinese (Mandarin) | P.R. of China | zh-CN |
| Chinese (Mandarin) | Taiwan | zh-TW |


### Translation for Localization

In contemporary practice, software projects use resource string tables to support localization.  Each supported locale is included as a file or series of files with the equivalent strings stored in standard locations or hashed for ease of access.  Aspects like word order may need to be considered separately, or the granularity of translation may need to occur at the sentence rather than word or phrase level.

For instance, the [Common Language Data Repository](http://cldr.unicode.org/) seeks to provide basic translations of language and locale names into many different languages.  Although the core data are available in XML files, you can see the sorts of data translated in these standard resource string tables:

-   [Cherokee, ᏣᎳᎩ](https://unicode.org/cldr/charts/34/summary/chr.html)
-   [Irish Gaelic, _Gaeilge_](https://unicode.org/cldr/charts/34/summary/ga.html).
-   [Russian, русский](https://unicode.org/cldr/charts/34/summary/ru.html)

Besides CLDR, other open-source services exist to provide standard resource string tables:

-   [Citation Style Language](https://citationstyles.org/)

Many projects have localization backends in place:

-   [Flow Framework](https://flowframework.readthedocs.io/en/stable/TheDefinitiveGuide/PartIII/Internationalization.html)
-   [OpenProject](https://github.com/opf/openproject-translations)

Translation microservices exist, such as [Transifex](https://www.transifex.com/) and [Google Translate](https://translate.google.com/), which can translate strings either up-front or on-the-fly.  Services like [Crowdin](https://crowdin.com/)


### References

-   [i18n libraries](http://www.unicode.org/resources/libraries.html)
-   [CLDR](http://cldr.unicode.org/) [slides](https://docs.google.com/presentation/d/1LDXP-LYQpaVJRWWX6EejgkRGFUaFwo83t8Ly-IPll8Y/edit#slide=id.g3da8a9004_2_100)
