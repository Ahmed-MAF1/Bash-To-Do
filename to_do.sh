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
    if [[ -z "$title" ]]; then
    echo "Error: Title cannot be empty!"
    return
    fi
    while true; do
        echo -n "Enter date (YYYY/MM/DD): "
        read raw_input
        
        task_date=$(echo "$raw_input" | tr -d ' /-')
        
        if validate_date "$task_date"; then
            break
        fi
        echo "Invalid format! Try again."
    done
    
    echo "$task_date,$title,$task_date,Pending" >> "$DB_FILE"
    
    header=$(head -n 1 "$DB_FILE")
    (echo "$header"; tail -n +2 "$DB_FILE" | sort -t',' -k1,1n) > temp.csv && mv temp.csv "$DB_FILE"
    
    echo "Task added and list sorted successfully!"
}
view_tasks() {
    echo "------------------------------------------------------------"
    printf "%-12s %-20s %-12s %-10s\n" "ID" "Title" "Date" "Status"
    echo "------------------------------------------------------------"

    mapfile -t lines < <(tail -n +2 "$DB_FILE")
    
    for line in "${lines[@]}"; do
        
        id=$(echo "$line" | cut -d',' -f1)
        title=$(echo "$line" | cut -d',' -f2)
        tdate=$(echo "$line" | cut -d',' -f3)
        status=$(echo "$line" | cut -d',' -f4)

        formatted_date="${tdate:0:4}/${tdate:4:2}/${tdate:6:2}"

        printf "%-12s %-20s %-12s %-10s\n" "$id" "$title" "$formatted_date" "$status"
    done
}
mark_completed() {
    echo -n "Enter Task ID to mark as completed: "
    read id
    if grep -q "^$id," "$DB_FILE"; then
        sed -i "/^$id,/s/Pending/Completed/" "$DB_FILE"
        echo "Task status updated to Completed!"
    else
        echo "Error: Task ID not found."
    fi
}
delete_task() {
    echo -n "Enter Task ID to delete: "
    read id
    if grep -q "^$id," "$DB_FILE"; then
        grep -v "^$id," "$DB_FILE" > temp.csv && mv temp.csv "$DB_FILE"
        echo "Task deleted successfully!"
    else
        echo "Error: Task ID not found."
    fi
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
        1) add_task ;;
        2) view_tasks ;;
        3) mark_completed ;;
        4) delete_task ;;
        5) exit 0 ;;
        *) echo "Invalid choice." ;;
    esac
done