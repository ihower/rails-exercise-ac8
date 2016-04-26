import Foo from 'foo.es6';
import Bar from 'bar';

class Hello {
  constructor() {
    console.log('Hello!');
  }
}

new Hello();

new Foo();

alert( Bar(11) );