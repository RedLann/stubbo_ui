var editor;
const options = {
    "modes": ['code'],
}

function prepareEditor(json) {
      // create the editor
    const container = document.getElementById("jsoneditor")
    editor = new JSONEditor(container, options)
    editor.set(JSON.parse(json))
}

function getJson() {
    return JSON.stringify(editor.get())
}