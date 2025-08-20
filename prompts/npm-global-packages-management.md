# Feature Prompt: Global NPM Packages Management System

## Executive Summary

### Overview

Implement a comprehensive global npm packages management system that integrates with the existing Windows developer setup automation repository. This feature will provide automated installation and management of essential global npm packages, ensuring consistency across developer environments.

### Business Justification

- **Consistency**: Standardize global npm packages across all developer workstations
- **Efficiency**: Reduce manual setup time for new developers by automating npm package installation
- **Maintainability**: Centralize global package management similar to existing VSCode extensions workflow
- **Integration**: Seamlessly integrate with existing fnm (Fast Node Manager) setup

### High-Level Scope

- Discovery mechanism for currently installed global npm packages
- New modular installation script following established architecture patterns
- Integration with fnm to ensure Node.js LTS is available before package installation
- Configuration file management for global packages list
- Administrator privilege management and error handling

## Functional Requirements

### FR-1: Global Package Discovery

The system must provide functionality to discover and export currently installed global npm packages on Windows machines.

**Details:**

- Scan for existing global npm packages using `npm list -g --depth=0`
- Export discovered packages to a standardized configuration file
- Handle cases where npm or Node.js is not installed
- Provide human-readable output of discovered packages

### FR-2: Global Package Installation Script

The system must include a new modular installation script that installs global npm packages from a configuration file.

**Details:**

- Follow existing architecture pattern (similar to `installs/vscode.ps1` and `installs/winget.ps1`)
- Read package list from configuration file in `settings/npm/` directory
- Install packages using `npm install -g` command
- Provide progress feedback and error handling for individual package installations
- Support package installation with specific versions when specified

### FR-3: Node.js/fnm Dependency Management

The system must ensure fnm has installed the LTS version of Node.js before attempting npm package installations.It should also make the LTS version the system default

**Details:**

- Verify fnm is available and configured
- Check if Node.js LTS is installed via fnm
- Install Node.js LTS if not present
- Make the LTS node version the system default
- Refresh environment to ensure npm is available in current session
- Handle cases where fnm is not configured or fails

### FR-4: Integration with Main Installation Flow

The new npm packages installation must integrate seamlessly with the existing installation workflow.

**Details:**

- Add npm packages installation step to main `install.ps1` script
- Provide optional parameter to skip npm packages installation
- Maintain proper execution order (after fnm installation, before VSCode extensions)
- Follow existing error handling and logging patterns

### FR-5: Configuration File Management

The system must provide a standardized way to manage the global npm packages list.

**Details:**

- Store packages list in `settings/npm/global-packages` file (similar to VSCode extensions)
- Support comments in configuration file for documentation
- Allow version pinning using standard npm syntax (package@version)
- Provide PowerShell profile function to backup currently installed packages

## Non-Functional Requirements

### NFR-1: Performance Requirements

- Package discovery should complete within 30 seconds on typical Windows machines
- Individual package installation should timeout after 2 minutes
- Total installation time should not exceed 10 minutes for typical package lists

### NFR-2: Security Requirements

- Administrator privileges must be verified before package installation
- Package sources must be from official npm registry only
- No execution of arbitrary scripts during package installation
- Proper error handling to prevent exposure of sensitive system information

### NFR-3: Reliability Requirements

- System must handle network connectivity issues gracefully
- Individual package installation failures must not stop overall process
- Provide clear error messages for common failure scenarios
- Support retry logic for transient network failures

### NFR-4: Compatibility Requirements

- Support Windows 10 and Windows 11
- Compatible with PowerShell 5.1 and PowerShell 7+
- Work with fnm-managed Node.js installations
- Support npm registry proxy configurations if present

### NFR-5: Maintainability Requirements

- Follow existing code patterns and naming conventions
- Include comprehensive inline documentation
- Provide debugging output for troubleshooting
- Support modular testing of individual components

## Acceptance Criteria

### AC-1: Package Discovery Functionality

**Given** a Windows machine with npm and global packages installed  
**When** the discovery function is executed  
**Then** it should:

- List all currently installed global packages
- Export the list to the appropriate configuration file
- Include package versions in the output
- Handle cases where no global packages are installed

### AC-2: Installation Script Execution

**Given** a configuration file with global npm packages  
**When** the installation script is executed  
**Then** it should:

- Verify Node.js/npm availability through fnm
- Install all packages listed in the configuration file
- Provide progress feedback for each package
- Complete successfully even if individual packages fail
- Log all installation results

### AC-3: Integration with Main Installation

**Given** the main installation script is executed  
**When** npm packages installation is enabled  
**Then** it should:

- Execute after fnm installation
- Respect skip parameters
- Follow established error handling patterns
- Integrate seamlessly with existing workflow

### AC-4: Error Handling and Recovery

**Given** various error conditions (network issues, missing dependencies, etc.)  
**When** the npm packages installation is attempted  
**Then** it should:

- Provide clear error messages
- Continue with remaining packages after individual failures
- Exit gracefully without corrupting system state
- Log sufficient information for troubleshooting

### AC-5: PowerShell Profile Integration

**Given** the PowerShell profile is loaded  
**When** the backup function is executed  
**Then** it should:

- Export currently installed global packages
- Update the configuration file with current state
- Provide confirmation of successful backup
- Handle cases where npm is not available

## Technical Specifications

### Architecture Integration

The npm packages management system will integrate with existing architecture:

```
install.ps1 (main)
├── installs/install-winget.ps1
├── installs/winget.ps1 (includes fnm)
├── installs/npm-global.ps1 (NEW)
└── installs/vscode.ps1
```

### Configuration File Structure

Location: `settings/npm/global-packages`

Format:
```
# Essential development tools
@angular/cli
create-react-app
typescript
eslint
prettier
nodemon
pm2
http-server

# Optional but useful
@vue/cli
gatsby-cli
vercel
netlify-cli

# Version pinned packages
webpack@5.88.0
jest@29.5.0
```

### Script Architecture

**File:** `installs/npm-global.ps1`

```powershell
# Header with parameter validation
# fnm/Node.js availability check
# Configuration file reading
# Package installation loop with error handling
# Installation result reporting
```

### Integration Points

#### Main Installation Script

Add to `install.ps1` after fnm installation:

```powershell
# Install global npm packages
if (-not $SkipNpmPackages -and (Test-Command 'fnm')) {
    Write-Step "Installing global npm packages..."
    & "$PSScriptRoot\installs\npm-global.ps1"
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Some npm packages may have failed to install. Check the output above."
    }
} elseif (-not $SkipNpmPackages) {
    Write-Warning "fnm not found. Skipping npm packages installation."
}
```

#### PowerShell Profile Addition

Add to `settings/pwsh/Microsoft.PowerShell_profile.ps1`:
```powershell
function backup-npm {
    $ProfilePath = Get-Item $profile | Select-Object -ExpandProperty Target
    $PackageFile = [System.IO.Path]::GetDirectoryName($ProfilePath) + '\..\npm\global-packages'
    npm list -g --depth=0 --parseable | ForEach-Object {
        if ($_ -match 'node_modules\\(.+)$') {
            $matches[1]
        }
    } | Where-Object { $_ -ne 'npm' } | Sort-Object > $PackageFile
}
```

### Error Handling Strategy

1. **Dependency Verification**: Check fnm and npm availability before proceeding
2. **Network Resilience**: Implement retry logic for npm install commands
3. **Graceful Degradation**: Continue with remaining packages if individual installations fail
4. **Comprehensive Logging**: Provide detailed output for troubleshooting
5. **Environment Validation**: Verify npm registry accessibility

### Testing Strategy

#### Unit Testing Components

- Package discovery functionality
- Configuration file parsing
- Individual package installation
- Error handling scenarios

#### Integration Testing Scenarios

- Fresh Windows installation with no Node.js
- Existing Node.js installation via different methods
- Network connectivity issues
- Corrupted configuration files
- Permission-related failures

## Implementation Guidance

### Development Phases

#### Phase 1: Core Script Development

1. Create `installs/npm-global.ps1` with basic functionality
2. Implement fnm/Node.js verification
3. Add configuration file reading
4. Implement package installation loop

#### Phase 2: Integration and Configuration

1. Create `settings/npm/global-packages` configuration file
2. Integrate with main `install.ps1` script
3. Add PowerShell profile backup function
4. Implement administrator privilege checks

#### Phase 3: Error Handling and Polish

1. Add comprehensive error handling
2. Implement retry logic for network issues
3. Add detailed logging and progress reporting
4. Optimize performance and user experience

#### Phase 4: Testing and Documentation

1. Test on various Windows configurations
2. Validate integration with existing workflows
3. Update documentation and help text
4. Perform security review

### Code Patterns from Existing Codebase

**Administrator Privilege Check Pattern:**

```powershell
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Handle elevation request
}
```

**Command Availability Check Pattern:**

```powershell
function Test-Command {
    param([string]$CommandName)
    return [bool](Get-Command -Name $CommandName -ErrorAction SilentlyContinue)
}
```

**Progress Reporting Pattern:**

```powershell
function Write-Step {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor Cyan
}
```

### Suggested Initial Package List

Based on common development needs:
```
# JavaScript/Node.js essentials
typescript
eslint
prettier
nodemon
http-server

# Build tools
webpack-cli
vite

# Testing
jest

# Development servers
lite-server
browser-sync

# Package management
npm-check-updates
```

## Testing and Validation

### Functional Testing

#### Test Case 1: Fresh Installation

- **Scenario**: New Windows machine without Node.js or npm
- **Expected**: fnm installs Node.js LTS, then installs global packages
- **Validation**: Verify packages are accessible via global npm commands

#### Test Case 2: Existing Node.js Installation

- **Scenario**: Machine with Node.js installed outside of fnm
- **Expected**: System detects existing npm and proceeds with package installation
- **Validation**: Packages install successfully without conflicts

#### Test Case 3: Network Connectivity Issues

- **Scenario**: Intermittent network connectivity during installation
- **Expected**: System retries failed installations and continues with others
- **Validation**: Partial installation completes successfully

#### Test Case 4: Configuration File Variations

- **Scenario**: Configuration file with comments, version pins, and empty lines
- **Expected**: System parses file correctly and installs appropriate versions
- **Validation**: Correct package versions are installed

### Integration Testing

#### Test Case 5: Full Installation Workflow

- **Scenario**: Complete execution of `install.ps1` including npm packages
- **Expected**: All components install in correct order without conflicts
- **Validation**: Full developer environment is ready for use

#### Test Case 6: Skip Parameters

- **Scenario**: Installation with `-SkipNpmPackages` parameter
- **Expected**: npm packages installation is bypassed
- **Validation**: Other installations complete normally

### Performance Testing

#### Test Case 7: Large Package List Performance

- **Scenario**: Configuration file with 20+ global packages
- **Expected**: Installation completes within performance requirements
- **Validation**: Total time under 10 minutes, individual timeouts respected

### Security Testing

#### Test Case 8: Administrator Privileges

- **Scenario**: Execution without administrator privileges
- **Expected**: System requests elevation or fails gracefully
- **Validation**: No unauthorized system modifications

#### Test Case 9: Malicious Package Names

- **Scenario**: Configuration file with invalid or suspicious package names
- **Expected**: npm registry validation catches malicious packages
- **Validation**: Only legitimate packages are installed

## Success Metrics

### Quantitative Metrics

- **Installation Success Rate**: >95% for individual packages under normal conditions
- **Performance**: Complete installation under 10 minutes for typical package lists
- **Error Recovery**: >90% success rate after retry for network-related failures
- **Integration**: Zero conflicts with existing installation workflow

### Qualitative Metrics

- **Developer Experience**: Seamless integration with existing setup process
- **Maintainability**: Code follows established patterns and is easily extensible
- **Documentation**: Clear documentation and help text for troubleshooting
- **Reliability**: Consistent behavior across different Windows configurations

## Documentation Requirements

### User Documentation

- Update main README.md with npm packages management information
- Add section explaining configuration file format and customization
- Include troubleshooting guide for common npm installation issues
- Document PowerShell profile functions for package management

### Developer Documentation

- Inline code documentation following existing patterns
- Architecture decision records for design choices
- Testing documentation with example scenarios
- Deployment and configuration guidelines

### API Documentation

- PowerShell function signatures and parameters
- Configuration file schema and validation rules
- Error codes and troubleshooting information
- Integration points with existing scripts

## Meta-Agent Integration Requirements

This feature prompt should leverage the following specialized agents during implementation:

### Required Agent Collaborations

1. **PowerShell Development**: Leverage PowerShell expertise for optimal script implementation
2. **Windows Environment**: Ensure proper Windows integration and administrator privilege handling
3. **Node.js/npm Integration**: Specialized knowledge for npm and fnm integration patterns
4. **Testing Strategy**: Comprehensive testing approach for npm package installations
5. **Documentation Updates**: Professional documentation updates reflecting new capabilities

### Agent Delegation Points

- **Script Architecture**: Consult PowerShell specialists for optimal script structure
- **Error Handling**: Leverage Windows development expertise for robust error handling
- **Testing Implementation**: Specialized testing strategy development
- **Documentation**: Professional documentation formatting and README updates
- **Integration Review**: Architecture review for seamless integration with existing codebase

This comprehensive feature prompt provides the foundation for implementing a robust global npm packages management system that integrates seamlessly with the existing Windows developer setup automation repository.