/* Reveal-on-load + scroll-based reveal + sticky nav shadow */

(function () {
  'use strict';

  const nav = document.getElementById('nav');
  const onScroll = () => {
    if (window.scrollY > 4) nav.classList.add('is-scrolled');
    else nav.classList.remove('is-scrolled');
  };
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  // Hero lines — reveal on load
  const heroReveals = document.querySelectorAll('.hero .reveal');
  requestAnimationFrame(() => {
    heroReveals.forEach((el) => el.classList.add('is-in'));
  });

  // Sections — fade up on scroll
  const targets = document.querySelectorAll(
    '.section__head, .role, .card, .pub, .fact-list, .skills, .contact__title, .contact__lede, .contact__links, .prose-lg, .prose'
  );
  targets.forEach((el) => el.classList.add('fade-up'));

  if ('IntersectionObserver' in window) {
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-in');
            io.unobserve(entry.target);
          }
        });
      },
      { rootMargin: '0px 0px -8% 0px', threshold: 0.08 }
    );
    targets.forEach((el) => io.observe(el));
  } else {
    targets.forEach((el) => el.classList.add('is-in'));
  }
})();
