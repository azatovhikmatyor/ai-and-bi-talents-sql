Interview Question:

A factory has records of Large Tractor shipments spanning 40 days (see table below). In some of the 40 days, the factory shipped zero tractors and the **zeros we not recorded**.

What is the median number of tractors shipped per day based on the last 40 days?

Table of the daily shipments that we recorded (sorted):
N   | Num
----|-------
1   | 1
2   | 1
3   | 1
4   | 1
5   | 1
6   | 1
7   | 1
8   | 1
9   | 2
10  | 2
11  | 2
12  | 2
13  | 2
14  | 4
15  | 4
16  | 4
17  | 4
18  | 4
19  | 4
20  | 4
21  | 4
22  | 4
23  | 4
24  | 4
25  | 4
26  | 5
27  | 5
28  | 5
29  | 5
30  | 5
31  | 5
32  | 6
33  | 7

```sql
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);
```
