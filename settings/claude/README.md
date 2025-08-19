# Claude Code Configuration

This directory contains the complete Claude Code configuration for the Windows development setup automation repository. It includes specialized agents, commands, and settings that provide domain-specific expertise following modern development best practices.

## Directory Structure

The `settings/claude/` directory contains:

```
settings/claude/
├── README.md                        # This documentation file
├── settings.json                    # Claude Code global configuration
├── agents/                          # Specialized agent definitions
│   ├── azure-devops-specialist.md
│   ├── claude-agent-specialist.md
│   ├── csharp-specialist.md
│   ├── feature-prompt-specialist.md
│   ├── markdown-specialist.md
│   ├── mstest-specialist.md
│   └── readme-maintainer.md
└── commands/                        # Slash command definitions
    ├── csharp.md
    ├── devops.md
    ├── markdown.md
    ├── mstest.md
    ├── new-agent.md
    ├── new-feature.md
    └── readme.md
```

## Configuration Overview

The Claude Code setup includes:
- **Specialized Agents**: Expert agents for specific development tasks
- **Slash Commands**: Quick access commands that invoke the agents
- **PowerShell Integration**: Optimized for Windows development workflows
- **Global Settings**: Shell configuration and permissions management

## Available Agents

### 🔧 claude-agent-specialist

**Purpose**: Meta-agent that designs and creates other specialized agents with proper structure, validation, and best practices.

**Tools**: Read, Write, Glob, Grep, Task
**Command**: `/new-agent`

**Key Capabilities**:

- Agent design and architecture planning
- Template creation following Claude Code standards
- Validation and best practice enforcement
- YAML frontmatter format compliance
- Naming convention and uniqueness checks
- Sub-agent integration and workflow orchestration

**Usage Examples**:

```bash
/new-agent "Create a new agent for database operations and SQL optimization"
/new-agent "Design an agent specialized in React component testing" 
/new-agent "Validate the structure of existing agents in the repository"
```

### ☁️ azure-devops-specialist

**Purpose**: Azure DevOps specialist for pipelines, builds, releases, and project management operations.

**Tools**: Bash, WebSearch, Read, Write, Edit, MultiEdit, Grep, Glob, Task
**Command**: `/devops`

**Key Capabilities**:

- YAML pipeline creation and optimization
- Azure CLI automation and scripting
- Build agent and deployment configuration
- Security scanning and compliance implementation
- Modern CI/CD pattern implementation (2024-2025)
- Integration with .NET testing and deployment workflows

**Usage Examples**:

```bash
/devops "Create a CI/CD pipeline for this .NET application with Azure Artifacts publishing"
/devops "Set up branch policies and pull request validation for the main branch"
/devops "Configure automated security scanning in our build pipeline"
/devops "Help troubleshoot this failing Azure DevOps pipeline YAML"
```

### 💻 csharp-specialist

**Purpose**: Modern C# development specialist using latest language features, frameworks, and best practices.

**Tools**: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, Task
**Command**: `/csharp`

**Key Capabilities**:

- C# 12+ language features (primary constructors, collection expressions, ref readonly parameters, alias any type)
- .NET 8+ framework capabilities with ASP.NET Core and Entity Framework Core
- SOLID principles, dependency injection, and clean architecture patterns
- Modern async/await patterns with proper ConfigureAwait usage
- Integration with popular libraries (MediatR, FluentValidation, AutoMapper, Serilog, Carter)
- Nullable reference types and null safety patterns
- Record types, pattern matching, and switch expressions
- Result patterns for error handling vs traditional exceptions

**Usage Examples**:

```bash
/csharp "Create a minimal API endpoint for user management using Entity Framework Core"
/csharp "Implement a MediatR command handler with validation and error handling"
/csharp "Write a clean architecture service layer with dependency injection"
/csharp "Generate C# record types for API DTOs with validation attributes"
/csharp "Create Entity Framework models with proper relationships and migrations"
/csharp "Implement async repository pattern with Result error handling"
```

### 🧪 mstest-specialist

**Purpose**: .NET unit testing specialist using MSTest.Sdk and NSubstitute for component testing.

**Tools**: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, Task
**Command**: `/mstest`

**Key Capabilities**:

- MSTest.Sdk framework test generation with modern attributes
- NSubstitute mocking and dependency isolation patterns
- Component testing vs unit testing methodologies
- Async/await testing patterns and best practices
- Test architecture following .NET testing standards
- Arrange-act-assert pattern implementation
- Test execution and coverage analysis
- Parameterized testing with DataTestMethod and DataRow

**Usage Examples**:

```bash
/mstest "Generate unit tests for this service class using MSTest and NSubstitute"
/mstest "Create component tests for this controller with mocked dependencies"
/mstest "Write async tests for this repository class using MSTest framework"
/mstest "Set up a test project structure for this .NET application"
/mstest "Generate parameterized tests for this validation method"
```

### 📋 feature-prompt-specialist

**Purpose**: Specialized agent for creating comprehensive, well-structured feature prompts for software development tasks.

**Tools**: Read, Write, Edit, MultiEdit, Grep, Glob, Task
**Command**: `/new-feature`

**Key Capabilities**:

- Requirements engineering principles and analysis
- Comprehensive feature documentation with all necessary sections
- Technical specifications with implementation guidance
- Clear, testable acceptance criteria and success metrics
- Context integration with existing codebases and architecture
- Testing strategy and quality assurance requirements
- User story and acceptance criteria writing techniques
- Technical documentation following industry standards

**Usage Examples**:

```bash
/new-feature "Create a comprehensive feature prompt for adding user authentication to our web application"
/new-feature "Write a detailed feature specification for implementing real-time notifications"
/new-feature "Generate a feature prompt for adding search functionality with filtering and sorting"
/new-feature "Help me document requirements for integrating a third-party payment processing system"
```

### 📝 markdown-specialist

**Purpose**: Creates well-formed, linted markdown documents and reformats existing markdown files following CommonMark and GitHub Flavored Markdown standards.

**Tools**: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, Task
**Command**: `/markdown`

**Key Capabilities**:

- CommonMark and GitHub Flavored Markdown specification compliance
- Markdown linting rules and markdownlint standards application
- Table formatting, alignment, and accessibility optimization
- Code block syntax highlighting and language specification
- Link validation, formatting, and accessibility enhancement
- Header hierarchy optimization and document structure improvement

**Usage Examples**:

```bash
/markdown "Format this markdown file to follow proper linting standards and fix any syntax issues"
/markdown "Create a well-structured markdown document for this project documentation"
/markdown "Reformat this markdown table to be properly aligned and accessible"
/markdown "Fix the markdown syntax in this file and ensure it follows CommonMark standards"
```

### 📖 readme-maintainer

**Purpose**: Updates and maintains README.md files with modern documentation best practices and integrates with markdown-specialist for optimal formatting.

**Tools**: Read, Edit, MultiEdit, Glob, Grep, Task
**Command**: `/readme`

**Key Capabilities**:

- README analysis and gap identification
- Modern documentation standards implementation
- Structure optimization with scannable sections
- Badge integration and status indicators
- Cross-platform compatibility considerations
- Automatic markdown formatting via markdown-specialist integration

**Usage Examples**:

```bash
/readme "Update the README.md file to include proper installation instructions"
/readme "Analyze this project's README and identify missing sections"
/readme "Create a comprehensive README following modern best practices"
/readme "Review the README.md and ensure it accurately reflects current project functionality"
```

## Agent Workflow Integration

The agents in this repository are designed to work together as an integrated workflow system, with each agent capable of calling others via the Task tool to ensure comprehensive and properly formatted results:

### Core Workflow Patterns

**Documentation Chain**:

- **readme-maintainer** → **markdown-specialist**: README updates automatically formatted and linted
- **claude-agent-specialist** → **readme-maintainer** → **markdown-specialist**: New agent creation triggers complete documentation update
- **feature-prompt-specialist** → **markdown-specialist**: Feature documentation properly formatted

**Development Chain**:

- **feature-prompt-specialist** → **csharp-specialist**: Requirements analysis followed by modern C# implementation
- **csharp-specialist** → **mstest-specialist**: Code implementation followed by comprehensive unit testing
- **azure-devops-specialist** → **mstest-specialist**: CI/CD pipelines with integrated testing workflows
- **csharp-specialist** → **azure-devops-specialist**: Modern .NET applications with proper CI/CD integration

**Quality Assurance Chain**:

- **Any agent** → **markdown-specialist**: Final formatting and linting for all markdown outputs
- **csharp-specialist** → **mstest-specialist**: Code quality validation through comprehensive testing
- **azure-devops-specialist** → **csharp-specialist**: Pipeline integration with modern .NET practices

### Benefits of Integrated Workflow

- **Consistency**: All outputs follow established standards through specialized agents
- **Completeness**: Multi-step workflows ensure comprehensive coverage of tasks
- **Quality Assurance**: Multiple validation layers with specialized expertise
- **Automation**: Reduces manual coordination between different aspects of development
- **Expertise Chaining**: Each agent contributes its specialized knowledge to the final result

### Example Workflows

**Creating a New Feature**:

1. `/new-feature` - Analyze requirements and create comprehensive feature specification
2. `feature-prompt-specialist` calls `csharp-specialist` - Implement feature using modern C# practices
3. `csharp-specialist` calls `mstest-specialist` - Generate comprehensive unit tests
4. `mstest-specialist` calls `azure-devops-specialist` - Set up CI/CD pipeline integration
5. `azure-devops-specialist` calls `markdown-specialist` - Format pipeline documentation
6. Final result: Complete feature implementation with tests, deployment pipeline, and documentation

**Documentation Update Workflow**:

1. `/readme` - Update README with new content and structure
2. `readme-maintainer` calls `markdown-specialist` - Apply proper formatting and linting
3. Final result: Professional, well-formatted documentation that meets all standards

**Agent Creation Workflow**:

1. `/new-agent` - Design and create new specialized agent
2. `claude-agent-specialist` calls `readme-maintainer` - Update documentation to include new agent
3. `readme-maintainer` calls `markdown-specialist` - Format and lint the updated documentation
4. Final result: New agent with complete, properly formatted documentation

## Configuration Details

### Global Settings (`settings.json`)

The Claude Code configuration includes:

```json
{
  "env": {
    "SHELL": "powershell",
    "CLAUDE_SHELL": "powershell",
    "CLAUDE_AGENTS_PATH": ".claude/agents"
  },
  "permissions": {
    "allow": [
      "WebFetch(domain:docs.anthropic.com)",
      "Bash(powershell:*)",
      "Bash(mkdir:*)"
    ],
    "deny": [],
    "ask": []
  }
}
```

**Key Configuration Elements**:

- **Shell Integration**: PowerShell as the default shell for Windows compatibility
- **Agent Path**: `.claude/agents` for agent discovery
- **Permissions**: Controlled access to PowerShell execution and documentation domains

### Command Integration

Each agent has a corresponding command file in `commands/` that creates slash commands:

| Command File      | Slash Command   | Agent Invoked                |
|-------------------|-----------------|------------------------------|
| `csharp.md`       | `/csharp`       | `csharp-specialist`          |
| `devops.md`       | `/devops`       | `azure-devops-specialist`    |
| `markdown.md`     | `/markdown`     | `markdown-specialist`        |
| `mstest.md`       | `/mstest`       | `mstest-specialist`          |
| `new-agent.md`    | `/new-agent`    | `claude-agent-specialist`    |
| `new-feature.md`  | `/new-feature`  | `feature-prompt-specialist`  |
| `readme.md`       | `/readme`       | `readme-maintainer`          |

**Command Features**:

- **Quick Access**: Use `/command-name` for rapid agent invocation
- **Tool Documentation**: Each command file documents available tools and capabilities
- **Usage Examples**: Real-world scenarios for each agent

## Usage Instructions

### Method 1: Direct Commands (Recommended)
```bash
# Update README with modern best practices
/readme

# Create or improve agents
/new-agent

# Azure DevOps operations
/devops

# Modern C# development with latest language features
/csharp

# .NET testing and unit test generation
/mstest

# Create comprehensive feature specifications and requirements
/new-feature

# Format and lint markdown documents
/markdown
```

### Method 2: Agent Reference

When working with general-purpose responses, reference agent expertise:

```text
"Following the guidelines in readme-maintainer.md, update this README..."
"Use the azure-devops-specialist approach to create a pipeline for..."
"Apply claude-agent-specialist principles to design a new testing agent..."
"Using csharp-specialist best practices, implement this feature with modern C#..."
"Following feature-prompt-specialist structure, create requirements for..."
"Apply mstest-specialist patterns to generate comprehensive unit tests..."
"Apply markdown-specialist formatting to this documentation..."
```

### Method 3: Manual Agent Templates

For complex tasks, copy and adapt agent templates:

1. Read the relevant agent file for specialized knowledge
2. Apply the agent's working process and best practices
3. Follow the output standards and guidelines

## Agent Development

### Creating New Agents

Use the claude-agent-specialist for new agent creation:

```bash
/new-agent "Create an agent for [specific domain/task]"
```

### Agent Requirements

All agents must follow these standards:

- **YAML Frontmatter**: `name`, `description`, `tools` fields only
- **Naming Convention**: kebab-case (lowercase-with-hyphens)
- **File Location**: `agents/[agent-name].md`
- **Structure**: Follow the claude-agent-specialist template exactly

### Validation Checklist

Before deploying new agents:

- [ ] Name is unique and follows kebab-case convention
- [ ] Description is under 100 characters
- [ ] Tools are comma-separated (not array format)
- [ ] YAML frontmatter is properly formatted
- [ ] Agent scope is focused and well-defined
- [ ] Documentation includes usage examples

## Integration with Development Workflow

### Symbolic Link Configuration

The `configure.ps1` script creates symbolic links:

```text
settings/claude/agents → ~/.claude/agents
settings/claude/commands → ~/.claude/commands
settings/claude/settings.json → ~/.claude/settings.json
```

### PowerShell Profile Integration

The agents work seamlessly with the PowerShell profile's development tools:

- Git operations and repository management
- VSCode extension management
- Azure CLI automation
- .NET development and testing workflows
- Node.js development workflows

### MCP Server Support

The configuration includes MCP server support for:

- **NuGet** - Package management and dependency operations
- **.NET CLI** - Build, test, and project operations
- **Azure CLI** - Cloud service integration and management
- **Git** - Repository operations and version control
- **SQL Server** - Database operations and management
- **Filesystem** - File system operations and project navigation

## Best Practices

### Agent Usage

- Use specific commands (`/readme`, `/devops`) for focused tasks
- Reference agent templates for complex, multi-step operations
- Combine agents for comprehensive workflows (e.g., create pipeline + update README)

### Maintenance

- Keep agent templates updated with latest best practices
- Review and refresh usage examples periodically
- Validate agent effectiveness and scope regularly
- Update command documentation as agents evolve

### Windows-Specific Considerations

- All agents are optimized for Windows development environments
- PowerShell is the primary shell for script execution
- Path handling uses Windows conventions
- Integration with Windows development tools (Visual Studio, Azure CLI)

## Troubleshooting

### Common Issues

- **Agent not found**: Ensure symbolic links are created with `configure.ps1`
- **Command not working**: Verify Claude Code configuration and restart if needed
- **PowerShell execution**: Ensure execution policy allows script running

### Support Resources

- Agent template files contain detailed documentation
- Command files provide specific usage instructions
- Claude Code documentation: [Claude Code Documentation](https://docs.anthropic.com/claude/docs)
- Main project README.md for comprehensive setup and usage information

## Contributing

When contributing new agents or improvements:

1. Use `/new-agent` to design new agents properly (invokes `claude-agent-specialist`)
2. Follow the established naming and structure conventions
3. Test agents thoroughly in Windows development scenarios
4. Use `/readme` to update documentation when adding new agents or capabilities
5. Ensure documentation accuracy and completeness through agent validation workflows