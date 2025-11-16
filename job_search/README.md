# Automation Apps for Job Search

I am currently unemployed and actively looking for a job.  
Time is precious, and
optimization is essential.  
This project aims to help me reach more opportunities
while reducing the uncomfortable period of unemployment.

My job search is organized in a folder named `applications/`, with one subfolder
per applied position. Each application folder contains three main files:

* `job_description.txt`
* `cover_letter.odt` → converted to PDF before sending
* `curriculum.odt` → also converted to PDF

Additionally, there is a folder named `archiv/` for rejected applications.

These scripts use this file structure to automate job search tasks and analysis.

---

## A picture of the current structure
I use open source (.odt)

```
applications\
    |_ 00_achiv\
        |_ yyyy-mm-xx_position_company\
        |_ yyyy-mm-xx_position_company\
    |_ 00_get_jobs\
        |_ curriculum\        
        |_ positions\
        |_ log.txt
    |_ 00_templates\
        |_ DE\
            |_ Lebenslauf.odt
            |_ Motivationsschreiben.odt
        |_ EN\
            |_ CoverLetter.odt
            |_ Curriculum.odt
    |_ yyyy-mm-xx_position_company\
        |_ CoverLetter.odt
        |_ CoverLetter.pdf
        |_ Curriculum.odt
        |_ Curriculum.pdf
        |_ job_description.txt
    |_ yyyy-mm-xx_position_company\
        |_ ...
    |_ yyyy-mm-xx_position_company\
        |_ ...
    |_ ...

```

---

## Job Application Template Creator (Batch Script)
`create_template.bat`

This simple yet effective Batch script (`create_template.bat`) is designed to
**streamline and automate organizational tasks associated with a focused job
search, from initial setup to curriculum submission.**

By automating the creation of structured, date-stamped folders, this tool
ensures every application is instantly organized and ready for document
submission. It demonstrates how simple scripting can deliver impactful process
automation.

### How It Works

The script performs three key actions in a single command:

1. **Automated Naming**: Prompts the user for the job title/company and
   automatically prepends the current date (`YYYY-MM-DD`). Spaces in the input
   are replaced with underscores (`_`).  
   *Example:* Entering `Data Engineer Company DE` creates a folder named
   `2025-10-25_Data_Engineer_Company`.

2. **Multilingual Templating**: Detects a language code (`EN` or `DE`) at the
   end of the input (e.g., `... EN`) and copies the corresponding template
   structure from the `00_template/` directory.  
   *Default:* If no language is specified, English (`EN`) is used.

3. **Essential Documentation**: Automatically creates a core file
   (`job_description.txt`) within the new folder, serving as a ready-to-use
   checklist for application details (URL, description, etc.).

---

## Analysis Tool for Sent Applications
`get_jobs.bat`

This script recursively loops through all application folders, searching for:

* `job_description.txt`
* `curriculum.pdf`

It then creates a folder `get_jobs/` and populates it with:

* `curriculum/` → contains all `curriculum.pdf` files that were sent
* `positions/` → contains all `job_description.txt` files
* `log.txt` → a self-explanatory log file created after execution

With this information, I can use additional tools to analyze the files and gain
valuable insights about my job search strategy and the direction I have taken.

The expected result is to improve my search by eliminating applications less
aligned with my competencies and guiding the future preparation of curricula
and cover letters.

---

## 🚀 Getting Started

Follow these steps to quickly set up and use the automation scripts:

1. **Clone the repository**  
   ```bash
   git clone https://github.com/charlie-delta-sierra/scripting-automation.git
   cd job-search-automation
   ```
2. **Prepare the template folder**

Ensure you have a folder named `00_template/` with the base files
(`job_description.txt`, `cover_letter.odt`, `curriculum.odt`) in English (`EN`)
and optionally in German (`DE`).

3. **Run the template creator**

Execute `create_template.bat` and provide the job title/company name (and
language code if needed).

A new folder will be created under `applications/` with the proper structure.

4. **Send applications**

Fill in the files (`cover_letter.odt`, `curriculum.odt`) and convert them to PDF
before submission.

5. **Analyze your search**

Run `get_jobs.bat` to collect all sent curricula and job descriptions into the
`get_jobs/` folder.

Use the generated `log.txt` to track progress and identify patterns.

---

## 🔮 Improvements

This project is evolving. Planned enhancements include:

1. **Existing**

    * **Visualization Tools**: Generate charts showing application trends over time.
    * **Interactive Dashboard**: A simple UI to track applications, statuses,  
    and insights without relying only on batch logs.

2. **In Progress**

    * **Data Insights**: Add scripts to analyze rejection reasons and highlight recurring keywords in job descriptions.

3. **Futures / Optional**

    * **Additional Language Support**: Extend templates beyond English and German.
    * **Automated PDF Conversion**: Integrate automatic `.odt → .pdf` conversion.
    * **Cloud Integration**: Optionally sync applications with cloud storage for
    backup and access across devices.

Feel free to use these scripts if you are in a similar situation, or if they
can serve you in another way.

---

### 🙏 Thanksgiving

Thank you for visiting my repository!
