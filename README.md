# Neovim Configuration

## Notes

### Fixing LazyGit Contrast Issue

Override the lazygit config here (or at proper location for your OS):
`~/Library/Application Support/lazygit/config.yml`

Set this to fix bad contrast in git diffs:

```yaml
gui:
  theme:
    # Setting custom color to improve contrast.
    selectedLineBgColor:
      - "#2e3b3b"
```
