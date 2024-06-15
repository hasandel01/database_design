SELECT Branch.name AS branch_name, Employee.name AS personnel_name
FROM Branch
RIGHT OUTER JOIN Employee ON Branch.branch_id = Employee.branch_id;