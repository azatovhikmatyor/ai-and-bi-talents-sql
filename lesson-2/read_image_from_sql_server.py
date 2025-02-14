import pyodbc # SQL SERVER

con_str = "DRIVER={SQL SERVER};SERVER=LENOVO;DATABASE=class2;Trusted_Connection=yes;"
con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute(
    """
    SELECT * FROM products;
    """
)

row = cursor.fetchone()
img_id, name, image_data = row

with open(f'{name}.png', 'wb') as f:
    f.write(image_data)
