import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "progressContainer", "fileList", "progressBar", "filePlate" ]

  targetWithAttibute(targets, attrKey, attrValue) {
    return targets.filter(target => target.dataset[attrKey] == attrValue)[0]
  }

  connect() {
    const actions = [
      "direct-upload:initialize->file-upload#initUpload",
      "direct-upload:start->file-upload#start",
      "direct-upload:progress->file-upload#progress",
      "direct-upload:error->file-upload#error",
      "direct-upload:end->file-upload#end"
    ]

    this.element.dataset["action"] = actions.join(' ')
  }

  listFiles(event) {
    const files = event.target.files
    this.fileListTarget.innerHTML = ""

    Array.from(files).forEach((file) => {
      let fileName = file.name

      this.fileListTarget.innerHTML += `
      <div class="text-gray-500 text-sm fill-current mt-2">
        <svg xmlns="http://www.w3.org/2000/svg" class="inline-block h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.172 7l-6.586 6.586a2 2 0 102.828 2.828l6.414-6.586a4 4 0 00-5.656-5.656l-6.415 6.585a6 6 0 108.486 8.486L20.5 13" />
        </svg>
        <span>${fileName.slice(0,14)}...${fileName.slice(-4)}</span>
      </div>
      `
    })
  }

  initUpload(event) {
    const { id, file } = event.detail
    const fileName = file.name

    this.progressContainerTarget.innerHTML += `
      <div data-plate="${id}" data-file-upload-target="filePlate" class="inline-block relative px-2 py-1 mt-2 ml-1 border border-gray-500 text-gray-500 rounded-md text-sm opacity-50">
        <div data-progress="${id}" data-file-upload-target="progressBar" class="absolute inset-y-0 left-0 opacity-20 bg-green-500 transition-all" style="width: 0%"></div>
        <span>${fileName.slice(0,14)}...${fileName.slice(-4)}</span>
      </div>
    `
  }

  start(event) {
    const { id } = event.detail
    const element = this.targetWithAttibute(this.filePlateTargets, "plate", id)
    element.classList.remove("opacity-50")
  }

  progress(event) {
    const { id, progress } = event.detail
    const element = this.targetWithAttibute(this.progressBarTargets, "progress", id)
    element.style.width = `${progress}%`
  }

  error(event) {
    event.preventDefault()
    const { id, error } = event.detail
    const element = this.targetWithAttibute(this.filePlateTargets, "plate", id)
    element.classList.add("border-red-500")
    element.setAttribute("title", error)
  }

  end(event) {
    const { id } = event.detail
    const element = this.targetWithAttibute(this.filePlateTargets, "plate", id)
    element.classList.add("opacity-50")
  }
}
