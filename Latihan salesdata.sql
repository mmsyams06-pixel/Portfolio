use salesdata;
select*from sales_data;
select Sales_Rep, count(*)
from sales_data
group by Sales_Rep
order by count(*) desc;


-- Bagaimana tren total penjualan per bulan sepanjang tahun?
SELECT 
    DATE_FORMAT(Sale_date, '%Y-%m') AS bulan,
    SUM(Sales_Amount) AS total_pendapatan
FROM sales_data
GROUP BY DATE_FORMAT(Sale_date, '%Y-%m')
ORDER BY bulan;

-- Bagaimana tren penjualan bulanan di setiap Region?
SELECT 
    DATE_FORMAT(Sale_date, '%Y-%m') AS bulan,
    Region,
    SUM(Sales_Amount) AS total_pendapatan
FROM sales_data
GROUP BY DATE_FORMAT(Sale_date, '%Y-%m'), Region
ORDER BY bulan, Region;

-- Berapakah rata-rata diskon (Discount) yang diberikan setiap bulan?
SELECT 
    DATE_FORMAT(Sale_date, '%Y-%m') AS bulan,
    AVG(Discount) AS rata2_diskon
FROM sales_data
GROUP BY DATE_FORMAT(Sale_date, '%Y-%m')
ORDER BY bulan;

-- Berapakah total penjualan di setiap Region?
SELECT 
	Region, 
	SUM(Sales_Amount) AS total_penjualan
FROM sales_data
GROUP BY Region;

-- Berapakah rata-rata jumlah barang terjual pada setiap kategori produk?
SELECT 
	Product_Category, 
	AVG(Quantity_Sold) AS rata2_produk
FROM sales_data
GROUP BY Product_Category;

-- Produk mana yang memiliki total penjualan tertinggi?
SELECT 
	Product_Category, 
	SUM(Sales_Amount) AS total_penjualan
FROM sales_data
GROUP BY Product_Category
ORDER BY total_penjualan DESC
LIMIT 1;

-- Bagaimana perbandingan total penjualan antara Customer Type: New dan Returning?
SELECT 
	Customer_Type,
    ROUND(SUM(Sales_Amount),2) AS total_penjualan,
    ROUND(SUM(Sales_Amount)*100/ (SELECT SUM(Sales_Amount) FROM sales_data),2)
FROM sales_data
GROUP BY Customer_Type;

-- Bagaimana distribusi penjualan berdasarkan Payment Method dan Sales Channel?
SELECT 
	Payment_Method, Sales_Channel,
    ROUND(SUM(Sales_Amount),2) AS total_penjualan
FROM sales_data
GROUP BY Payment_Method, Sales_Channel;

-- Berapa persentase transaksi yang dilakukan secara Online dibandingkan dengan Retail?
SELECT
	Sales_Channel,
    COUNT(*) AS total_transaksi,
    ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM sales_data))
FROM sales_data
GROUP BY Sales_Channel;

-- Produk mana yang menghasilkan profit paling tinggi, 
-- jika profit dihitung sebagai selisih antara nilai penjualan dan total biaya (unit cost × quantity)?
SELECT 
	Product_ID, 
    ROUND(Sales_Amount - (Quantity_Sold * Unit_Cost),2) AS profit
FROM sales_data
ORDER BY profit DESC;

-- Siapa 2 Sales Rep dengan penjualan tertinggi di setiap Region?
SELECT
	Region,
    Sales_Rep,
    total_penjualan,
    rn
FROM (
SELECT  
	Region,
    Sales_Rep,
    ROUND(SUM(Sales_Amount),2) AS total_penjualan,
    ROW_NUMBER() OVER (PARTITION BY Region ORDER BY SUM(Sales_Amount) DESC) AS rn
FROM sales_data 
GROUP BY Sales_Rep, Region
ORDER BY total_penjualan DESC) ranked
WHERE rn in (1,2)
ORDER BY Region;

-- Bagaimana rata-rata penjualan tiap Sales Rep dibandingkan dengan 
-- rata-rata penjualan global seluruh Sales Rep?
SELECT
	Sales_Rep,
    AVG(Sales_Amount),
    AVG(Sales_Amount) /(SELECT AVG(Sales_Amount) FROM sales_data) AS rasio_perbandingan
FROM sales_data
GROUP BY Sales_Rep;



    



