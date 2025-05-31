---
applyTo: "**/*.{bash,sh,zsh}"
---
# Shell Script Style Guide

## Scope

- Applies to all `.bash`, `.sh`, `.zsh` files except 3rd-party libraries
- Follows Google Shell Style Guide unless specified otherwise
- Consistency over personal preference

## Indentation & Spacing

- Use 2 spaces for indentation (never tabs)
- Space after keywords: `if [[ condition ]]; then`
- No space before function parentheses: `my_func() {`
- Single empty line at end of file

## Line Length

- 80 characters maximum
- 100 characters for complex commands
- 70 characters when using inline comments

## Quoting

- Quote all variables with braces: `"${variable}"`
- Quote arrays: `"${array[@]}"`
- Quote command substitutions: `"$(command)"`
- Always use braces for clarity: `"${TAG}value is ${VALUE}"`

## Naming Conventions

- **Variables**: lowercase_with_underscores (`max_retries`, `input_file`)
- **Constants**: UPPERCASE_WITH_UNDERSCORES (`DEFAULT_PORT`, `CONFIG_FILE`)
- **Functions**: lowercase_with_underscores (`my_func`)
- **Files**: lowercase-with-dashes (`make-template.sh`)
- **Loop variables**: singular form (`for file in "${files[@]}"`)

## Function Syntax

- Always use parentheses: `my_func() {`
- Never use `function` keyword
- Opening brace on same line as function name
- Package functions use `::` separator (`mypackage::my_func`)

## Variable Declaration

- Constants use `readonly` at file top
- Exported constants use `declare -xr`
- Runtime constants: assign then `readonly` immediately

## File Structure

- Shebang first line
- Constants at top after shebang
- Functions grouped together after constants
- Main execution code at bottom
- No code interleaved between functions

## Comments

- Discouraged except for complex/non-obvious code
- Use `#` (hash + space) format
- No TODO comments in code (use separate `.md` files)
- File headers allowed for description and usage

## File Headers

- Short description after shebang
- Usage examples if helpful
- Important notes if needed
- Separate components with empty lines
- No boilerplate (author, date, license)

## Header Examples Format

- Single: `# Usage: ./script.sh`
- Multiple: `# Usage:` then indent 2 spaces per example
- Use `\` for line continuation over 100 chars
- Order simple to complex

## Header Notes Format

- Single: `# Note: Important detail.`
- Multiple: `# Notes:` then bulleted list with 2-space indent
- End with period, keep concise
