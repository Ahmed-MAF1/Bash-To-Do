#!/bin/bash
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