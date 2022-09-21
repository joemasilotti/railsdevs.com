class Clipboard {
  static copy({ text, html }) {
    console.log(text);
    console.log(html);
    const data = [
      new ClipboardItem({
        ["text/plain"]: new Blob([text], { type: "text/plain" }),
        ["text/html"]: new Blob([html], { type: "text/html" }),
      }),
    ];

    navigator.clipboard.write(data).then(
      () => {
        /* Success */
      },
      (error) => {
        console.error(error);
        alert("Failed to copy to clipboard.");
      }
    );
  }
}

export default Clipboard;
