## Example
### By Executing `tree-slide.sh`

By executing `tree-slide.sh`, you can create a new `index.qmd` file with all dependent files copied to the target directory.

Create a new presentation of `tree-slide` in the directory of `../HelloWorld`. 
Noted that your personal information should be set in `tree-slide/data.json`.

In the directory of `QuartoTemplates`, do: 
```bash
bash tree-slide.sh HelloWorld
```

### Render the files in `tree-slide`

```bash
cd tree-slide
node render.js
```



