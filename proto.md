# **Difference between __ __proto__ __ and Prototype**
------
In reality, the only true difference between `prototype` and  ` __proto__ ` is that the prototype is a property of a `class constructor`, while the __ __proto__ __ is a property of a `class instance`.

Let's talk about the prototypes first

consider below code snippet
```js
let obj = {};
alert( obj ); // "[object Object]" ?
```

Where’s the code that generates the string `"[object Object]"`? That’s a built-in toString method, but where is it? The obj is empty!

…But the short notation `obj = {} is the same as obj = new Object()`, where Object is a built-in object constructor function, with its own prototype referencing a huge object with toString and other methods.

Look at below pictures you can understand easily

![prototype](https://javascript.info/article/native-prototypes/object-prototype.svg)

When new Object() is called (or a literal object {...} is created), the `[[Prototype]]` of it is set to Object.prototype.

![prototype](https://javascript.info/article/native-prototypes/object-prototype-1.svg)

So then when `obj.toString()`is called the method is taken from `Object.prototype`.

We can check above things as below so we will be clear about the topic

```js
let obj = {};

alert(obj.__proto__ === Object.prototype); // true
// obj.toString === obj.__proto__.toString == Object.prototype.toString
```
Please note that there is no more [[Prototype]] in the chain above Object.prototype , It can simply as nothing is there upside the  Simply Null Object.

```js
alert(Object.prototype.__proto__); // null
```
## **More Examples on other Bulit-in type prototypes** 

![Generic Images](https://javascript.info/article/native-prototypes/native-prototypes-classes.svg)



So there may be a confusion by looking at above picture look at below code snippet you may clear about the statement.

```js
let arr = [1, 2, 3];

// it inherits from Array.prototype?
alert( arr.__proto__ === Array.prototype ); // true

// then from Object.prototype?
alert( arr.__proto__.__proto__ === Object.prototype ); // true

// and null on the top.
alert( arr.__proto__.__proto__.__proto__ ); // null

```
    There are some methods in prototypes may overlap, for instance, Array.prototype has its own toString that lists comma-delimited elements.

```js
let arr = [1, 2, 3]
alert(arr); // 1,2,3 <-- the result of Array.prototype.toString
```
We may think that the result should be `[Object Array] ` but as we say there are some methods in prototypes which may overlap. Here `Array.prototype.toString()` overlapping the `Object.prototype.toString().`

```js
console.log([1,2,3])
0: 1
1: 2
2: 3
length: 3
__proto__: Array(0)
    concat: ƒ concat()
    __proto__: ƒ ()
        [[Scopes]]: Scopes[0]
        constructor: ƒ Array()
        __proto__:
                constructor: ƒ Object()
                hasOwnProperty: ƒ hasOwnProperty()
                valueOf: ƒ valueOf()
                get __proto__: ƒ __proto__()
                set __proto__: ƒ __proto__()
```
Let`s look at a real time example which will solve your doubts came into the picture reading above blog.

# **An explanation of prototype**

Apple recently released its new iPhone, the iPhone 11. That phone has certain qualities — for example, Face ID and 4K video. Every iPhone 11 that is produced must have those exact same features.Now, let’s assume that there’s a constructor function that produces a new iPhone 11 every time it’s called. In order to properly build an iPhone 11, a prototype — a model of an iPhone 11 to refer to — is needed. This prototype or model ensures that every iPhone has Face ID, that every iPhone can take 4K video. Thus, the iPhone constructor must know and have access to the prototype that it must build. This is the constructor’s prototype property.

```js
function iPhone() {}; // constructor
// a method for recognizing faces
iPhone.prototype.faceID = function() { ... };
// a method for taking 4k video
iPhone.prototype.video = function() { ... };
let newPhone = new iPhone(); // an iPhone 11
```
**The relationship between __ __proto__ __ and prototype**

I’ve now made a new iPhone 11, and saved it in a variable called newPhone. The contents of newPhone will look something like this.

![Example](https://miro.medium.com/max/384/1*MMJM8j47xmveEkSaeO_Blg.png)

So it seems like this new iPhone 11 comes with FaceID and video! In fact, you can execute newPhone.faceID() or newPhone.video() and see that these methods work fine. However, why are these features stored in an object called __ __proto__ __ , and not stored directly as properties of newPhone?
    
#**prototype, and thus holds the exact same contents as well. By having a __ __proto__ __ property identical to iPhone.prototype, newPhone is essentially saying, “Look, since I’m an iPhone 11, I have the exact same features as any other iPhone 11! I’ve got Face ID, 4K video, you name it.”**
**
In reality, the only true difference between prototype and __ __proto__ __ is that the former is a property of a class constructor, while the latter is a property of a class instance. In other words, while iPhone.prototype provides a blueprint for building an iPhone, newPhone.__ __proto__ __ affirms that the iPhone has indeed been built according to that specific blueprint. But with regards to the properties and methods present in those two objects… well, they’re exactly the same.
