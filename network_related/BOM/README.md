# BOM (Browser Object Model)
The Browser Object Model(BOM) is a browser-specific convention referring to all the objects exposed by the web browser. Unlike the `Document Object Model`, there is no `standard for implementation` and no strict definition, so browser vendors are free to implement the BOM in any way they wish.

That which we see as a window displaying a documentm the browser program sees as a hierarchical collection of objects.

When the browser parses a document and detail how it should be displayed. The object the browser creates is known as the Document object. It is part of a larger collection of objects that the browser makes use of. This collection of browser objects is collectively known as the Browser Object Model, or BOM.

The top level of the hierarchy is the window object, which contains the information about the window displaying the document. Some of the window object are objects themselves that describe the document and related information.

- The Browser Object Model(BOM) allows JavaScript to "talk to" the browser.
Since modern browsers have implemented(almost) the same methods and properties for JavaScript interactivity, it is often referred to, as methods and properties of the BOM.

# The Window Object
The `window` object is supported by all browsers.

All global JavaScript objects, functions, and variables automatically become members of the window object.

Global variables are properties of the window object.
Global functions are methods of the window object.

Even the document object(of the HTML DOM) is a property of the window object:
`window.document.getElementById("header");`
is the same as:
`document.getElementById("header");`

# Window Size
Two properties can be used to determine the size of the browser window.
Both properties return the sizes in pixels:
- window.innerHeight: the inner height of the browser window(in pixels)
- window.innerWidth: the inner width of the browser window(in pixels)

> notes: the browser window(the browser viewport) is NOT including toolbars and scrollbars

- document.documentElement.clientHeight
- document.documentElement.clientWidth
or
- document.body.clientHeight
- document.body.clientWidth

```
A practical JavaScript solution(covering all browsers):

e.g.
var w = window.innerWidth
|| document.documentElement.clientWidth
|| document.body.clientWidth;

var h = window.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight;

The example displays the browser window's height and width:
(Not including toolbars/scrollbars)
```

# Other Window Methods
Some other methods:
- window.open(): open a new window
- window.close(): close the current window
- window.moveTo(): move the current window
- window.resizeTo(): resize the current window


# refer
- https://www.w3schools.com/js/js_window.asp
- https://en.wikipedia.org/wiki/Browser_Object_Model