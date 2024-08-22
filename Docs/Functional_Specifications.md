# Functional Specifications

<details>
<summary>Table of contents</summary>

- [Functional Specifications](#functional-specifications)
	- [Product Overview](#product-overview)
	- [Project Definition](#project-definition)
		- [Objectives](#objectives)
		- [Scope](#scope)
			- [Version 1.0](#version-10)
			- [Version 2.0](#version-20)
			- [Version 3.0](#version-30)
		- [Out of Scope](#out-of-scope)
	- [Project Organization](#project-organization)
		- [Stakeholders](#stakeholders)
		- [Milestones](#milestones)
		- [Risks and Assumptions](#risks-and-assumptions)
			- [Risks](#risks)
			- [Assumptions](#assumptions)
		- [Constraints](#constraints)
	- [Functional Requirements](#functional-requirements)
		- [Features Overview](#features-overview)
			- [1 - Create a Programming Language Extension](#1---create-a-programming-language-extension)
			- [2 - Custom Theme](#2---custom-theme)
			- [3 - Update and Maintain the Extension](#3---update-and-maintain-the-extension)
			- [4 - Use Settings as Base](#4---use-settings-as-base)
			- [User Interface and Design](#user-interface-and-design)
		- [Success Criteria](#success-criteria)
	- [Target Audience](#target-audience)
		- [Use Cases](#use-cases)
			- [Use Case: New programming language](#use-case-new-programming-language)
	- [Non-Functional Requirements](#non-functional-requirements)
		- [Reliability](#reliability)
		- [Usability](#usability)
		- [Recovery](#recovery)
		- [Delivery](#delivery)
		- [Maintainability](#maintainability)
		- [Security](#security)
	- [Glossary](#glossary)

</details>


## Product Overview

The Extension Creator is a tool that allows users to create their own Visual Studio Code extensions. The tool provides a user-friendly interface that allows users to define the features of their extension, such as the name, description, version, publisher, and dependencies. The tool generates the necessary files and folders for the extension. The tool also provides a way to package the extension and publish it to the Visual Studio Code Marketplace. The tool is designed to be easy to use and user-friendly, so that even users with no programming experience can create their own extensions. The tool is available for free and open-source, so that users can modify and improve it as they see fit. The tool is compatible with the latest version of Visual Studio Code.

## Project Definition

### Objectives

The main objective of this project is to allow users to easily create, update and maintain their Visual Studio Code extensions. The extensions created with this tool should be compatible with the latest version of Visual Studio Code and should be available for download from the Visual Studio Code Marketplace.The tool should be well-documented and provide support for bug reports and feature requests. The tool should be secure and reliable, with no security vulnerabilities or privacy issues. 

### Scope

#### Version 1.0

The first version of the tool should include basic features that allow the user to make use of this tool as much as possible and to get feedback from the users. The first version should include the following features:

- The user should be able to create their own language syntax extensions.
- The tool should create a new folder with the necessary files and folders for the extension.
- The tool should provide the user with a way to define the name, description, version and publisher of the extension.
- The tool should provide the user with a way to define the keywords, comments, and theme of the extension.

#### Version 2.0

The second version of the tool should include advanced features that will make the tool more useful and powerful. The second version should include the following features:

- The tool should provide the user with a way to define the activation events, commands, and configuration of the extension.
- The tool should provide the user with a way to create snippets, key bindings, and functions for the extension.
- The tool should provide the user with a way to create and fill a 'README' file for the extension.
- The tool should provide the user with a way to package the extension and publish it to the Visual Studio Code Marketplace.

#### Version 3.0

The third version of the tool should include practical features such as:

- The tool should provide the user with a way to create and fill a 'CHANGELOG' file for the extension.
- The tool should provide the user with a way to create and fill a 'LICENSE' file for the extension.
- The user should be able to define the create running tests for the extension.

### Out of Scope

The following features are out of scope for this project:

- The tool will not be able to create extensions for other code editors.
- The user will not be able to create graphical user interface extensions.


## Project Organization

### Stakeholders

The stakeholders for this project are the developers who will use this tool and the manager who will be responsible for the project.
New stakeholders could be added in the future, such as investors, partners, and contributors.


### Milestones

| Name 						| Description 														| Due Date 		| Priority 	|
| :---: 					| :---: 															| :---: 		| :---: 	|
| Functional Specifications | Writing the document that explains the functional requirements 	| 2024-08-25 	| High 		|
| Technical Specifications 	| Writing the document that explains the technical requirements 	| 2024-08-25 	| High 		|
| V1 Development 			| Developing first version of the tool 								| 2024-08-28 	| High 		|
| V1 Testing 				| Testing first version of the tool 								| 2024-09-10 	| Medium	|
| V1 Release 				| Releasing first version of the tool 								| 2024-09-20 	| High 		|
| V1 Report 				| Writing the report of the first version of the tool 				| 2024-09-10 	| High 		|
| V2 Development 			| Developing second version of the tool 							| 2024-01-15 	| Medium	|
| V2 Testing 				| Testing second version of the tool 								| 2024-02-20 	| High 		|
| V2 Release 				| Releasing second version of the tool 								| 2024-03-12 	| Medium	|


### Risks and Assumptions

#### Risks

- The tool might not be compatible with all versions of Visual Studio Code.
- The tool might not be compatible with all operating systems.
- The tool might not be secure and reliable.
- The tool might not be well-documented.
- The tool might crash or fail.

#### Assumptions

- The tool will be compatible with the latest version of Visual Studio Code.
- The tool will be compatible with Windows, MacOS, and Linux.
- The tool will be easy to use and user-friendly.
- The tool will be easy to configure.



### Constraints

- The tool must be compatible with the latest version of Visual Studio Code.
- The tool must be compatible with Windows, MacOS, and Linux.
- The tool must be available for download from GitHub.
- The tool must be open-source and available for free.
- The user must have a basic knowledge of programming languages.


## Functional Requirements


### Features Overview

#### 1 - Create a Programming Language Extension

The user should be able to create their own language syntax extensions. The tool should create a new folder with the necessary files and folders for the extension. The tool should provide the user with a way to define the name, description, version, and publisher of the extension. The tool should provide the user with a way to define the keywords, comments, and theme of the extension.

#### 2 - Custom Theme

The tool should allow the user to define a custom theme for the extension. The user should be able to define the colors of the extension, such as the background color, the strings color, the numbers color, the keywords color, the comments color, etc.


#### 3 - Update and Maintain the Extension

After creating the extension, the user should be able to update the extension. The user should be able to add new features to the extension, such as new keywords, new comments, new themes, etc. The user should be able to update the version of the extension.


#### 4 - Use Settings as Base

The settings of the extension should be used as a base for the extension. The user should be able to define settings that will be used as a base for the extensions. These settings should be applied when a new extension is created.




#### User Interface and Design

The user interface will be designed to be user-friendly and easy to use. The user interface will be divided into different sections, such as the Home page, the extensions page, and the settings page. The user interface will be designed to be accessible and easy to navigate. The user interface will be designed to be visually appealing and attractive.


### Success Criteria

The success of the project will be measured using different criteria such as the number of downloads, the number of active users, the number of issues reported, the number of pull requests, the number of stars on GitHub, and the number of contributors.
These criteria will be used to evaluate the success of the project and to make decisions about the future of the project.
They should be organized by priority and should be measurable.


| Criteria 					| Priority 	| Measurable 	|
| :---: 					| :---: 	| :---: 		|
| Downloads					| High 		| Yes 			|
| Active users				| High 		| Yes 			|
| Issues reported			| High 		| Yes 			|
| Pull requests				| Medium	| Yes 			|
| Stars on GitHub			| Low 		| Yes 			|
| Contributors				| Low 		| Yes 			|


## Target Audience

The main target audience for this project is developers who use Visual Studio Code. These developers could be students, professionals, or hobbyists. They could be working on creating a new programming language, a new theme, or a new extension for Visual Studio Code.


### Use Cases

#### Use Case: New programming language

<ins>**Context:**</ins> A user wants to create a new programming language.

- <ins>**Step 1:**</ins> Open the application and create an extension for his personal programming language.
- <ins>**Step 2:**</ins> The application asks the user to define the name, description, version, and publisher of the extension.
- <ins>**Step 3:**</ins> The application creates a new folder with the necessary files and folders for the extension.
- <ins>**Step 4:**</ins> The user gets redirected the customization page.
- <ins>**Step 5:**</ins> Then defines the keywords, comments, theme, etc. of the extension.
- <ins>**Step 6:**</ins> Once everything is good, the user saves the extension.
- <ins>**Step 7:**</ins> The user then clicks on the 'Publish' button to publish the extension to the Visual Studio Code Marketplace.
- <ins>**Step 8:**</ins> The new extension is now available for download from the Visual Studio Code Marketplace.




## Non-Functional Requirements


### Reliability

- The application should be able to allow the user to create a programming language extension without any issues.
- The application should be able to create a new folder with the necessary files and folders for the extension.
- The application should be able to provide the user with a way to define the name, description, version, and publisher of the extension.

### Usability

- The tool should be easy to use and user-friendly.
- The tool should be easy to install and configure.

### Recovery

- The tool should be able to avoid crashes and failures.
- In case of a crash, the tool should be able to recover the data.

### Delivery

- The tool should be delivered on time.
- The tool should be available for download from GitHub.
- The tool should be available for free.

### Maintainability

- The tool should be easy to maintain and update.
- The tool should be open-source and available on GitHub.
- The tool should be well-documented.

### Security

- The tool should be secure and reliable.
- The tool should not have any security vulnerabilities.
- The tool should not have any privacy issues.




## Glossary

| Term 					| Definition 	| Source 	|
| :---: 				| :---: 		| :---: 	|
| Visual Studio Code 	| A source-code editor developed by Microsoft for Windows, Linux and macOS. It includes support for debugging, embedded Git control, syntax highlighting, intelligent code completion, snippets, and code refactoring. | [Wikipedia](https://en.wikipedia.org/wiki/Visual_Studio_Code) |
| Extension 			| A software component that adds a specific feature to an existing software application. | [Wikipedia](https://en.wikipedia.org/wiki/Software_extension) |
| API 					| A set of rules and protocols that allows different software applications to communicate with each other. | [Wikipedia](https://en.wikipedia.org/wiki/Application_programming_interface) |
| Open-source 			| A type of computer software in which source code is released under a license in which the copyright holder grants users the rights to study, change, and distribute the software to anyone and for any purpose. | [Wikipedia](https://en.wikipedia.org/wiki/Open-source_software) |
| GitHub 				| A provider of Internet hosting for software development and version control using Git. | [Wikipedia](https://en.wikipedia.org/wiki/GitHub) |
| Formatting 			| The process of making the code easier to read and understand. | [Wiktionary](https://en.wiktionary.org/wiki/formatting) |
| Refactoring 			| The process of restructuring existing computer code without changing its external behavior. | [Wikipedia](https://en.wikipedia.org/wiki/Code_refactoring) |
| Operating System 		| The software that supports a computer's basic functions, such as scheduling tasks, executing applications, and controlling peripherals. | [Wikipedia](https://en.wikipedia.org/wiki/Operating_system) |
| Pull Request 			| A method of submitting contributions to an open development project. | [Wikipedia](https://en.wikipedia.org/wiki/Pull_request) |
| Coding Convention		| A way in which something is usually done, especially within a particular area or activity. | [Wikipedia](https://en.wikipedia.org/wiki/Coding_conventions) |