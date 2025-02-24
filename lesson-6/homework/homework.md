#### **Given Tables:**  

1. **Employees**  
   | EmployeeID | Name     | DepartmentID | Salary  |  
   |-----------|---------|--------------|---------|  
   | 1         | Alice   | 101          | 60000   |  
   | 2         | Bob     | 102          | 70000   |  
   | 3         | Charlie | 101          | 65000   |  
   | 4         | David   | 103          | 72000   |  
   | 5         | Eva     | NULL         | 68000   |  

2. **Departments**  
   | DepartmentID | DepartmentName |  
   |-------------|---------------|  
   | 101         | IT            |  
   | 102         | HR            |  
   | 103         | Finance       |  
   | 104         | Marketing     |  

3. **Projects**  
   | ProjectID | ProjectName   | EmployeeID |  
   |----------|-------------|-----------|  
   | 1        | Alpha       | 1         |  
   | 2        | Beta        | 2         |  
   | 3        | Gamma       | 1         |  
   | 4        | Delta       | 4         |  
   | 5        | Omega       | NULL      |  

### **Questions:**  

1. **INNER JOIN**  
   - Write a query to get a list of employees along with their department names.  

2. **LEFT JOIN**  
   - Write a query to list all employees, including those who are not assigned to any department.  

3. **RIGHT JOIN**  
   - Write a query to list all departments, including those without employees.  

4. **FULL OUTER JOIN**  
   - Write a query to retrieve all employees and all departments, even if there’s no match between them.   

5. **JOIN with Aggregation**  
   - Write a query to find the total salary expense for each department.  

6. **CROSS JOIN**  
   - Write a query to generate all possible combinations of departments and projects.  

7. **MULTIPLE JOINS**  
   - Write a query to get a list of employees with their department names and assigned project names. Include employees even if they don’t have a project.  
