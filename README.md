# idris-libpq!

Idris wrapper for libpq (Postgres).

libpq path is currently hardwired for Mac OS X (you will need to the `%dynamic` path to 
change where libpq exists). The example C program from the postgresql documentation works 
(just run ./build.sh in `src`). Main works in the repl.

```
docker-compose up -d

idris
:l src/Main.idr
:m main
```

but not when compiled. 
