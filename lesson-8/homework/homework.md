1. Write an SQL statement that counts the consecutive values in the Status field.

Input table (`Groupings`):

| **Step Number** | **Status** |
| --------------- | ---------- |
| 1               | Passed     |
| 2               | Passed     |
| 3               | Passed     |
| 4               | Passed     |
| 5               | Failed     |
| 6               | Failed     |
| 7               | Failed     |
| 8               | Failed     |
| 9               | Failed     |
| 10              | Passed     |
| 11              | Passed     |
| 12              | Passed     |

Expected Output:

| **Min Step Number** | **Max Step Number** | **Status** | **Consecutive Count** |
| ------------------- | ------------------- | ---------- | --------------------- |
| 1                   | 4                   | Passed     | 4                     |
| 5                   | 9                   | Failed     | 5                     |
| 10                  | 12                  | Passed     | 3                     |

---

2. Find all the year-based intervals from 1975 up to current when the company did not hire employees.

```sql
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);
```

Expected Output:

| Years       |
| ----------- |
| 1978 - 1978 |
| 1981 - 1981 |
| 1986 - 1989 |
| 1991 - 1996 |
| 1998 - 2025 |
