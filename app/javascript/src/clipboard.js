class Clipboard {
  static copyHTML(html) {
    const type = "text/html"
    const data = [new ClipboardItem({[type]: new Blob([html], {type})})]

    navigator.clipboard.write(data).then(
      () => { /* Success */ },
      (error) => {
        console.error(error)
        alert("Failed to copy to clipboard.")
      }
    )
  }
}

export default Clipboard
