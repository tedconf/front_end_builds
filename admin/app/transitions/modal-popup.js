export default function noop(oldView, insertNewView) {
  return insertNewView().then(function(newView){
    if (newView){
      newView.$().css({
        display: '',
        visibility: ''
      });
    }
  });
}
