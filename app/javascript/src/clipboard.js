class Clipboard {
  static copy({text, html}) {
    const clipboardItem = new ClipboardItem({
        ["text/plain"]: new Blob([text], { type: "text/plain" }),
        ["text/html"]: new Blob([html], { type: "text/html" }),
      })

    navigator.clipboard.write([clipboardItem]).then(
      () => { /* Success */ },
      (error) => {
        console.error(error);
        alert("Failed to copy to clipboard.")
      }
    )
  }
}

export default Clipboard
