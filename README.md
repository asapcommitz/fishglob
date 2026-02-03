# fishglob

**fishglob** is a lightweight Fish shell function that translates Bash/Zsh glob syntax into Fish-native equivalents. It helps users coming from other shells use familiar glob patterns like `**/*.js` or `!(test).py` without getting "no matches found" errors.

## Why fishglob?

Fish uses different glob syntax than Bash/Zsh, which can be frustrating when:
- Copying commands from documentation or Stack Overflow
- Switching between shells
- Using tools that output Bash-style globs

fishglob bridges this gap by automatically translating patterns you're already familiar with.

## Features

- **Recursive Extension Shorthand**: `**/*.{js,ts}` → `**.js **.ts`
- **Negation Support**: `!(pattern)` → `(not pattern)`
- **Brace Expansion**: Full support for path and extension braces.
- **Wrapper Mode**: Direct execution of commands with translated globs.
- **Pure Fish**: Zero dependencies, fast and lightweight.

## Usage

### Translation
```fish
fishglob "**/*.{js,ts}"
# Output: **.js **.ts

fishglob "!(*.test).js"
# Output: (not *.test).js
```

### Wrapper Mode
Run any command by prefixing it with `fishglob`. It will translate the arguments and execute the command.
```fish
# This would fail in pure Fish:
fishglob ls **/*.{js,ts}
# Translates and executes: ls **.js **.ts
```
### Disabling Auto-Expansion

If you prefer manual translation only, remove the key binding:
```fish
bind \r execute  # Restore default Enter behavior
```

Or comment out the binding in `~/.config/fish/conf.d/fishglob.fish`.

## Installation

### Via Fisher (Recommended)
```fish
fisher install asapcommitz/fishglob
```

### Manual
Copy the files to your fish configuration:
```fish
mkdir -p ~/.config/fish/functions ~/.config/fish/completions ~/.config/fish/conf.d
cp functions/fishglob.fish ~/.config/fish/functions/
cp completions/fishglob.fish ~/.config/fish/completions/
cp conf.d/fishglob.fish ~/.config/fish/conf.d/
```

## Automatic Expansion
Once installed, `fishglob` automatically intercepts the **Enter** key. If it detects Bash-style globs, it translates them in the command line buffer before executing. This gives it a "built-in" feel.

## Examples

| Input Glob | Translated Fish Glob | Description |
| :--- | :--- | :--- |
| `**/*.js` | `**.js` | Recursive JS files |
| `!(test).py` | `(not test).py` | All .py except test.py |
| `src/**/*.{rs,md}` | `src/**.rs src/**.md` | Nested extensions |
| `**/{src,test}/*.rs` | `**/src/*.rs **/test/*.rs` | Braces in middle of path |

##  License
[MIT](LICENSE.md)
