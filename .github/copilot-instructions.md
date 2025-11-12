# GitHub Copilot Instructions

## C++ Code Style

### Documentation Comments

Use Qt documentation style for all C++ documentation comments:

- Start documentation blocks with `/*!` instead of `/**`
- Use backslash commands (`\brief`, `\param`, etc.) instead of @ commands
- Follow Qt documentation conventions

#### Example:

```cpp
/*!
    \brief Brief description of the function.
    
    Detailed description goes here. Can span multiple lines
    and include additional context about the function's behavior.
    
    \param paramName Description of the parameter
    \param anotherParam Description of another parameter
    \return Description of what the function returns
    \sa RelatedClass, relatedFunction()
    \note Important notes about usage
    \warning Warnings about potential issues
*/
void myFunction(int paramName, QString anotherParam);
```

#### Common Qt Documentation Commands:

- `\class ClassName` - Document a class
- `\brief` - Brief one-line description
- `\param paramName` - Parameter description
- `\return` - Return value description
- `\sa` - See also (related items)
- `\note` - Important notes
- `\warning` - Warnings
- `\code` ... `\endcode` - Code examples
- `\overload` - Mark function as overload
- `\reimp` - Reimplemented function
- `\internal` - Internal/private documentation
- `\since` - Version information

### General C++ Guidelines

- Use Qt containers (QVector, QList, QString, etc.) when working with Qt code
- Follow Qt naming conventions:
  - Class names: PascalCase (e.g., `MyClass`)
  - Member variables: camelCase with `m_` prefix (e.g., `m_memberVariable`)
  - Methods: camelCase (e.g., `myMethod()`)
  - Signals: camelCase, usually past tense (e.g., `valueChanged()`)
  - Slots: camelCase, often with `on` prefix (e.g., `onButtonClicked()`)
- Use `Q_EMIT` instead of `emit` keyword
- Use `Q_UNUSED(var)` for intentionally unused parameters
- Prefer `nullptr` over `NULL` or `0` for null pointers
- Use Qt property system with `Q_PROPERTY` macros when appropriate

### Code Organization

- Keep headers minimal and forward declare when possible
- Use private implementation (d-pointer) pattern for library classes
- Group related methods together in implementation files
- Separate Qt-specific code from platform-specific code

### Memory Management

- Use Qt parent-child ownership where appropriate
- Prefer smart pointers (QScopedPointer, QSharedPointer) for explicit ownership
- Delete QObject-derived classes using `deleteLater()` when in doubt

### Modern C++ Features

- Use `auto` for complex iterator types and obvious types
- Use range-based for loops with Qt containers
- Prefer `const` references for parameters that won't be modified
- Use `override` keyword for virtual function overrides
- Use `constexpr` for compile-time constants where appropriate
