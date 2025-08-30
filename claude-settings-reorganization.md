# Claude Settings Directory Reorganization Plan

## Overview

Reorganize the `settings/claude` directory to improve organization, reduce confusion, and minimize errors when working with Azure DevOps, company wiki, and development workflows.

## Current Problems

### Structure Issues
- **Inconsistent Organization**: Commands and agents directories overlap in functionality
- **Redundant Indirection**: Commands mostly just reference agents without adding value
- **Mixed File Types**: Configuration files mixed with agent definitions in `agents/` directory
- **Unclear Separation**: Similar functionality split across commands/agents without clear purpose

### Workflow Confusion
- Users unsure whether to use commands or agents directly
- Azure/DevOps workflows scattered across multiple files
- Configuration files buried in wrong directories
- Template files not easily discoverable

### Error-Prone Areas
- Duplicate functionality between commands and agents
- Inconsistent naming conventions
- Missing clear entry points for common tasks
- Configuration drift between related files

### Azure DevOps Specific Issues
- **Authorization Confusion**: Claude forgets how to properly authenticate with DevOps APIs
- **Malformed API Requests**: Errors when interacting with sprint board and wiki
- **Workflow Documentation Gap**: Missing clear procedures for sprint board management
- **Progress Tracking Failures**: Unable to autonomously update work item progress
- **Secrets Management Gaps**: Missing procedures for secure 1Password integration and secret retrieval

## Proposed New Structure

```
settings/claude/
├── README.md                           # Overview and usage guide
├── settings.json                       # Main Claude settings  
├── settings-wsl.json                   # WSL-specific settings
├── configure-claude-windows-11.ps1     # Configuration script
├── agents/                             # Core domain agents
│   ├── azure-devops.md                 # Renamed from azure-devops-specialist
│   ├── csharp.md                       # Renamed from csharp-specialist  
│   ├── markdown.md                     # Renamed from markdown-specialist
│   ├── mstest.md                       # Renamed from mstest-specialist
│   ├── command-expert.md               # For creating CLI commands (moved from meta)
│   └── meta/                           # Agent management tools
│       ├── agent-expert.md             # For creating new agents
│       ├── feature-prompt.md           # For feature documentation (renamed)
│       ├── mcp-expert.md               # For MCP integrations
│       └── readme-maintainer.md        # For README management
├── config/                             # Configuration files
│   ├── markdown-style.json             # Moved from agents/
│   ├── markdownlint.json               # Moved from agents/
│   └── secrets/                        # 1Password integration guides
│       ├── 1password-setup.md          # Service account configuration
│       └── secrets-reference.md        # Available secrets catalog
└── templates/                          # Project templates
    ├── lib-project-readme-template.md
    └── script-project-readme-template.md
```

## Migration Tasks

### 1. Directory Structure Changes
- **Remove**: `commands/` directory entirely
- **Create**: `config/` directory for configuration files  
- **Create**: `agents/meta/` subdirectory for meta-agents
- **Rename**: Agent files to remove "-specialist" suffix where appropriate

### 2. File Movements
- Move `agents/markdown-style.json` → `config/markdown-style.json`
- Move `agents/markdownlint.json` → `config/markdownlint.json`
- Move meta-agents to `agents/meta/` subdirectory:
  - `agent-expert.md`
  - `feature-prompt-specialist.md` → `feature-prompt.md`
  - `mcp-expert.md`
  - `readme-maintainer.md`
- Keep `command-expert.md` in main `agents/` directory (core development agent)
- Create new `config/secrets/` directory with 1Password documentation

### 3. File Renames
- `azure-devops-specialist.md` → `azure-devops.md`
- `csharp-specialist.md` → `csharp.md`
- `markdown-specialist.md` → `markdown.md`
- `mstest-specialist.md` → `mstest.md`

### 4. Content Updates
- Update agent names in file headers to match new filenames
- Update all cross-agent references (41 instances found using `subagent_type` parameter)
- Update agent references from:
  - `csharp-specialist` → `csharp`
  - `azure-devops-specialist` → `azure-devops`  
  - `markdown-specialist` → `markdown`
  - `mstest-specialist` → `mstest`
- Update `settings.json` agent paths if necessary
- Create comprehensive `README.md` with usage guidelines

### 5. Configuration Updates
- Verify `CLAUDE_AGENTS_PATH` in settings points to correct directory
- Update `configure-claude-windows-11.ps1` line 279 if needed
- Update any scripts that reference old command structure
- Test agent loading after reorganization
- Validate MCP server configurations still work
- Maintain existing symlink structure (`settings/claude/` → `~/.claude/`)

## Benefits

### Improved Organization
- **Clear Separation**: Agents, configs, and templates properly segregated
- **Logical Grouping**: Meta-agents separated from domain-specific ones
- **Better Discoverability**: Templates and configs in obvious locations
- **Consistent Naming**: Shorter, clearer agent names

### Reduced Confusion  
- **Single Entry Point**: Use agents directly instead of commands wrapper
- **Clear Purpose**: Each directory has single, well-defined purpose
- **Obvious Hierarchy**: Meta-agents clearly distinguished from domain agents
- **Better Documentation**: Centralized README with usage patterns

### Error Reduction
- **No Duplication**: Eliminates command/agent redundancy
- **Consistent Structure**: Predictable file locations
- **Clear Relationships**: Obvious dependencies between components
- **Easier Maintenance**: Simpler structure to update and maintain

## Implementation Steps

1. **Pre-Migration Validation**: 
   - Check for local allow list customizations in `~\.claude\settings.json`
   - Merge any local permissions into main settings file
   - Test nested directory agent loading capability
2. **Backup Current Structure**: Create backup of existing `settings/claude` directory
3. **Create New Directories**: Set up new `config/` and `agents/meta/` directories  
4. **Move Files**: Relocate files according to migration plan
5. **Rename Files**: Update filenames to new naming convention (following lowercase-hyphen pattern)
6. **Update Content**: Modify file contents for new structure
7. **Cross-Reference Validation**: Test all 41 `subagent_type` references work correctly
8. **Agent Loading Test**: Verify Claude loads agents from nested directories
9. **Update Documentation**: Create comprehensive README
10. **Clean Up**: Remove old `commands/` directory
11. **Full Workflow Validation**: Test complete Azure/DevOps workflows end-to-end

## Success Criteria

- All agents load correctly in new structure
- Azure DevOps workflows execute without errors  
- Configuration files properly located and accessible
- Templates easily discoverable for new projects
- README provides clear usage guidance
- No broken references or missing dependencies

### Primary Success Metrics
- **Sprint Board Management**: Claude can autonomously organize work in Azure DevOps sprint board
- **Progress Tracking**: Automated updating of work item progress as tasks are completed
- **API Authentication**: Consistent, error-free Azure DevOps API authentication
- **Team Readiness**: Structure works for any new team member joining
- **Workflow Documentation**: Clear, executable procedures for common DevOps tasks

## Implementation Strategy

### Branch-Based Development
- **Work in Git Branch**: All reorganization work done in feature branch
- **Clean Migration**: Delete old files and create new ones (no git history preservation needed)
- **No Rollback Complexity**: Branch approach eliminates rollback concerns
- **Safe Testing**: Full validation before merging to main branch

## Risk Mitigation

- **Git Branch Safety**: All work isolated in feature branch
- **Incremental Migration**: Move and test one component at a time
- **Validation Testing**: Test each agent after migration
- **Performance Baseline**: Current performance acceptable, no measurement needed
- **Documentation**: Document any issues discovered during migration

### Team Considerations
- **Single User Currently**: Only one user currently, but structure designed for team scalability
- **No Communication Plan Needed**: Personal setup with team-ready design
- **MCP Integration**: Include guidance for leveraging MCP servers effectively

## Additional Deliverables

### Azure DevOps Workflow Documentation
As part of this reorganization, create comprehensive workflow documentation to address current authorization and API issues:

#### Sprint Board Management Workflows
- **Work Item Creation**: Step-by-step procedures for creating user stories, tasks, and bugs
- **Progress Updates**: Automated status transitions (New → Active → Resolved → Closed)
- **Sprint Planning**: Board organization and backlog grooming procedures
- **Capacity Management**: Team velocity tracking and sprint commitment

#### API Authentication Procedures
- **1Password Integration**: Secure retrieval of secrets using `op` CLI commands
- **Service Connection Setup**: Proper authentication configuration for DevOps APIs
- **Personal Access Token Management**: Secure token storage in 1Password and retrieval
- **Environment Variable Security**: Safe handling of `OP_SERVICE_ACCOUNT_TOKEN`
- **API Request Formatting**: Correct headers, endpoints, and payload structures with secure credentials
- **Error Handling**: Common API error scenarios and resolution steps

#### Wiki Integration Workflows
- **Page Creation**: Templates and procedures for documentation pages
- **Content Updates**: Version control integration with wiki updates
- **Cross-References**: Linking between wiki pages, work items, and code repositories
- **Permission Management**: Access control and sharing procedures

#### Quality Gates and Automation
- **Pipeline Integration**: Connecting work items to build/deployment status
- **Automated Notifications**: Status updates and stakeholder communication
- **Reporting Dashboards**: Progress visualization and metrics tracking

### MCP Server Usage Guide
Document how to effectively leverage the configured MCP servers:
- **Git Integration**: Using MCP git server for repository operations
- **PowerShell Automation**: Leveraging shell MCP for script execution
- **Filesystem Operations**: Secure file operations through MCP
- **Custom MCP Creation**: Guidelines for project-specific integrations

### 1Password Secrets Management
Create comprehensive documentation for secure secrets handling:

#### Environment Setup
- **Service Account Configuration**: Proper `OP_SERVICE_ACCOUNT_TOKEN` setup
- **CLI Installation**: 1Password CLI (`op`) installation and authentication
- **Vault Organization**: Best practices for organizing secrets in vaults
- **Permission Management**: Access control and sharing policies

#### Secret Retrieval Procedures  
- **Basic Commands**: `op item get "item-name" --field password` patterns
- **Environment Variables**: Secure injection of secrets into environment
- **Batch Operations**: Retrieving multiple secrets efficiently
- **Error Handling**: Graceful handling of authentication failures

#### Security Best Practices
- **Never Log Secrets**: Procedures to prevent accidental secret exposure
- **Session Management**: Proper authentication session handling
- **Token Rotation**: Service account token lifecycle management
- **Audit Trails**: Monitoring and logging secret access

#### Azure DevOps Integration
- **PAT Storage**: Personal Access Tokens in 1Password vaults
- **Service Connections**: Secure credential management for pipelines
- **Multi-Environment**: Development, staging, production secret separation
- **Team Access**: Shared vault management for team collaboration

## Ground Rules - NEVER BREAK THESE

### Secrets Security - ABSOLUTE PROHIBITIONS
1. **NEVER commit a secret to source control** - No passwords, tokens, keys, or credentials in git repositories
2. **NEVER publish a secret to the wiki** - No sensitive information in Azure DevOps wiki pages
3. **NEVER write a secret to a markdown file** - No credentials in documentation files
4. **ALWAYS use 1Password directions** - Instead of secrets, provide instructions to retrieve them securely using `op` CLI commands

### Local Secret Storage Rules
- **ONLY Exception**: The 1Password service account token (`OP_SERVICE_ACCOUNT_TOKEN`) is the ONLY secret stored locally
- **Storage Location**: Windows environment variables (User or System level)
- **Source of Truth**: Even the 1Password token itself is stored in 1Password vault
- **All Other Secrets**: Must be retrieved at runtime using `op` CLI commands from 1Password vaults

### Examples of What NOT To Do
```markdown
❌ WRONG - Never do this:
AZURE_PAT=abc123xyz789
DATABASE_PASSWORD=mySecretPass

✅ CORRECT - Do this instead:
AZURE_PAT=$(op item get "Azure DevOps PAT" --field password)
DATABASE_PASSWORD=$(op item get "Production DB" --field password)
```

### Security-First Documentation
- Document the **process** to retrieve secrets, not the secrets themselves
- Reference 1Password vault items by name, never by content
- Include error handling for authentication failures
- Always validate that secret retrieval commands work before documenting

## Documentation Maintenance Strategy

### Keeping Documentation Current
- **Quarterly Reviews**: Schedule regular reviews of Azure DevOps API documentation
- **Version Tracking**: Monitor Azure DevOps API version changes and update procedures
- **Error Logging**: Track common workflow failures and update documentation accordingly
- **Agent Updates**: When agents are modified, update related workflow documentation
- **1Password Changes**: Monitor 1Password CLI updates and adjust retrieval procedures

### Maintenance Responsibilities  
- **Owner**: Primary maintainer responsible for quarterly reviews
- **Validation**: Test documented procedures when Azure DevOps updates are released
- **User Feedback**: Collect and address issues from team members using the workflows
- **Automation**: Consider automated testing of documented API calls where possible

### Documentation Health Indicators
- **Success Rate**: Track workflow completion rates before/after documentation updates
- **Error Patterns**: Monitor recurring authorization or API errors
- **Usage Analytics**: Identify most/least used workflows for prioritized maintenance
- **Team Onboarding**: New team member success rate following documented procedures

This reorganization will create a cleaner, more intuitive structure that reduces errors and improves the development experience when working with Claude Code in Azure DevOps environments while maintaining absolute security standards and sustainable documentation practices.