# Update README Command

This command uses the readme-maintainer agent to update and maintain the README.md file with modern documentation best practices.

## Usage

```
/readme
```

## Description

This command will:
- Analyze the current README.md file
- Update it with modern documentation best practices
- Ensure proper structure and formatting
- Add missing sections as needed
- Maintain consistency with the project's purpose and architecture

## Agent Used

- **readme-maintainer**: Updates and maintains README.md files with modern documentation best practices

## Tools Available to Agent

- Read: To analyze existing README content
- Edit: To make targeted updates to the README
- MultiEdit: To make multiple changes in one operation
- Glob: To find relevant files for documentation
- Grep: To search for patterns across the codebase
- Task: To call other specialized agents (e.g., markdown-specialist for formatting and linting)