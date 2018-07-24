# sql_analysis
sql queries used to analyse various databases in MS SQL Server

Good Summary for One Column
============================
For exploring data, the following information is a good summary for a single column
------------------------------------------------------------------------------------
The number of distinct values in the column SELECT DISTINCT()  
Minimum and maximum values MIN() AS minval and MAX() AS maxval         
An example of the most common value (called the mode in statistics) MIN(CASE WHEN freq = maxval THEN attribute END) AS mode  
An example of the least common value (called the antimode) MIN(CASE WHEN frew = minval THEN attribute END) AS anti_mode  
Frequency of the minimum and maximum values  
Frequency of the mode MAX(maxval)  
Frequency of the anit mode MIN(minval)  
Number of values that occur only one time   
Number of modes (because the most common value is not necessarily unique) SUM(CASE WHEN freq = maxval THEN 1 ELSE 0 END) AS num_mode  
Number of anit_modes (because the least common value is not necessarily unique) SUM(CASE WHEN freq = minval THEN 1 ELSE 0 END) AS num_anti_mode  
