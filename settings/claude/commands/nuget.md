# NuGet Package Manager

Comprehensive NuGet package management for $ARGUMENTS with support for search, install, update, list, and remove operations using the NuGet MCP server integration.

## Task

I'll perform NuGet package management operations including:

1. Package search and discovery with detailed metadata
2. Installation and removal of packages in projects
3. Package updates with version management
4. Listing installed packages with dependency analysis
5. Global package operations and cache management
6. Integration with NuGet MCP server for enhanced functionality

## Process

I'll follow these steps:

1. Parse command arguments and validate operation type
2. Initialize NuGet MCP server connection if available
3. Execute the requested operation with proper error handling
4. Provide comprehensive feedback and next steps
5. Update project files and restore packages as needed

## Command Structure

The command supports these subcommands and arguments:

### Basic Operations
- `nuget search <query>` - Search for packages matching query
- `nuget install <package> [version]` - Install package to current project
- `nuget update <package>` - Update package to latest version
- `nuget list` - List installed packages in current project
- `nuget remove <package>` - Remove package from current project

### Advanced Operations
- `nuget list --global` - List globally installed packages
- `nuget install --global <package>` - Install package globally
- `nuget update --all` - Update all packages in project
- `nuget restore` - Restore all packages for project
- `nuget info <package>` - Show detailed package information

### Scope Options
- `--project <path>` - Target specific project file
- `--solution <path>` - Target entire solution
- `--global` - Perform global package operations
- `--source <url>` - Use custom package source

### Version Options
- `--version <version>` - Specify exact version
- `--prerelease` - Include prerelease versions
- `--latest` - Force latest version

### Output Options
- `--json` - Output results in JSON format
- `--verbose` - Show detailed operation logs
- `--dry-run` - Preview changes without execution

## Operation Types

### Package Search

I'll search the NuGet repository for packages matching your query:

**Features:**
- Fuzzy matching on package names and descriptions
- Filter by package type, author, and tags
- Sort by relevance, download count, or publication date
- Display package metadata including dependencies
- Show compatible framework versions

**Example Output:**
```
📦 Newtonsoft.Json (13.0.3)
   📝 Popular high-performance JSON framework for .NET
   👤 James Newton-King
   📊 Downloads: 2.1B | Latest: 2023-03-17
   🎯 Frameworks: .NET Standard 2.0, .NET Framework 4.5+
   
📦 System.Text.Json (8.0.0)
   📝 High-performance JSON serializer for .NET
   👤 Microsoft
   📊 Downloads: 890M | Latest: 2023-11-14
   🎯 Frameworks: .NET Standard 2.0, .NET 6.0+
```

### Package Installation

I'll install packages with comprehensive dependency resolution:

**Process:**
1. Resolve package dependencies and version conflicts
2. Check framework compatibility
3. Download packages and dependencies
4. Update project file with package references
5. Restore packages and verify installation

**Safety Checks:**
- Verify package authenticity and signatures
- Check for known security vulnerabilities
- Validate license compatibility
- Warn about deprecated packages

### Package Updates

I'll update packages with intelligent version management:

**Update Strategies:**
- **Patch updates**: Bug fixes only (1.0.0 → 1.0.1)
- **Minor updates**: New features, backward compatible (1.0.0 → 1.1.0)
- **Major updates**: Breaking changes (1.0.0 → 2.0.0)

**Process:**
1. Analyze current package versions
2. Check for available updates
3. Evaluate breaking change risks
4. Present update options with impact assessment
5. Execute updates with rollback capability

### Package Listing

I'll provide comprehensive package inventory:

**Information Displayed:**
- Package name and current version
- Available updates with change summaries
- Dependency tree and conflicts
- Framework compatibility
- Installation date and source
- License and security status

**Filtering Options:**
- By framework target
- By update availability
- By package source
- By installation scope

### Package Removal

I'll safely remove packages with dependency analysis:

**Safety Process:**
1. Identify dependent packages
2. Check for orphaned dependencies
3. Preview removal impact
4. Execute removal with cleanup
5. Verify project still builds

## MCP Integration

### NuGet MCP Server Features

I'll leverage the @microsoft/nuget-mcp-server for enhanced functionality:

**Enhanced Search:**
- Semantic search with AI-powered relevance
- Package recommendation based on project type
- Vulnerability and compatibility analysis
- License and compliance checking

**Smart Installation:**
- Automatic dependency conflict resolution
- Framework target optimization
- Performance impact analysis
- Security audit integration

**Advanced Management:**
- Batch operations across multiple projects
- Package usage analytics
- Update scheduling and automation
- Custom package source management

### Server Configuration

If MCP server is available, I'll configure it with:

**Connection Settings:**
- Server endpoint and authentication
- Package source prioritization
- Cache configuration
- Security policy enforcement

**Operation Modes:**
- **Online**: Full server integration with real-time data
- **Cached**: Use local cache for offline operations
- **Hybrid**: Combine local and remote data sources

## Project Integration

### Project File Management

I'll properly update project files based on format:

**PackageReference Format (.NET SDK-style):**
```xml
<PackageReference Include="Newtonsoft.Json" Version="13.0.3" />
<PackageReference Include="Microsoft.Extensions.Logging" Version="8.0.0" />
```

**packages.config Format (Legacy):**
```xml
<package id="Newtonsoft.Json" version="13.0.3" targetFramework="net48" />
```

**Directory.Packages.props (Central Package Management):**
```xml
<PackageVersion Include="Newtonsoft.Json" Version="13.0.3" />
```

### Solution-Wide Operations

For solution-level operations, I'll:

1. Discover all projects in solution
2. Analyze package usage across projects
3. Identify version inconsistencies
4. Propose consolidation strategies
5. Execute coordinated updates

## Error Handling

### Common Issues and Resolution

**Package Not Found:**
- Suggest similar package names
- Check package source configuration
- Verify spelling and capitalization
- Search in alternative sources

**Version Conflicts:**
- Analyze dependency chains
- Propose compatible version ranges
- Offer conflict resolution strategies
- Support manual override options

**Framework Incompatibility:**
- Check target framework requirements
- Suggest compatible package versions
- Recommend framework upgrades
- Provide polyfill alternatives

**Network Issues:**
- Implement retry logic with backoff
- Use cached package data when available
- Support offline package sources
- Provide clear connectivity guidance

### Validation and Safety

**Pre-operation Checks:**
- Verify project file syntax
- Check write permissions
- Validate package source accessibility
- Confirm disk space availability

**Post-operation Verification:**
- Verify package installation
- Test project compilation
- Check for runtime errors
- Validate dependency resolution

## Best Practices

### Package Management
- Always specify version ranges for stability
- Regularly audit packages for security vulnerabilities
- Keep packages updated but test thoroughly
- Use package lock files for reproducible builds
- Document package choices and rationale

### Performance Optimization
- Use package caching for faster operations
- Minimize package count and size
- Choose packages with fewer dependencies
- Monitor package load times and memory usage
- Regular cleanup of unused packages

### Security Considerations
- Enable package signature verification
- Scan packages for known vulnerabilities
- Use trusted package sources only
- Regular security audits of dependencies
- Implement package approval workflows

I'll adapt to your project structure and follow .NET ecosystem best practices while providing comprehensive NuGet package management capabilities.