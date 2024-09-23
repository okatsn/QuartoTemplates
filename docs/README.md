# README

Referring: https://quarto.org/docs/publishing/github-pages.html#publish-action


## Publish on command

In bash, 

```
cd docs
quarto publish gh-pages
```

- This creates a new branch `gh-pages`, render files and publish them to e.g., https://okatsn.github.io/QuartoTemplates/
- Noted that you have to go to the Github Settings => Pages => Deploy from a branch and Save.

## Publish via Github workflows

Create the `.github/workflows/deploy.yml`