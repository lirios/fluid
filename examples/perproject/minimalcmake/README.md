# Per-project installation with CMake

Fetch Fluid sources from the root directory of your project:

```sh
git clone https://github.com/lirios/fluid.git
```

Now create your `CMakeLists.txt` that includes both `fluid`
and the actual code of your app (inside the `src` sub-directory).

Make sure you pass the installation prefix to `cmake` when configuring
the project.

From this directory type the following commands to prepare the
build directory and configure the project:

```sh
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$(pwd)/install-root
```

Now build and install:

```sh
make
make install
```

This examples the following file system:

```
install-root
├── bin
│   └── example
└── lib
    └── qml
        └── ...
```

You can adopt a different layout passing the following arguments to `cmake`:

 * `INSTALL_BINDIR`
 * `INSTALL_QMLDIR`

Please remember to change your imports path accordingly, see `main.cpp`.
