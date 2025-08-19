# Git Configuration

This directory contains a centralized Git configuration that provides a comprehensive development setup with VSCode integration, useful aliases, and modern Git workflow defaults.

## Purpose and Overview

The `.gitconfig` file in this directory is designed to:

- **Streamline Git workflows** with helpful aliases and shortcuts
- **Integrate seamlessly with VSCode** for editing, merging, and diffing
- **Enable modern Git features** like Git LFS, fast-forward-only pulls, and automatic remote setup
- **Provide secure credential management** through GitHub CLI integration
- **Set developer-friendly defaults** for new repositories and operations

This configuration is installed via symbolic links, allowing centralized management while providing system-wide Git settings.

## File Structure

```
settings/git/
├── .gitconfig      # Main Git configuration file
└── README.md       # This documentation file
```

### Installation Location

When installed via the `configure.ps1` script, the `.gitconfig` file is symlinked to:
- **Target**: `~/.gitconfig` (user's home directory)
- **Source**: `settings/git/.gitconfig`

This allows you to edit the configuration in the repository and have changes apply system-wide.

## Configuration Sections

### User Information

```ini
[user]
    name = Bobby Johnson
    email = bobby@notmyself.io
#   signingkey = 0E66B483EDA47168
```

**Purpose**: Defines the default author information for commits.

- `name`: Full name used in commit signatures
- `email`: Email address used in commit signatures  
- `signingkey`: (Commented) GPG key ID for signed commits

### Security and Safety

```ini
[safe]
    directory = *
```

**Purpose**: Marks all directories as safe for Git operations, preventing Git from refusing to operate in certain directory contexts.

### Core Settings

```ini
[core]
    editor = code --wait
```

**Purpose**: Sets VSCode as the default editor for Git operations like commit messages, interactive rebase, etc.

- `--wait`: Ensures Git waits for VSCode to close before continuing

### Repository Defaults

```ini
[init]
    defaultBranch = main
```

**Purpose**: Sets `main` as the default branch name for new repositories, following modern Git conventions.

### Pull and Push Behavior

```ini
[pull]
    ff = only

[push]
    autoSetupRemote = true
```

**Purpose**: Configures safer and more convenient Git operations.

- `ff = only`: Only allows fast-forward pulls, preventing unexpected merge commits
- `autoSetupRemote = true`: Automatically sets up remote tracking for new branches

## VSCode Integration

### Merge Tool Configuration

```ini
[merge]
    tool = vscode

[mergetool "vscode"]
    cmd = "code --wait $MERGED"
```

**Usage**: When merge conflicts occur, run `git mergetool` to open conflicted files in VSCode.

**Features**:
- Opens the merged file with conflict markers in VSCode
- Built-in conflict resolution UI
- Waits for you to resolve conflicts and save before continuing

### Diff Tool Configuration

```ini
[diff]
    tool = vscode

[difftool "vscode"]
    cmd = "code --wait --diff  $LOCAL $REMOTE"
```

**Usage**: Run `git difftool` to compare files using VSCode's diff viewer.

**Features**:
- Side-by-side diff visualization
- Syntax highlighting
- Line-by-line change indicators

## Git Aliases

### Commit Shortcuts

```ini
[alias]
    cm = !git add -A && git commit -m
```

#### `git cm "message"`

**Purpose**: Adds all changes and commits with a message in one command.

**Equivalent to**:
```bash
git add -A
git commit -m "message"
```

**Example Usage**:
```bash
# Instead of:
git add -A
git commit -m "Add new feature"

# Use:
git cm "Add new feature"
```

**When to use**:
- Quick commits when you want to stage all changes
- Ideal for small, focused commits
- Perfect for documentation updates or minor fixes

## Git LFS (Large File Storage)

```ini
[filter "lfs"]
    process = git-lfs filter-process
    required = true
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
```

**Purpose**: Enables Git LFS for handling large files efficiently.

**Features**:
- Automatically processes large files through LFS
- Reduces repository size
- Faster clones and fetches

## Credential Management

```ini
[credential "https://github.com"]
    helper = 
    helper = !'C:\Program Files\GitHub CLI\gh.exe' auth git-credential

[credential "https://gist.github.com"]
    helper = 
    helper = !'C:\Program Files\GitHub CLI\gh.exe' auth git-credential
```

**Purpose**: Uses GitHub CLI for secure authentication to GitHub and Gist.

**Benefits**:
- Seamless GitHub authentication
- No need to manage personal access tokens manually
- Works with two-factor authentication
- Automatic token refresh

## Installation and Usage

### Automatic Installation

The Git configuration is installed automatically when you run:

```powershell
.\configure.ps1
```

This script creates a symbolic link from `settings/git/.gitconfig` to `~/.gitconfig`.

### Manual Installation

If you need to install manually:

```powershell
# Remove existing Git config (backup first if needed)
Remove-Item ~/.gitconfig -Force -ErrorAction SilentlyContinue

# Create symbolic link
New-Item -ItemType SymbolicLink -Path ~/.gitconfig -Target "$PWD\settings\git\.gitconfig"
```

### Verification

Verify the configuration is working:

```bash
# Check Git config location
git config --list --show-origin

# Test specific settings
git config user.name
git config core.editor
git config alias.cm
```

## Customization

### Modifying User Information

Update the user section with your information:

```ini
[user]
    name = Your Full Name
    email = your.email@domain.com
```

### Adding Custom Aliases

Add your own aliases to the `[alias]` section:

```ini
[alias]
    cm = !git add -A && git commit -m
    # Add your custom aliases here
    st = status
    co = checkout
    br = branch
    last = log -1 HEAD
    unstage = reset HEAD --
```

### GPG Signing (Optional)

To enable commit signing, uncomment and configure:

```ini
[user]
    signingkey = YOUR_GPG_KEY_ID

[commit]
    gpgsign = true

[gpg]
    program = gpg
```

### Alternative Editor

To use a different editor, modify the core section:

```ini
[core]
    # For Notepad++
    editor = "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
    
    # For Vim
    editor = vim
    
    # For nano
    editor = nano
```

## Best Practices and Workflow

### Recommended Workflow

1. **Start with status**: `git status` to see current state
2. **Review changes**: `git diff` or `git difftool` for detailed comparison
3. **Stage selectively**: `git add <files>` for specific files, or use `git cm` for all changes
4. **Write clear commits**: Use descriptive commit messages
5. **Pull before push**: `git pull` (configured for fast-forward only)
6. **Push changes**: `git push` (auto-setup remote enabled)

### Merge Conflict Resolution

1. When conflicts occur during merge/pull:
   ```bash
   git mergetool
   ```
2. VSCode opens with conflict markers
3. Use VSCode's built-in conflict resolution UI
4. Save and close VSCode
5. Complete the merge:
   ```bash
   git commit
   ```

### Working with Large Files

1. Install Git LFS if not already installed:
   ```bash
   git lfs install
   ```
2. Track large file types:
   ```bash
   git lfs track "*.psd"
   git lfs track "*.zip"
   ```
3. LFS configuration in this file handles the rest automatically

### Branch Management

```bash
# Create and switch to new branch
git checkout -b feature/new-feature

# Quick commit with alias
git cm "Add new feature implementation"

# Push with auto-remote setup
git push

# Switch back to main
git checkout main

# Fast-forward only pull
git pull
```

## Troubleshooting

### Configuration Not Applied

1. Check if symbolic link exists:
   ```powershell
   Get-Item ~/.gitconfig | Select-Object LinkType, Target
   ```

2. Verify Git is reading the config:
   ```bash
   git config --list --show-origin
   ```

### VSCode Integration Issues

1. Ensure VSCode is in PATH:
   ```bash
   code --version
   ```

2. Test merge tool manually:
   ```bash
   git config --get merge.tool
   git mergetool --tool-help
   ```

### GitHub Authentication Issues

1. Ensure GitHub CLI is installed and authenticated:
   ```bash
   gh auth status
   ```

2. Re-authenticate if needed:
   ```bash
   gh auth login
   ```

## Related Documentation

- [Git Official Documentation](https://git-scm.com/doc)
- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [Git LFS Documentation](https://git-lfs.github.io/)
- [VSCode Git Integration](https://code.visualstudio.com/docs/editor/versioncontrol)

## Configuration Reference

For the complete configuration file, see [.gitconfig](./.gitconfig) in this directory.