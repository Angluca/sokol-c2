# sokol-c2
C2 bindings for the sokol headers  
(https://github.com/floooh/sokol)

Start only test, will add examples later :)

* have https://github.com/c2lang/c2compiler
* get https://github.com/floooh/sokol
* copy``` sokol-c2/sokol```to```c2compiler/libs/```
* modify makefile:```LIB_SOURCE = (just download sokol path)```
* If you want create new project, You can copy ./myapp :)

build run examples
```zsh
make example=clear run
make example=triangle run
make example=triangle-bufferless run
make example=quad run
make example=bufferoffsets run
```
> If build echo ```max char 31 error```,  
> modify ```c2compiler/ast_utils/constants.c2:line 21: MaxIdentifierLen = 96;```  
> and rebuild ```c2compiler```  
