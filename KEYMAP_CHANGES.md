# Keymap Changes

Reference for keymaps that changed during the Neovim 0.12 config update.

## Removed (now built-in)

| Old Keymap | Action | Built-in Replacement | Notes |
|---|---|---|---|
| `K` (custom) | Hover documentation | `K` (built-in since 0.10) | Same key, just no longer manually mapped |
| `<leader>ca` | Code action | `gra` (built-in since 0.11) | |
| `<C-y>` (insert) | Signature help | `<C-S>` (built-in since 0.11) | Different key |

## Changed

| Old Keymap | New Keymap | Action |
|---|---|---|
| `gr` | `grr` | LSP references (filtered, excludes `_test.go`) |
| `gra` | `grR` | LSP references (all, unfiltered) |

## Unchanged custom keymaps

| Keymap | Action |
|---|---|
| `R` | Rename symbol (shorter than built-in `grn`) |
| `<leader>of` | Open diagnostic float |
| `gD` | Go to declaration |
| `gd` | Go to definition (snacks picker) |
| `gi` | Go to implementation (snacks picker) |

## New built-in keymaps (available for free on 0.11+)

These are mapped automatically on LspAttach — no config needed:

| Keymap | Action |
|---|---|
| `grn` | Rename (you also have `R` as a shortcut) |
| `gra` | Code action |
| `grr` | References (overridden by your filtered snacks picker) |
| `gri` | Implementation |
| `grt` | Type definition (0.12) |
| `grx` | Codelens run (0.12) |
| `gO` | Document symbols |
| `<C-S>` (insert) | Signature help |
| `K` | Hover documentation |
| `[d` / `]d` | Previous/next diagnostic |
| `<C-W>d` | Open diagnostic float |
