Print elements of an macro array, sums, and sums of squares

  Same results in WPS and SAS

github
https://github.com/rogerjdeangelis/utl_operating_on_macro_arrays

Do over macro
https://tinyurl.com/ybz3a643
https://github.com/rogerjdeangelis/utl_sql_looping_or_using_arrays_in_sql_do_over_macro

see SAS Forum
https://tinyurl.com/ycerue4z
https://communities.sas.com/t5/Base-SAS-Programming/SAS-how-to-use-index-to-pick-out-macro-array-variable/m-p/441511

INPUT
=====

 RULE

  Print elements of an macro array, sums, and sums of squares

     %let NS=2 4 6 8 10 12 14 16 18


PROCESS and OUTPUT
==================

     %array(numbers,values=&ns);

     %put &=numbers1;
        NUMBERS1=2

     %put &=numbers3;
        NUMBERS3=6

     %put SUM = %eval(%do_over(numbers,phrase=?,between=+));
          SUM = 90

     %put SUMSQ = %eval(%do_over(numbers,phrase=?*?,between=+));
          SUMSQ = 1140


*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
  do n=2 to 19 by 2;
     output;
  end;
run;quit;

%put &=ns;

proc sql;
select n into :ns separated by " " from have
;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

* SAS;

%array(numbers,values=&ns);

%put &=numbers1;
%put &=numbers3;
%put SUM = %eval(%do_over(numbers,phrase=?,between=+));
%put SUMSQ = %eval(%do_over(numbers,phrase=?*?,between=+));


* WPS;
%utl_submit_wps64('
libname wrk "%sysfunc(pathname(work))";

data have;
  do n=2 to 19 by 2;
     output;
  end;
run;quit;

proc sql;
select n into :ns separated by " " from have
;quit;

%array(numbers,values=&ns);

data _null_;
   put "&numbers1";
   put "&numbers3";
   put "SUM = %eval(%do_over(numbers,phrase=?,between=+))";
   put "SUMSQ = %eval(%do_over(numbers,phrase=?*?,between=+))";
run;

');

