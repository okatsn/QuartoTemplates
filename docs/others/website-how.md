# How this website be built

See https://quarto.org/docs/websites/

## Create 

[Quick Start](https://quarto.org/docs/websites/#quick-start)


## Render

### Render the website on local

```
cd docs
quarto render --cache-refresh
```

See also:

- `.vscode/settings.json` for `livePreview` settings
- https://quarto.org/docs/websites/#config-file for setting up `_quarto.yml`
- https://quarto.org/docs/websites/website-tools.html for Website tools
- https://github.com/quarto-dev/quarto-web for the source code of how Quarto's official website be built


## Publish

Referring: https://quarto.org/docs/publishing/github-pages.html#publish-action


### Publish on command

In bash, 

```
cd docs
quarto publish gh-pages
```

- This creates a new branch `gh-pages`, render files and publish them to e.g., https://okatsn.github.io/QuartoTemplates/
- Noted that you have to go to the Github Settings => Pages => Deploy from a branch and Save.

### Publish via Github workflows

See `.github/workflows/deploy.yml`.