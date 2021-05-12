export default function(context, element, items, message) {
  message = message || `${element} should occure "${items}x"`;
  let actual = context.element.querySelectorAll(element).length
  let expected = items;
  let result = !!(actual == expected);

  this.pushResult({ result, actual, expected, message });
}
