export default function() {
  this.transition(
    this.hasClass('animate-sliding-drawer'),

    // this makes our rule apply when the liquid-if transitions to the
    // true state.
    this.toModel(true),
    this.use('fade', { duration: 300 }),

    // which means we can also apply a reverse rule for transitions to
    // the false state.
    this.reverse('fade', { duration: 300 })
  );
}
