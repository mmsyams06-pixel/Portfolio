use hospital_dataset;
show tables;

rename table hospital_indonesia_datasets to hospital;
select*from hospital;

-- Berapa jumlah rumah sakit di setiap provinsi?
select propinsi, count(id) as total_rs_propinsi
from hospital
group by propinsi
ORDER BY COUNT(ID) DESC;

-- Berapa jumlah rumah sakit berdasarkan jenis?
select jenis, count(id) as total_jenis_rs
from hospital
group by jenis;

-- Berapa jumlah rumah sakit berdasarkan kepemilikan (swasta, pemda, kementerian, dll.)?
select kepemilikan, count(id) as total_kepemilikan
from hospital
group by kepemilikan;

--  Berapa jumlah rumah sakit di setiap kabupaten/kota?
select kab, count(id) as total_rs_per_kab
from hospital
group by kab;

-- Bagaimana distribusi rumah sakit berdasarkan kelas (A, B, C, D)?
select kelas, count(id) as total_rs_per_kelas
from hospital
group by kelas;

-- Provinsi mana yang memiliki rumah sakit terbanyak?
select propinsi, count(id) as propinsi_rs_terbanyak
from hospital
group by propinsi
order by count(id) desc
limit 1;

-- Kabupaten/kota mana yang memiliki rumah sakit terbanyak?
select kab, count(id) as kab_rs_terbanyak
from hospital
group by kab
order by count(id) desc
limit 1;

-- Rumah sakit mana yang memiliki tempat tidur terbanyak?
select nama, total_tempat_tidur
from hospital
order by total_tempat_tidur desc
limit 1;

-- Provinsi mana yang memiliki total tempat tidur terbanyak?
select propinsi, sum(total_tempat_tidur)
from hospital
group by propinsi
order by sum(total_tempat_tidur) desc
limit 1;

-- Berapa rata-rata jumlah tempat tidur per provinsi?
select propinsi, avg(total_tempat_tidur) as rerata_tempat_tidur
from hospital
group by propinsi;

-- Berapa rata-rata jumlah tempat tidur berdasarkan kelas rumah sakit?
select kelas, avg(total_tempat_tidur) as rerata_tempat_tidur
from hospital
group by kelas;

-- Rumah sakit mana yang memiliki tenaga kerja terbanyak?
select nama, total_tenaga_kerja
from hospital
order by total_tenaga_kerja desc 
limit 1;

-- Provinsi mana yang memiliki total tenaga kerja terbanyak?
select propinsi, sum(total_tenaga_kerja)
from hospital
group by propinsi
order by sum(total_tenaga_kerja) desc 
limit 1;

-- Berapa rata-rata tenaga kerja per rumah sakit di setiap provinsi?
select propinsi, avg(total_tenaga_kerja)
from hospital
group by propinsi;

-- Berapa rata-rata jumlah layanan kesehatan per kelas rumah sakit?
select kelas, avg(total_layanan)
from hospital
group by kelas;

-- Rumah sakit mana yang memiliki jumlah layanan kesehatan terbanyak?
select nama, total_layanan
from hospital
order by total_layanan desc
limit 1;

-- Bagaimana distribusi rumah sakit berdasarkan status BLU/BLUD dan Non BLU/BLUD?
select status_blu, count(id)
from hospital
group  by status_blu;

-- Apa perbandingan jumlah rumah sakit swasta dan negeri di setiap provinsi?

select kab, count(id)
from hospital
group by kab
having  kab = 'Aceh Tengah';
select count(distinct propinsi)
from hospital;

-- Kabupaten/kota mana yang memiliki jumlah layanan kesehatan terbanyak?
select kab, sum(total_layanan)
from hospital
group by kab
order by sum(total_layanan) desc
limit 1;

-- Apa perbandingan jumlah rumah sakit swasta dan negeri di setiap provinsi?
 select propinsi, kategori_rs, count(*)
 from (select propinsi,
 case
	when kepemilikan = 'SWASTA/LAINNYA' then 'swasta'
    else 'negeri'
end as kategori_rs
from hospital) as subquery
group  by propinsi, kategori_rs
order by propinsi, kategori_rs;

-- Provinsi mana yang memiliki rasio tenaga kerja terhadap tempat tidur tertinggi?
select propinsi, a / nullif(b,0) as rasio
from (
select 
propinsi, 
sum(total_tenaga_kerja) as a, 
sum(total_tempat_tidur) as b
from hospital
group by propinsi) as subquery
group by propinsi
order by rasio desc;

select propinsi, sum(total_layanan), sum(total_tempat_tidur)
from hospital
group by propinsi
order by propinsi asc;



    