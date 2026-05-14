o Group Members:
Ahmed Fathy 202301049
Mahmoud mohamed 202300997
-----------------------------------------------------------------------------------------
o How to run the script
Make the script runnable by typing:

<!-- chmod +x to_do.sh -->

Run the script:

<!-- ./to_do.sh -->
-----------------------------------------------------------------------------------------
o List of implemented features

Persistent Storage: Saves tasks in a tasks.csv file so data isn't lost.

Automatic Setup: Creates the database file and headers automatically on first run.

Input Validation: Uses Regex to make sure dates are 8 digits and within a valid range.

Auto-Sorting: Uses the sort command to keep tasks organized by date.

Linux Tools:

grep: For searching and deleting tasks.

sed: For updating task status (Pending to Completed).

cut: For splitting CSV columns.

Data Structures: Uses Arrays (mapfile) to handle task lists in memory.

Clean UI: Uses printf to display tasks in a neat, aligned table.

-----------------------------------------------------------------------------------------
Important Notes:

We used grep and sed to handle the data inside the CSV file.

The script uses Arrays to load tasks for better performance.

Dates must be 8 numbers (YYYYMMDD), but you can type them like 2026/05/18 and the script will fix it.