# Markdown Specialist Command

This command uses the markdown-specialist agent to create well-formed, linted markdown documents and reformat existing markdown files following CommonMark and Azure DevOps standards.

## Usage

```
/markdown
```

## Description

This command will:
- Create well-structured markdown documents following CommonMark and GitHub Flavored Markdown standards
- Reformat and fix existing markdown files for consistency, compliance, and accessibility
- Apply markdown linting rules and validate syntax using tools like markdownlint
- Handle all markdown elements including headers, lists, tables, code blocks, links, and images
- Ensure proper spacing, indentation, and formatting throughout documents
- Optimize markdown for readability and cross-platform compatibility

## Agent Used

- **markdown-specialist**: Creates well-formed, linted markdown documents and reformats existing markdown files following CommonMark and Azure DevOps standards

## Tools Available to Agent

- Read: To analyze existing markdown files and content structure
- Write: To create new markdown documents with proper formatting
- Edit: To make targeted fixes to markdown syntax and formatting
- MultiEdit: To apply consistent formatting changes across multiple sections
- Bash: To run markdown linting tools like markdownlint for validation
- Grep: To search for formatting patterns and inconsistencies
- Glob: To find markdown files across the project for batch processing

## Example Use Cases

- Format a markdown file to follow proper linting standards and fix syntax issues
- Create a well-structured markdown document for project documentation
- Reformat markdown tables to be properly aligned and accessible
- Fix heading hierarchy and structure in documentation files
- Apply consistent code block formatting with proper syntax highlighting
- Validate and fix link formatting and accessibility
- Ensure proper list formatting and nesting throughout documents
- Convert poorly formatted markdown to follow modern standards