document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll(".copy-link").forEach(btn => {
    btn.addEventListener("click", () => {
      navigator.clipboard.writeText(btn.dataset.url)
        .then(() => alert("Link copied!"))
        .catch(() => alert("Copy failed"));
    });
  });
});
