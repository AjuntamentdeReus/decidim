import Logo from "./../../images/logo-reus-negatiu.png"

// add pre-header with the reus ajuntament logo
document.addEventListener("DOMContentLoaded", () => {
  const div = document.createElement("div")
  const img = new Image()
  img.src = Logo

  div.className = "title-bar"
  div.innerHTML = `<div class="row column">
    <div class="logo-wrapper">
      <a rel="decidim" href="https://www.reus.cat/" target="_blank">
        <img src="${img.src}" alt="Ajuntament de Reus" />
      </a>
    </div>
  </div>`

  document.body.prepend(div)
})
