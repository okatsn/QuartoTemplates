const fs = require('fs');
const mustache = require('mustache');

// Read the template file
const template_index = fs.readFileSync('index.mustache', 'utf8');
// const template_custom = fs.readFileSync('custom.mustache', 'utf8');


// Read the data file
const data = JSON.parse(fs.readFileSync('data.json', 'utf8'));

// Render the template with the data
const output_index = mustache.render(template_index, data);
// const output_custom = mustache.render(template_custom, data);

// Write the output to files
fs.writeFileSync('index.qmd', output_index);
// fs.writeFileSync('custom.scss', output_custom);

console.log('Files has been generated');
