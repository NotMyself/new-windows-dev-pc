# .NET Test Specialist Command

This command uses the dotnet-test-specialist agent to generate and manage .NET unit tests using MSTest.Sdk and NSubstitute for mocking and component testing.

## Usage

```
/dotnet-test
```

## Description

This command will:
- Generate comprehensive MSTest unit test classes with proper structure and attributes
- Create NSubstitute mocks and stubs for isolating dependencies in tests
- Design component-level integration tests following .NET best practices
- Handle async/await testing patterns and modern .NET testing practices
- Structure entire test projects and ensure proper test organization

## Agent Used

- **dotnet-test-specialist**: Specialized in .NET unit testing using MSTest.Sdk and NSubstitute for mocking component testing

## Tools Available to Agent

- Read: To analyze existing code and test files
- Write: To create new test files and test project structures
- Edit: To modify existing test files
- MultiEdit: To make multiple changes across test files
- Bash: To run dotnet test commands and manage test execution
- Grep: To search for patterns across test files and source code
- Glob: To find test files and source files in the project

## Example Use Cases

- Generate unit tests for a service class using MSTest and NSubstitute
- Create component tests for a controller with mocked dependencies
- Write async tests for a repository class using MSTest framework
- Set up a test project structure for a .NET application
- Create parameterized tests with test data generation
- Generate integration tests with realistic test scenarios
- Set up test coverage analysis and reporting