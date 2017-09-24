# Per-project installation with qmake

Fetch Fluid sources from the root directory of your project:

```sh
git clone https://github.com/lirios/fluid.git
```

Now create a project like `minimalqmake.pro` that includes both `fluid`
and the actual code of your app (inside the `src` sub-directory).
