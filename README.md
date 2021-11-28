# TeX Templates

- Contains a collection of custom TeX related templates, such as classes and packages.

## Usage

In order to use the classes and packages, they must exist on the TeX path `$TEXMFHOME` (which
is `~/texmf` by default).

> This is usually `~/texmf/tex/latex`.

The TeX path can be found with the following command:

```
kpsewhich -var-value=TEXMFHOME
```

The script `texmf.sh` can be used to move this directory (`~/tex-templates`) to the TeX path and
refreshes the TeX Database.
