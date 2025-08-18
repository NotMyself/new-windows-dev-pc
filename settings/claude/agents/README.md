# Claude Code Agents Configuration

This directory contains specialized agents for the Windows development setup automation repository. These agents provide domain-specific expertise and follow modern best practices for their respective areas.

## Overview

The Claude Code configuration in this repository includes:
- **Specialized Agents**: Expert agents for specific development tasks
- **Custom Commands**: Quick access commands that utilize the agents
- **PowerShell Integration**: Optimized for Windows development workflows
- **MCP Server Configuration**: Integration with development tools and services

## Available Agents

### 🔧 agent-architect

**Purpose**: Meta-agent that designs and creates other specialized agents with proper structure, validation, and best practices.

**Tools**: Read, Write, Glob, Grep
**Command**: `/agent-architect`

**Key Capabilities**:

- Agent design and architecture planning
- Template creation following Claude Code standards
- Validation and best practice enforcement
- YAML frontmatter format compliance
- Naming convention and uniqueness checks

**Usage Examples**:

```text
"Create a new agent for database operations and SQL optimization"
"Design an agent specialized in React component testing"
"Validate the structure of existing agents in the repository"
```

### ☁️ azure-devops-specialist

**Purpose**: Azure DevOps specialist for pipelines, builds, releases, and project management operations.

**Tools**: Bash, WebSearch, Read, Write, Edit, MultiEdit, Grep, Glob
**Command**: `/azure-devops`

**Key Capabilities**:

- YAML pipeline creation and optimization
- Azure CLI automation and scripting
- Build agent and deployment configuration
- Security scanning and compliance implementation
- Modern CI/CD pattern implementation (2024-2025)

**Usage Examples**:

```text
"Create a CI/CD pipeline for this .NET application with Azure Artifacts publishing"
"Set up branch policies and pull request validation for the main branch"
"Configure automated security scanning in our build pipeline"
"Help troubleshoot this failing Azure DevOps pipeline YAML"
```

### 📝 readme-maintainer

**Purpose**: Updates and maintains README.md files with modern documentation best practices.

**Tools**: Read, Edit, MultiEdit, Glob, Grep
**Command**: `/readme`

**Key Capabilities**:

- README analysis and gap identification
- Modern documentation standards implementation
- Structure optimization with scannable sections
- Badge integration and status indicators
- Cross-platform compatibility considerations

**Usage Examples**:

```text
"Update the README.md file to include proper installation instructions"
"Analyze this project's README and identify missing sections"
"Create a comprehensive README following modern best practices"
```

### 🧪 dotnet-test-specialist

**Purpose**: .NET unit testing specialist using MSTest.Sdk and NSubstitute for component testing.

**Tools**: Read, Write, Edit, MultiEdit, Bash, Grep, Glob
**Command**: `/dotnet-test`

**Key Capabilities**:

- MSTest.Sdk framework test generation and structure
- NSubstitute mocking and dependency isolation
- Component testing with realistic scenarios
- Async/await testing patterns and best practices
- Test architecture following .NET testing standards
- Test execution and coverage analysis

**Usage Examples**:

```text
"Generate unit tests for this service class using MSTest and NSubstitute"
"Create component tests for this controller with mocked dependencies"
"Write async tests for this repository class using MSTest framework"
"Set up a test project structure for this .NET application"
```

## Agent Workflow Integration

The agents in this repository are designed to work together as an integrated workflow system, with each agent capable of calling others to ensure comprehensive and properly formatted results:

### Workflow Chain

- **agent-architect**: Creates new specialized agents and automatically calls `readme-maintainer` to update documentation when new agents are added
- **readme-maintainer**: Updates and maintains README files following modern documentation best practices, then calls `markdown-specialist` for final formatting and linting
- **markdown-specialist**: Ensures proper markdown formatting, syntax validation, and adherence to linting standards for all documentation files

### Benefits of Integrated Workflow

- **Consistency**: All documentation follows the same formatting standards through the markdown-specialist
- **Completeness**: Agent creation automatically triggers documentation updates
- **Quality Assurance**: Multiple validation layers ensure high-quality output
- **Automation**: Reduces manual steps and ensures best practices are consistently applied

### Example Workflow

When creating a new agent:
1. User invokes `/agent-architect` to create a new specialized agent
2. agent-architect designs and creates the agent file
3. agent-architect automatically calls readme-maintainer to update documentation
4. readme-maintainer updates the README with the new agent information
5. readme-maintainer calls markdown-specialist to format and lint the updated documentation
6. Final result: New agent created with properly formatted and validated documentation

## Configuration Details

### Global Settings

The Claude Code configuration (`settings.json`) includes:

- **Shell Integration**: PowerShell as the default shell for Windows compatibility
- **Agent Path**: `.claude/agents` for agent discovery
- **Permissions**: Controlled access to PowerShell execution and documentation domains

### Command Integration

Each agent has a corresponding command file in `settings/claude/commands/`:

- **Quick Access**: Use `/agent-name` for rapid agent invocation
- **Tool Documentation**: Each command file documents available tools and capabilities
- **Usage Examples**: Real-world scenarios for each agent

## Usage Instructions

### Method 1: Direct Commands (Recommended)
```shell
# Update README with modern best practices
/readme

# Create or improve agents
/agent-architect

# Azure DevOps operations
/azure-devops

# .NET testing and unit test generation
/dotnet-test
```

### Method 2: Agent Reference

When working with general-purpose responses, reference agent expertise:

```text
"Following the guidelines in readme-maintainer.md, update this README..."
"Use the azure-devops-specialist approach to create a pipeline for..."
"Apply agent-architect principles to design a new testing agent..."
```

### Method 3: Manual Agent Templates

For complex tasks, copy and adapt agent templates:

1. Read the relevant agent file for specialized knowledge
2. Apply the agent's working process and best practices
3. Follow the output standards and guidelines

## Agent Development

### Creating New Agents

Use the agent-architect for new agent creation:

```shell
/agent-architect "Create an agent for [specific domain/task]"
```

### Agent Requirements

All agents must follow these standards:

- **YAML Frontmatter**: `name`, `description`, `tools` fields only
- **Naming Convention**: kebab-case (lowercase-with-hyphens)
- **File Location**: `settings/claude/agents/[agent-name].md`
- **Structure**: Follow the agent-architect template exactly

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

- NuGet package management
- .NET CLI operations
- Azure service integration
- Git repository operations
- SQL Server management

## Best Practices

### Agent Usage

- Use specific commands (`/readme`, `/azure-devops`) for focused tasks
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
- Claude Code documentation: [Claude Code Documentation](https://docs.anthropic.com)

## Contributing

When contributing new agents or improvements:

1. Use `/agent-architect` to design new agents properly
2. Follow the established naming and structure conventions
3. Test agents thoroughly in Windows development scenarios
4. Update this README when adding new agents or capabilities
5. Ensure documentation accuracy and completeness