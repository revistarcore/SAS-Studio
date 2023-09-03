data example;
    set coretax.detail_pelaporan_v2;
    retain seed 12345;
    random_num = ranuni(seed); /* Menghasilkan angka acak */
run;

/* Mengurutkan dataset berdasarkan angka acak */
proc sort data=example out=sorted_example(drop=random_num seed);
    by random_num;
run;

/* Memberikan nomor urut berdasarkan urutan acak */
data final_dataset;
    set sorted_example;
    NO_BARIS + 1; /* Penomoran acak */
run;

/* Menghapus kolom random_num jika tidak diperlukan */
data final_dataset;
    set final_dataset;
    drop random_num;
run;


proc sql noprint;
drop table coretax.detail_pelaporan_v2;
quit;

/* promotr */
data coretax.detail_pelaporan_v2(promote=yes);
set final_dataset;
rename row_number=NO_BARIS;
drop seed;
run;
