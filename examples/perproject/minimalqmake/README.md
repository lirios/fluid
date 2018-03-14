# Per-project installation with qmake

Fetch Fluid sources from the root directory of your project:

```sh
git clone https://github.com/lirios/fluid.git
```

Now create a project like `minimalqmake.pro` that includes both `fluid`
and the actual code of your app (inside the `src` sub-directory).

Material Design icons can either be installed alongside the Fluid.Controls
QML plugin (the default), or be embedded into the resources.

Pass `CONFIG+=fluid_resource_icons` to `qmake` in order to embed icons
into the resources.
