# Convenience-String

convenience-string is provide {{}} operator in #S"string". 
The variable inside the {{}} is evaluated.

## Usage
```
;; define #S macro
(convenience-string:enable)
```

```
(setf hoge 'apple)
#S"this is an {{hoge}}"
;; => "this is an apple"
```

Unfortunately, convenience-string can't access the value of a lexical variable,
so you have to declare a special variable if you want.
```
(let ((hoge 'apple))
        (declare (special hoge))
        #S"this is an {{hoge}}")
```
## Installation
```
(asdf:load-system :convenience-string)
```

## Author

* Masayuki Suzuki (szkmsyk041792@gmail.com)

## Copyright

Copyright (c) 2019 Masayuki Suzuki (szkmsyk041792@gmail.com)

## License

Licensed under the MIT License.
