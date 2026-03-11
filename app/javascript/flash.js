function setupFlashToasts() {
  const toasts = document.querySelectorAll(".flash-toast");

  toasts.forEach((toast) => {
    const timeoutMs = Number(toast.dataset.flashTimeout || 5000);
    if (!Number.isFinite(timeoutMs) || timeoutMs <= 0) return;

    window.setTimeout(() => toast.remove(), timeoutMs);
  });
}

document.addEventListener("turbo:load", setupFlashToasts);
