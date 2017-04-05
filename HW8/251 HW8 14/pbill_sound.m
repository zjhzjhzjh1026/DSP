 load -ascii bilu_single_col.txt
 load -ascii jcnwwa_single_col.txt
 aa=jcnwwa_single_col;
%aa=bilu_single_col;
aa=aa/max(abs(aa));
aa=aa/1.1;
specgram(aa,1024,10000);
sound(aa,10000)
pause(3);
wavplay(aa,10000)
pause(3)
p = audioplayer(aa, 10000);
play(p);
