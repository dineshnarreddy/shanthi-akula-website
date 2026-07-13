// Scroll reveal
const io = new IntersectionObserver((entries) => {
  entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); } });
}, { threshold: .12 });
document.querySelectorAll('.fade').forEach((el, i) => { el.style.transitionDelay = (i % 3 * 0.07) + 's'; io.observe(el); });

// Mobile menu
const mb = document.querySelector('.menu-btn');
if (mb) mb.addEventListener('click', () => {
  const nl = document.querySelector('.nav-links');
  nl.style.cssText = 'display:flex;position:absolute;top:76px;left:0;right:0;background:var(--ivory);flex-direction:column;padding:20px 24px;gap:16px;box-shadow:var(--shadow)';
});
