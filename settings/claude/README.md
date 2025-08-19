# Claude Code Configuration

This directory contains the complete Claude Code configuration for the Windows development setup automation repository. It includes 7 specialized agents with sophisticated delegation intelligence and contextual decision-making frameworks, 7 corresponding slash commands, and global settings that provide domain-specific expertise for Windows development workflows following modern best practices and intelligent collaboration patterns.

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
- **7 Specialized Agents**: Expert agents for Azure DevOps, C# development, testing, documentation, and agent creation with sophisticated delegation intelligence
- **7 Slash Commands**: Quick access commands that directly invoke the specialized agents
- **PowerShell Integration**: Optimized for Windows development workflows with PowerShell as the default shell
- **Global Settings**: Shell configuration, permissions management, and web access controls
- **Intelligent Delegation Framework**: Each agent includes sophisticated decision-making capabilities for optimal sub-agent collaboration
- **Multi-Agent Workflows**: Seamless integration patterns that prevent duplication and maximize ecosystem efficiency

## Available Agents

### 🔧 claude-agent-specialist

**Purpose**: Meta-agent that designs and creates other specialized agents with proper structure, validation, sophisticated delegation intelligence, and best practices for optimal ecosystem integration.

**Tools**: Read, Write, Glob, Grep, Task
**Command**: `/new-agent`

**Key Capabilities**:

- Agent design and architecture planning with delegation intelligence
- Template creation following Claude Code standards with comprehensive sub-agent integration patterns
- Validation and best practice enforcement including delegation decision frameworks
- YAML frontmatter format compliance and Tool inclusion verification
- Naming convention and uniqueness checks across the agent ecosystem
- Sub-agent integration and workflow orchestration with contextual decision-making examples
- Advanced delegation pattern design to prevent ecosystem overlap and maximize efficiency

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

- YAML pipeline creation and optimization with intelligent delegation to .NET and testing specialists
- Azure CLI automation and scripting with context-aware Task tool integration
- Build agent and deployment configuration with sub-agent consultation for technical accuracy
- Security scanning and compliance implementation using specialist expertise when needed
- Modern CI/CD pattern implementation (2024-2025) with sophisticated delegation patterns
- Integration with .NET testing and deployment workflows through csharp-specialist and mstest-specialist collaboration

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
- SOLID principles, dependency injection, and clean architecture patterns with intelligent delegation for testing
- Modern async/await patterns with proper ConfigureAwait usage and mstest-specialist integration for async testing
- Integration with popular libraries (MediatR, FluentValidation, AutoMapper, Serilog, Carter) with automatic testing delegation
- Nullable reference types and null safety patterns with comprehensive test coverage via sub-agent collaboration
- Record types, pattern matching, and switch expressions with contextual decision-making for quality assurance
- Result patterns for error handling vs traditional exceptions with intelligent delegation to testing and documentation specialists

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

- MSTest.Sdk framework test generation with modern attributes and csharp-specialist integration for test target analysis
- NSubstitute mocking and dependency isolation patterns with intelligent delegation for complex scenarios
- Component testing vs unit testing methodologies with azure-devops-specialist integration for CI/CD pipeline testing
- Async/await testing patterns and best practices with contextual decision-making for test complexity
- Test architecture following .NET testing standards with sub-agent consultation for domain-specific testing needs
- Arrange-act-assert pattern implementation with sophisticated delegation to code and documentation specialists
- Test execution and coverage analysis with automatic CI/CD integration through azure-devops-specialist collaboration
- Parameterized testing with DataTestMethod and DataRow with intelligent formatting through markdown-specialist integration

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

- Requirements engineering principles and analysis with intelligent delegation to domain specialists
- Comprehensive feature documentation with all necessary sections and automatic markdown-specialist formatting
- Technical specifications with implementation guidance through csharp-specialist and azure-devops-specialist collaboration
- Clear, testable acceptance criteria and success metrics with mstest-specialist integration for testing strategy
- Context integration with existing codebases and architecture using sophisticated delegation patterns
- Testing strategy and quality assurance requirements with contextual decision-making for specialist consultation
- User story and acceptance criteria writing techniques with intelligent formatting delegation
- Technical documentation following industry standards with automatic quality assurance through sub-agent collaboration

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

- CommonMark and GitHub Flavored Markdown specification compliance with intelligent decision-making for complex formatting
- Markdown linting rules and markdownlint standards application with context-aware quality assurance
- Table formatting, alignment, and accessibility optimization using sophisticated formatting algorithms
- Code block syntax highlighting and language specification with domain-specific expertise integration
- Link validation, formatting, and accessibility enhancement with comprehensive cross-reference checking
- Header hierarchy optimization and document structure improvement with intelligent content organization patterns

**Usage Examples**:

```bash
/markdown "Format this markdown file to follow proper linting standards and fix any syntax issues"
/markdown "Create a well-structured markdown document for this project documentation"
/markdown "Reformat this markdown table to be properly aligned and accessible"
/markdown "Fix the markdown syntax in this file and ensure it follows CommonMark standards"
```

### 📖 readme-maintainer

**Purpose**: Updates and maintains README.md files with bottom-up hierarchical processing from deepest directories to root, featuring intelligent content extraction, automated summarization, and modern documentation best practices across nested directory structures.

**Tools**: Read, Edit, MultiEdit, Glob, Grep, Task
**Command**: `/readme`

**Key Capabilities**:

- **Bottom-Up Directory Discovery**: Discover ALL README.md files in the complete directory tree and calculate their nesting depth for proper processing order determination
- **Depth-Based Processing Order**: Process README files starting from deepest nested directories and working systematically up to root, ensuring proper dependency flow and hierarchical consistency
- **Intelligent Content Extraction**: Extract key information from already-processed child READMEs for parent-level summarization with accuracy validation and contextual integration
- **Intelligent Hierarchical Summarization**: Automatically create summary sections in parent READMEs that accurately reflect completed child documentation with proper content flow management and intelligent content distribution
- **Automated Content Extraction**: Extract primary purpose, key features, quantitative information, integration points, usage patterns, and unique value propositions from completed child READMEs for accurate parent-level summarization
- **Subdirectory Detection and Integration**: Systematically discover, analyze, and integrate content from all subdirectory READMEs using bottom-up dependency management and automated summarization workflows
- **Processing Order Tracking**: Maintain clear logging and tracking of processing order for transparency, debugging, and dependency validation throughout the entire hierarchy
- **Automated Content Distribution**: Ensure appropriate content distribution across hierarchy levels with detailed information flowing naturally into automatically generated parent summaries
- **Cross-linking and Navigation Management**: Build navigation and references that respect bottom-up processing dependencies with validated parent-child relationships and extracted context
- **Sequential Implementation**: Execute processing queue strictly in depth order with content extraction timing, dependency validation, and parent integration as each child completes
- **Quality Assurance Integration**: Leverage markdown-specialist for formatting validation across the entire processed hierarchy with summary accuracy verification
- **Modern Documentation Standards**: Implementation with sophisticated delegation patterns for optimal formatting, linting compliance, and technical accuracy across hierarchical structures

**Enhanced Processing Algorithm**:
1. **Complete Discovery**: Use Glob to find ALL README.md files recursively in the directory tree
2. **Depth Calculation**: Calculate directory nesting depth for each README file using path separator counting
3. **Processing Queue Creation**: Sort README files by depth (deepest first, shallowest last) to establish proper dependency order
4. **Sequential Bottom-Up Processing**: Process README files from most deeply nested to root, ensuring dependency order is maintained
5. **Intelligent Content Extraction**: Extract key information from completed child READMEs immediately for parent-level summarization integration using automated content detection algorithms
6. **Dependency Validation**: Ensure no README is processed until all its children are complete with processing order compliance
7. **Quality Assurance**: Delegate to markdown-specialist for final formatting validation across the entire processed hierarchy

**Usage Examples**:

```bash
/readme "Update the README documentation hierarchy using rigorous bottom-up processing to ensure proper dependency flow and accurate parent summaries extracted from completed child documentation"
/readme "Discover all README files, calculate directory depths, sort deepest-first, and process systematically from most nested to root with automated content extraction"
/readme "Create a hierarchical documentation system with bottom-up processing where detailed child READMEs are completed first, then summarized accurately in parent documentation"
/readme "Process the project documentation using strict bottom-up order with content extraction to ensure parent overviews accurately reflect completed child documentation through automated summarization"
/readme "Implement rigorous bottom-up README processing with directory depth calculation and automated summarization to ensure proper content distribution and accurate parent-child relationships"
/readme "Review all README files using comprehensive bottom-up processing with intelligent summarization to ensure they work together as a cohesive documentation system with accurate content flow"
```

## Agent Workflow Integration

The agents in this repository are designed to work together as an integrated workflow system with sophisticated delegation intelligence, with each agent capable of calling others via the Task tool using contextual decision-making frameworks to ensure comprehensive, properly formatted, and optimally efficient results:

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

- **Consistency**: All outputs follow established standards through specialized agents with intelligent delegation patterns
- **Completeness**: Multi-step workflows ensure comprehensive coverage of tasks with sophisticated decision-making
- **Quality Assurance**: Multiple validation layers with specialized expertise and contextual sub-agent consultation
- **Automation**: Reduces manual coordination between different aspects of development through smart delegation frameworks
- **Expertise Chaining**: Each agent contributes its specialized knowledge to the final result while preventing ecosystem overlap
- **Efficiency Optimization**: Intelligent delegation patterns maximize specialist utilization and minimize redundant work
- **Contextual Decision-Making**: Each agent includes sophisticated frameworks for determining when and how to delegate tasks

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
- **Web Access**: Allows fetching documentation from Anthropic's domain

### Command Integration

Each agent has a corresponding command file in `commands/` that creates slash commands:

| Command File      | Slash Command   | Agent Invoked                | Key Features                                              |
|-------------------|-----------------|------------------------------|----------------------------------------------------------|
| `csharp.md`       | `/csharp`       | `csharp-specialist`          | Modern C# development with intelligent delegation         |
| `devops.md`       | `/devops`       | `azure-devops-specialist`    | Azure DevOps operations with CI/CD integration          |
| `markdown.md`     | `/markdown`     | `markdown-specialist`        | Markdown formatting and linting compliance              |
| `mstest.md`       | `/mstest`       | `mstest-specialist`          | .NET unit testing with framework integration            |
| `new-agent.md`    | `/new-agent`    | `claude-agent-specialist`    | Meta-agent creation with delegation intelligence        |
| `new-feature.md`  | `/new-feature`  | `feature-prompt-specialist`  | Feature specification with contextual decision-making   |
| `readme.md`       | `/readme`       | `readme-maintainer`          | Bottom-up hierarchical processing with intelligent summarization and automated content extraction |

**Command Features**:

- **Quick Access**: Use `/command-name` for rapid agent invocation
- **Tool Documentation**: Each command file documents available tools and capabilities
- **Usage Examples**: Real-world scenarios for each agent

## Usage Instructions

### Method 1: Direct Commands (Recommended)
```bash
# Update README hierarchy with bottom-up processing, intelligent summarization, and automated content extraction
/readme

# Create or improve agents with delegation intelligence
/new-agent

# Azure DevOps operations with CI/CD integration
/devops

# Modern C# development with latest language features and testing integration
/csharp

# .NET testing and unit test generation with framework integration
/mstest

# Create comprehensive feature specifications with contextual decision-making
/new-feature

# Format and lint markdown documents with domain-specific expertise
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

### Project Integration

The Claude Code configuration is part of the Windows development setup automation:

- **Configuration Files**: Located in `settings/claude/` directory within the project
- **Agent Templates**: Specialized agents in `settings/claude/agents/` for development workflows
- **Slash Commands**: Quick access commands in `settings/claude/commands/` for agent invocation
- **Settings**: Global Claude Code configuration in `settings/claude/settings.json`

### PowerShell Profile Integration

The agents work seamlessly with the PowerShell profile's development tools:

- Git operations and repository management
- VSCode extension management
- Azure CLI automation
- .NET development and testing workflows
- Node.js development workflows

### Tool Integration

The agents integrate with Windows development tools through:

- **PowerShell**: Native shell integration for Windows development workflows
- **Azure CLI**: Cloud service integration and management via azure-devops-specialist
- **Git**: Repository operations through PowerShell and agent workflows
- **.NET CLI**: Build, test, and project operations via csharp-specialist and mstest-specialist
- **VSCode**: Integration through the project's PowerShell profile and development workflows

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