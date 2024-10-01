# Technical Specifications

<details>

<summary>Table of Contents</summary>

- [Technical Specifications](#technical-specifications)
	- [Introduction](#introduction)
		- [Overview](overview)
		- [Technical Requirements](#technical-requirements)
		- [Development Environment](#development-environment)
	- [Solution](#solution)
		- [Technologies](#technologies)
		- [Conventions](#conventions)
			- [Files and Folders](#files-and-folders)
			- [Code](#code)
			- [Comments](#comments)
		- [Technical Choices](#technical-choices)
		- [Software Architecture](#software-architecture)
		- [Software effects](#software-effects)
		- [Error Handling](#error-handling)
	- [Technical Constraints](#technical-constrains)
		- [Security](#security)
		- [Scalability](#scalability)
		- [Maintainability](#maintainability)
	- [Metric evaluation](#metric-evaluation)
		- [Performance](#performance)
		- [Reliability](#reliability)
			- [Feedbacks](#feedbacks)
			- [Monitoring](#monitoring)
	- [Glossary](#glossary)
		- [Definitions](#definitions)
		- [Acronyms](#acronyms)
		- [References](#references)
</details>


## Introduction

### Overview

This document outlines the technical specifications for the project. It includes the architecture, design, and implementation details of the project.
It will be used as a reference for answers to technical questions and as a guide for the development team.

### Technical Requirements

The project must be developed using Flutter and should be compatible with Windows, MacOS, and Linux.

### Development Environment

The development environment should be set up with VSCode and Git installed. The project should be developed using the latest version of the software.

## Solution

### Technologies

The project will be developed using the following technologies:

- **Flutter**: The project will be developed using Flutter. Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase.

- **Github**: The project will be hosted on GitHub. GitHub is a web-based platform for version control and collaboration.

- **VSCode**: The project will be developed using Visual Studio Code. Visual Studio Code is a source-code editor developed by Microsoft for Windows, Linux, and macOS.



### Conventions

#### Files and Folders

- **File Naming**: All files should be named using snake-case. For example, `file_name.dart`.
- **Folder Naming**: All folders should be named using snake-case. For example, `folder_name`.
- **Inheritance**: There should be no more than 4 levels of inheritance in the project. For example, `app > vsce_extension_creator > lib > storage`.

#### Code

- **Indentation**: The project should use 1 tab (4 spaces) for indentation.
- **Variable Naming**: All variables should be named using camelCase. For example, `variableName`.
- **Function Naming**: All functions should be named using camelCase. For example, `functionName`.
- **Spaces around Operators**: There should be spaces around operators and after a comma. For example, `a + b` or `namesArray = ["Jean", "Kylian", "Marie"];`.
- **Global Variables**: Global variables should be avoided. If necessary, they should be declared using `const` and should be named using SCREAMING_SNAKE_CASE. For example, `const GLOBAL_VARIABLE = "value";`.

#### Comments

- **Comments**: All comments should be written in English and should be clear and concise.
- **Commenting Code**: All code should be commented. Comments should be used to explain the purpose of the code and to provide context for the reader.
- **Important Comments**: Important comments should be written using `// !SUBJECT!:`. For example, `// !ADD MORE TECHNOLOGIES!`.


### Technical Choices


The project will be developed using the following technical choices:


### Software Architecture

<!-- // TODO: Add software architecture -->


### Software effects


<!-- // TODO: Details about the software effects -->
The software will have the following effects:

- **File Generating**: The software will allow users to generate files.
- **File Editing**: The software will allow users to edit files.
- **File Saving**: The software will allow users to save files.
- **File Deleting**: The software will allow users to delete files.
- **File Renaming**: The software will allow users to rename files.


### Error Handling


The software will handle errors by displaying error messages to the user. The software will also log errors to a log file for further analysis. The software will handle errors gracefully and will not crash.



## Technical Constraints

### Security

The project should be developed with security in mind. No personal data should be stored in the project. 


### Scalability

The project should be scalable and should be able to handle a large number of files. The project should be able to handle large files without any performance issues.


### Maintainability

A link to the project's repository issues should be provided in the project's README file. The project should be well-documented and should be easy to maintain.



## Metric evaluation


### Performance

The performance of the project will be evaluated based on the following metrics:

- **Load Time**: The time taken to load the project.
- **Memory Usage**: The amount of memory used by the project.
- **CPU Usage**: The amount of CPU used by the project.



### Reliability

#### Feedbacks

Feedback will be collected from users to evaluate the reliability of the project. The feedback will be used to identify any issues with the project and to make improvements.




#### Monitoring

Regular monitoring should be done by the manager to ensure that the project is running smoothly Any issues should be corrected in a time range of 1 month.



## Glossary

### Definitions

| Term | Definition |
| :---: | :---: |
| Indentation | The process of adding spaces or tabs to the beginning of a line of code to make it easier to read. |
| Variable | A named storage location in memory that holds a value. |
| Function | A block of code that performs a specific task. |
| Operator | A symbol that performs a specific operation on one or more operands. |
| Global Variable | A variable that is accessible from any part of the program. |
| Comment | A note added to the code to explain what the code does. |
| Inheritance | The process of creating a new class from an existing class. |



### Acronyms

| Acronym | Complete Form |
| :---: | :---: |
| VSCode | Visual Studio Code |
| CPU | Central Processing Unit |
| RAM | Random Access Memory |


### References

- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [GitHub Documentation](https://docs.github.com/en)