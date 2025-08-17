# Custom Claude Code Agents

This directory contains specialized agents created for this project. While these agents cannot be directly invoked through the Task tool, they serve as comprehensive templates and knowledge bases for specific tasks.

## Available Agents

### readme-maintainer
**Purpose**: Specialized agent for creating, updating, and maintaining README.md files with modern best practices.

**Usage**: Use the general-purpose agent with instructions from this agent's template:
```
Task tool with subagent_type: "general-purpose"
Prompt: "Follow the guidelines in .claude/agents/readme-maintainer.md to update the README.md file..."
```

**Capabilities**:
- README analysis and gap identification
- Modern documentation standards implementation
- Structure optimization and best practices
- Content accuracy verification
- Cross-platform compatibility considerations

## How to Use Custom Agents

Since Claude Code doesn't support registering custom agents in settings, use this workflow:

1. **Reference the agent file**: Read the agent's markdown file for specialized knowledge
2. **Use general-purpose agent**: Invoke with specific instructions based on the agent template
3. **Follow agent guidelines**: Apply the agent's best practices and processes

## Agent Development

New agents can be created using the `agent-architect` built-in agent:
```
Task tool with subagent_type: "agent-architect"
```

Place new agent files in this directory following the naming convention: `agent-name.md`