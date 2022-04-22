class Clipboard {
  static copy({text, html}) {
    const data = [
      this.clipboardItem({type: "text/plain", content: text}),
      this.clipboardItem({type: "text/html", content: html})
    ]

    navigator.clipboard.write(data).then(
      () => { /* Success */ },
      (error) => {
        console.error(error)
        alert("Failed to copy to clipboard.")
      }
    )
  }

  static clipboardItem({type, content}) {
    return new ClipboardItem({[type]: new Blob([content], {type})})
  }
}

export default Clipboard
