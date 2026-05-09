#!/bin/bash
DB_FILE="tasks.csv"

if [ ! -f "$DB_FILE" ]; then
    echo "ID,Title,Date,Status" > "$DB_FILE"
fi

validate_date() {
    local date_str=$1
    
    if [[ ! $date_str =~ ^[0-9]{8}$ ]]; then
        return 1
    fi
    
    local year=${date_str:0:4}
    local month=${date_str:4:2}
    local day=${date_str:6:2}

    if (( year < 2026 || year > 2036 )); then
        echo "Error: Year must be between 2026 and 2036."
        return 1
    fi

    if [[ ! $month =~ ^(0[1-9]|1[0-2])$ ]]; then
        echo "Error: Month must be between 01 and 12."
        return 1
    fi

    if [[ ! $day =~ ^(0[1-9]|[12][0-9]|3[01])$ ]]; then
        echo "Error: Day must be between 01 and 31."
        return 1
    fi

    return 0
}

add_task() {
    echo -n "Enter task title: "
    read title
}
view_tasks() {

}
mark_completed() {
    echo -n "Enter Task ID to mark as completed: "
    read id
}
delete_task() {
    echo -n "Enter Task ID to delete: "
    read id
}

while true; do
    echo "=== Bash To-Do ==="
    echo "1. Add Task"
    echo "2. View Tasks (Sorted)"
    echo "3. Mark Task as Completed"
    echo "4. Delete Task"
    echo "5. Exit"
    echo -n "Select option: "
    read choice
    case $choice in
        1) Add_task ;;
        2) view_tasks ;;
        3) mark_completed ;;
        4) delete_task ;;
        5) exit 0 ;;
        *) echo "Invalid choice." ;;
    esac
done