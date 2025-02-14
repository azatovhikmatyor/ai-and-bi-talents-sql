#### **1. DELETE vs TRUNCATE vs DROP (with IDENTITY example)**
- Create a table `test_identity` with an `IDENTITY(1,1)` column and insert 5 rows.
- Use `DELETE`, `TRUNCATE`, and `DROP` one by one (in different test cases) and observe how they behave.
- Answer the following questions:
  1. What happens to the identity column when you use `DELETE`?
  2. What happens to the identity column when you use `TRUNCATE`?
  3. What happens to the table when you use `DROP`?

#### **2. Common Data Types**
- Create a table `data_types_demo` with columns covering at least **one example of each data type** covered in class.
- Insert values into the table.
- Retrieve and display the values.

#### **3. Inserting and Retrieving an Image**
- Create a `photos` table with an `id` column and a `varbinary(max)` column.
- Insert an image into the table using `OPENROWSET`.
- Write a Python script to retrieve the image and save it as a file.

#### **4. Computed Columns**
- Create a `student` table with a computed column `total_tuition` as `classes * tuition_per_class`.
- Insert 3 sample rows.
- Retrieve all data and check if the computed column works correctly.

#### **5. CSV to SQL Server**
- Download or create a CSV file with at least 5 rows of worker data (`id, name`).
- Use `BULK INSERT` to import the CSV file into the `worker` table.
- Verify the imported data.


