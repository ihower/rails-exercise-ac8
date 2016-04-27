var foo = function(x){
  console.log(this);
  console.log(x);
}

foo("123")
// Output:
//   Window
//  "123"

var bar = foo.bind("ABC", "123");
bar();
// Output:
//  "ABC"
//  "123"
