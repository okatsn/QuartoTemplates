## Example
### By Executing `tree-slide.sh`

By executing `tree-slide.sh`, you can create a new `index.qmd` file with all dependent files copied to the target directory; the scripts is intended to create a new presentation of `tree-slide` in the directory of `../HelloWorld` at one click.

The script `tree-slide.sh` generates `index.qmd` files and others by calling `tree-slide/render.js` to render the mustache files therein with `./tree-slide/data.json`, and copy them to `../HelloWorld`, where your personal information should be set in `tree-slide/data.json`.

#### Steps

Clone `QuartoTemplates` to the directory of your projects:

```bash
git clone https://github.com/okatsn/QuartoTemplates.git
```

Modify `data.json`, and 

```bash
cd QuartoTemplates
. tree-slide.sh HelloWorld
```




### Render the files in `tree-slide`

Alternatively, you can render file directly in `./tree-slide`.

```bash
cd tree-slide
node render.js
```



