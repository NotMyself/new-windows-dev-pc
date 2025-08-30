# Claude Code Settings Directory

This directory contains the Claude Code configuration, agents, and documentation for the Windows development environment setup. The structure is organized for clarity, security, and team collaboration with comprehensive 1Password integration for secure secret management.

## Directory Structure

```
settings/claude/
├── README.md                           # This file - overview and usage guide
├── settings.json                       # Main Claude settings (Windows)
├── settings-wsl.json                   # WSL-specific settings (Linux)
├── configure-claude-windows-11.ps1     # Configuration script
├── agents/                             # Claude Code agents
│   ├── azure-devops.md                 # Azure DevOps workflows and API integration
│   ├── command-expert.md               # CLI command development
│   ├── csharp.md                       # C# development specialist
│   ├── markdown.md                     # Markdown creation and formatting
│   ├── mstest.md                       # .NET testing with MSTest
│   └── meta/                           # Agent management tools
│       ├── agent-expert.md             # For creating new agents
│       ├── feature-prompt.md           # Feature documentation specialist
│       ├── mcp-expert.md               # Model Context Protocol integrations
│       └── readme-maintainer.md        # README file management
├── config/                             # Configuration files
│   ├── markdown-style.json             # Markdown formatting rules
│   ├── markdownlint.json               # Markdown linting configuration
│   └── secrets/                        # 1Password integration guides
│       ├── 1password-setup.md          # Service account configuration
│       └── secrets-reference.md        # Available secrets catalog
└── templates/                          # Project templates
    ├── lib-project-readme-template.md  # Library project README template
    └── script-project-readme-template.md # Script project README template
```

## Quick Start

### For New Team Members

1. **Review Security Rules**: Start with [Ground Rules](#ground-rules) - understand what NEVER to do
2. **Setup 1Password**: Follow [1Password Setup Guide](config/secrets/1password-setup.md)
3. **Configure Claude Code**: Run `configure-claude-windows-11.ps1` as Administrator
4. **Test Integration**: Verify Azure DevOps workflows work correctly

### Common Usage Patterns

```powershell
# Access Azure DevOps functionality
# Claude will use the azure-devops agent automatically for DevOps tasks

# For C# development tasks
# Claude will use the csharp agent for .NET-related work

# For documentation tasks  
# Claude will use the markdown agent for formatting and linting
```

## Core Agents

### Domain-Specific Agents

#### 🔧 azure-devops
**Purpose**: Azure DevOps pipelines, work item management, and wiki integration  
**Key Features**:
- Sprint board organization and progress tracking
- YAML pipeline creation and troubleshooting
- Secure Azure DevOps API integration with 1Password
- Work item lifecycle management
- Azure CLI automation

**Example Usage**: Creating CI/CD pipelines, managing sprint backlogs, updating Azure DevOps wiki

#### ⚡ csharp  
**Purpose**: Modern C# development with latest language features and frameworks  
**Key Features**:
- C# 12+ language features and .NET 8+ frameworks
- Clean architecture and SOLID principles
- Entity Framework and modern ORM patterns
- Dependency injection and configuration management

**Example Usage**: Creating .NET applications, implementing design patterns, code refactoring

#### 📝 markdown
**Purpose**: Well-formed markdown creation following CommonMark and Azure DevOps standards  
**Key Features**:
- Automated formatting and linting
- Azure DevOps wiki compatibility
- Table formatting and code highlighting
- Link validation and structure optimization

**Example Usage**: Creating documentation, formatting README files, Azure DevOps wiki pages

#### 🧪 mstest
**Purpose**: .NET unit testing with MSTest.Sdk and NSubstitute  
**Key Features**:
- Comprehensive test coverage strategies
- Mock object patterns with NSubstitute
- Test organization and lifecycle management
- CI/CD integration for automated testing

**Example Usage**: Writing unit tests, setting up test automation, improving code coverage

#### ⚙️ command-expert
**Purpose**: CLI command development and automation  
**Key Features**:
- Command-line interface design patterns
- Argument parsing and validation
- Task automation and scripting
- Cross-platform compatibility considerations

**Example Usage**: Creating PowerShell scripts, designing CLI tools, automating repetitive tasks

### Meta-Level Agents

#### 🏗️ agent-expert
**Purpose**: Creating and designing new specialized Claude Code agents  
**Key Features**:
- Agent architecture and design patterns
- Prompt engineering for domain expertise
- Integration patterns with existing agents
- Best practices for agent development

#### 📋 feature-prompt
**Purpose**: Creating comprehensive feature specifications and requirements  
**Key Features**:
- Requirements engineering and analysis
- Acceptance criteria definition
- Technical specification writing
- Stakeholder communication templates

#### 🔌 mcp-expert
**Purpose**: Model Context Protocol integrations and server configurations  
**Key Features**:
- MCP server setup and configuration
- Protocol specification compliance
- Integration pattern implementation
- Custom MCP development guidance

#### 📚 readme-maintainer
**Purpose**: Strategic README file management and documentation maintenance  
**Key Features**:
- Bottom-up documentation processing
- Hierarchical content organization
- Cross-reference validation
- Documentation lifecycle management

## Security and 1Password Integration

### Ground Rules - NEVER BREAK THESE

**ABSOLUTE PROHIBITIONS:**
1. **NEVER commit a secret to source control** - No passwords, tokens, keys, or credentials in git repositories
2. **NEVER publish a secret to the wiki** - No sensitive information in Azure DevOps wiki pages  
3. **NEVER write a secret to a markdown file** - No credentials in documentation files
4. **ALWAYS use 1Password directions** - Instead of secrets, provide instructions to retrieve them securely

### Secret Management

The only secret stored locally is the 1Password service account token (`OP_SERVICE_ACCOUNT_TOKEN`) in Windows environment variables. All other secrets must be retrieved at runtime using 1Password CLI.

**Correct Pattern:**
```powershell
# ✅ Secure secret retrieval
$azurePAT = op item get "Azure-DevOps-PAT-Development" --field password

# ❌ NEVER do this
$azurePAT = "abc123xyz789"
```

See [1Password Setup Guide](config/secrets/1password-setup.md) for complete configuration instructions.

## Azure DevOps Integration

### Sprint Board Management

The azure-devops agent provides autonomous sprint board organization:

- **Work Item Creation**: Automated user story, task, and bug creation
- **Progress Tracking**: Status transitions (New → Active → Resolved → Closed)
- **Sprint Planning**: Backlog grooming and capacity management
- **API Integration**: Secure Azure DevOps REST API calls using 1Password secrets

### Common Workflows

1. **Creating Work Items**: Agent handles proper categorization and linking
2. **Pipeline Management**: YAML pipeline creation with security scanning
3. **Wiki Updates**: Documentation updates with cross-references
4. **Build Automation**: CI/CD integration with approval gates

## Configuration Management

### Settings Files

- **settings.json**: Main Claude Code configuration with permissions and MCP servers
- **settings-wsl.json**: WSL-specific overrides for Linux compatibility
- **Environment Variables**: Secure secret management via 1Password integration

### MCP Servers

Configured Model Context Protocol servers:
- **filesystem**: File operations with directory access controls
- **memory**: Persistent memory for conversation context
- **sequential-thinking**: Structured reasoning and problem-solving
- **context7**: Advanced context management and retrieval

### Permissions

Claude Code permissions are configured for specific tool access:
- Azure CLI operations (`az:*`)
- 1Password CLI operations (`op:*`) 
- Development tools (dotnet, npm, git)
- Documentation tools (prettier, markdownlint)

## Development Workflows

### Team Collaboration

1. **Onboarding**: New team members follow setup documentation
2. **Security Training**: Understanding of secret management rules
3. **Agent Usage**: Leveraging specialized agents for domain tasks
4. **Documentation**: Maintaining current and accurate guides

### Quality Assurance

- **Automated Testing**: Agents integrate with testing frameworks
- **Code Review**: Consistent patterns and security compliance
- **Documentation Updates**: Agents maintain current documentation
- **Secret Rotation**: Quarterly review of 1Password integration

## Troubleshooting

### Common Issues

**Agent Loading Problems:**
- Verify `CLAUDE_AGENTS_PATH` environment variable
- Check nested directory structure (`agents/meta/`)
- Validate agent file formats and headers

**1Password Authentication:**
- Verify `OP_SERVICE_ACCOUNT_TOKEN` is set
- Test CLI authentication: `op vault list`
- Check service account vault permissions

**Azure DevOps Integration:**
- Validate PAT permissions and expiration
- Test API connectivity with minimal calls
- Review Azure DevOps service connection status

### Getting Help

1. **Documentation**: Review specific agent documentation in `/agents/` directory
2. **1Password Issues**: See [troubleshooting section](config/secrets/1password-setup.md#troubleshooting)
3. **Azure DevOps**: Check Azure DevOps specialist agent documentation
4. **General Issues**: Review Claude Code main documentation

## Maintenance

### Documentation Updates

- **Quarterly Reviews**: Update Azure DevOps API documentation
- **Version Tracking**: Monitor Claude Code and dependency updates  
- **Error Analysis**: Track common workflow failures and improvements
- **Team Feedback**: Incorporate user experience improvements

### Agent Evolution

- **New Capabilities**: Add agents for emerging development needs
- **Deprecation**: Remove or consolidate redundant functionality
- **Integration**: Improve cross-agent collaboration patterns
- **Security**: Regular review of secret handling procedures

---

**Last Updated**: January 2025 - Updated for Claude settings reorganization
**Maintained By**: Development Team Lead  
**Security Review**: Quarterly