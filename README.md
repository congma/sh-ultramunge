[![pipeline status](https://gitlab.com/congma/sh-ultramunge/badges/master/pipeline.svg)](https://gitlab.com/congma/sh-ultramunge/commits/master)
[![coverage report](https://gitlab.com/congma/sh-ultramunge/badges/master/coverage.svg)](https://gitlab.com/congma/sh-ultramunge/commits/master)

`ultramunge`: POSIX shell function to manipulate `PATH`-like variables 
idempotently.

---

## Description ##

The source file `sh-ultramunge.sh` provides a function `ultramunge` that does 
one thing and hopefully does it well: to add an element to a `PATH`-like, 
colon-separated sequence of path prefixes in an idempotent manner, refraining 
from doing anything if the element is already present in the sequence.

It can be used to manipulate the `PATH` environment variable, or other 
variables following its convention.

You *MUST* read the section "[Security](#security)" before using the function.


## Installation ##

Do not install.  The script is meant to be sourced by your own shell program.

```bash
. sh-ultramunge.sh
```

After sourcing the script, a function `ultramunge` is then available.


## Usage ##

The function `ultramunge` manipulates a `PATH`-like variable.

```
ultramunge element variable_name [after]
```

The effect is to add `element` to the variable `variable_name` from the head 
(default), or from the tail (if the string `after` appears as the 3rd 
argument), if `element` is not already present in the variable.  If `element` 
is already present (no matter its location in the sequence), do nothing.


### Examples ###

```bash
PATH=/sbin:/bin:/usr/bin
ultramunge /usr/local/bin PATH after
```

The resulting `PATH` variable has the value 
`/sbin:/bin:/usr/bin:/usr/loca/bin`.

---

```bash
ultramunge "$HOME/perl5/lib/perl5" PERL5LIB
```

The expansion result of `"$HOME/perl5/lib/perl5"` is added to the variable 
`PERL5LIB` from the head.


## Security ##

To manipulate the variable referred to by the name `variable_name`, a level of 
indirection is necessary.  Due to the limitation of the POSIX shell, `eval` is 
used.  In order to mitigate the possible damage that can be done by executing 
arbitrary code in `eval` statements (a vulnerability known as [code 
injection][codeinj]), the following limitation is imposed, namely:

*  The name `variable_name` must conform to the [POSIX standard][og] for
   environment variables in shell:

> Environment variable names used by the utilities in the Shell and 
> Utilities volume of POSIX.1-2017 consist solely of uppercase letters, 
> digits, and the `<underscore>` ( '`_`' ) from the characters defined in 
> Portable Character Set and do not begin with a digit.

If the limitation is not satisfied, the function will return with status `1`, 
and no variable manipulation is performed.

You *MUST* use the function with caution, and never use it when you cannot 
control the content of the element or the value of the variable being 
manipulated.

You should consider `unset`ting the `ultramunge` function after you are done 
with using it.


## Notes ##

The name "ultramunge" is derived from an internal shell function "`pathmunge`" 
found on Red Hat, CentOS, or Fedora systems during shell setup.  Compared with 
`pathmunge`, the major difference is that it munges on any `PATH`-like 
variable.

The function relies on external commands like `grep`, in the Unix fashion.  In 
particular, `base64` is used in order to prevent code-injection attack.

It is intended for use in POSIX shell scripts, but should be compatible with 
Bash as well.


[codeinj]: https://en.wikipedia.org/wiki/Code_injection "Wikipedia page for code injection"
[og]: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08_01 "The Open Group Base Specifications Issue 7, 2018 edition, Sec. 8.1"


<!--
vim: ft=markdown tw=78 fo+=tqwn spell spelllang=en et ts=4
-->
