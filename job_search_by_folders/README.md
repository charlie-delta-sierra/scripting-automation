# Job Application Template Creator (Batch Script)

## Overview

This simple yet effective Batch script (`create_template.bat`) is designed to **streamline and automate the tedious organizational tasks associated with a focused job search, from initial organization to curriculum submission.**

By automating the creation of structured, date-stamped folders, this tool ensures every application is instantly organized and ready for document submission. This solution showcases an ability to use simple scripting tools to achieve impactful process automation results.

## Public Expertise Demonstration

This repository will serve as a **public demonstration of my expertise in practical scripting and process automation**, showcasing an ability to use simple tools (like Windows Batch) to achieve impactful results in professional environments.

## How It Works

The script performs three key actions in a single command:

1.  **Automated Naming**: Prompts the user for the job title/company and automatically prepends the current date (`YYYY-MM-DD`). Spaces in the input are replaced with underscores (`_`).
    * *Ex:* Entering `Data Engineer Company DE` creates a folder named `2025-10-25_Data_Engineer_Company`.
2.  **Multilingual Templating**: The script detects a specified language code (`EN` or `DE`) at the end of the input (e.g., `... EN`) and copies the corresponding template structure from the `00_template/` directory. **If no language is specified, English (`EN`) is used by default.**
3.  **Essential Documentation**: Automatically creates a core file (e.g., `job_description.txt`) within the new folder, serving as a ready-to-use checklist for the application details (URL, Description, etc.).