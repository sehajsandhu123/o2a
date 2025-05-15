O2A documentation![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.001.png)

How to convert Workflows to DAGs

System requirements

Install O2A 

Structure of the application folder for workflows Bulk workflow conversion

Shell Example

Prerequisites

Running Output

Hive/Hive2 Example Prerequisites

Running Output

Known limitations

Errors you might face

HDFS Filepath exception

HDFS File Paths in hiveconfs

Hive DAG: Cannot modify \*\*\*.ctx.try\_number at runtime Skeleton Transformation

Decision Node

Features that are not supported

Oozie workflow EL Functions Coordinator job conversion

How to convert Workflows to DAGs

System requirements

Note that you need Python >= 3.8 to run the converter.

Install O2A 

First thing we need to do is build the required pip packages and install it on all airflow workers and the node on which we are converting workflows to DAGs

1  s our ce  / us r / odp/ 3. 2. 3. 3- 3/ ai r f l ow/ bi n/ act i vat e
1  pi p  i ns t al l  o2a- accel dat a
1  pi<a name="_page0_x31.50_y579.00"></a> p  i ns t al l  o2a- l i b- accel dat a
1  pi p  i ns t al l  - - upgr ade  wr apt

T<a name="_page0_x61.50_y615.75"></a>his is the full usage guide for o2a as shown below

1 ( ai r f l ow)  [ r oot @ai r f l owdemonode01  o2a] #  . / bi n/ o2a  - hel p 2

3 us age:  o2a  [ - h]  - i  I NPUT\_DI RECTORY\_PATH  - o  OUTPUT\_DI RECTORY\_PATH  [ - n  DAG\_NAME]  [ - u  USER]  [ - s  START\_DAYS\_AGO]

[ - x  SCHEMA\_VERSI ON]  [ - s kv  SKI P\_VALI DATI ON]

<a name="_page0_x31.50_y691.50"></a>4 [ - v  SCHEDULE\_I NTERVAL]  [ - d]

5

6  Conver t  Apache  Oozi e  wor kf l ows  t o  Apache  Ai r f l ow  wor kf l ows .
6  opt i ons :
8  - h,  - - hel p             s how  t hi s  hel p  mes s age  and  exi t![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.002.png)
8  - i  I NPUT\_DI RECTORY\_PATH,  - - i nput - di r ect or y- pat h  I NPUT\_DI RECTORY\_PATH

10 Pat h  t o  i nput  di r ect or y

11 - o  OUTPUT\_DI RECTORY\_PATH,  - - out put - di r ect or y- pat h  OUTPUT\_DI RECTORY\_PATH 12 Des i r ed  out put  di r ect or y 13 - n  DAG\_NAME,  - - dag- name  DAG\_NAME 14 Des i r ed  DAG  name  [ def aul t s  t o  i nput  di r ect or y  name]

15  - u  USER,  - - us er  USER   The  us er  t o  be  us ed  i n  pl ace  of  al l  ${us er . name}  [ def aul t s  t o  us er  who  r an  t he conver s i on]
15  - s  START\_DAYS\_AGO,  - - s t ar t - days - ago  START\_DAYS\_AGO

17 Des i r ed  DAG  s t ar t  as  number  of  days  ago 18 - x  SCHEMA\_VERSI ON,  - - s chema- ver s i on  SCHEMA\_VERSI ON 19 Des i r ed  Oozi e  al l  s chema  ver s i on. [ 1. 0, 0. 4] 20 - s kv  SKI P\_VALI DATI ON,  - - s ki p- val i dat i on  SKI P\_VALI DATI ON 21 s ki p  val i dat i on 22 - v  SCHEDULE\_I NTERVAL,  - - s chedul e- i nt er val  SCHEDULE\_I NTERVAL 23 Des i r ed  DAG  s chedul e  i nt er val  as  number  of  days 24 - d,  - - dot              Render s  wor kf l ow  f i l es  i n  DOT  f or mat

Structure of the application folder for workflows

The input application directory has to follow the structure defined as follows:

1 <APPLI CATI ON>/

2 | -  j ob. pr oper t i es         -  j ob  pr oper t i es  t hat  ar e  us ed  t o  r un  t he  j ob

3 | -  hdf s                   -  f ol der  wi t h  appl i cat i on  -  s houl d  be  copi ed  t o  HDFS

<a name="_page1_x31.50_y347.25"></a>4 |      | -  wor kf l ow. xml     -  Oozi e  wor kf l ow  xml  ( 1. 0  s chema)

5 |      | -  . . .              -  addi t i onal  f ol der s  r equi r ed  t o  be  copi ed  t o  HDFS

6 | -  conf i gur at i on. t empl at e. pr oper t i es  -  t empl at e  of  conf i gur at i on  val ues  us ed  dur i ng  conver s i on 7 | -  conf i gur at i on. pr oper t i es           -  gener at ed  pr oper t i es  f or  conf i gur at i on  val ues

After the o2a installation is done, we can start converting our workflows :- 

1 . / bi n/ o2a  - i  . . / oozi e\_s ampl e/   - o  ai r f l ow\_s ampl e/  - x  0. 4  - s kv  t r ue 2

3  [ 2025- 04- 09T15: 45: 42. 663+0530]  {wor kf l ow\_xml \_par s er . py: 242}  I NFO  -  Par s ed  Emai l Er r or  as  Act i on  Node  of  t ype emai l .
3  [ 2025- 04- 09T15: 45: 42. 663+0530]  {wor kf l ow\_xml \_par s er . py: 81}  I NFO  -  Par s ed  f ai l  as  Ki l l  Node.
3  [ 2025- 04- 09T15: 45: 42. 664+0530]  {wor kf l ow\_xml \_par s er . py: 81}  I NFO  -  Par s ed  Ki l l  as  Ki l l  Node.
3  [ 2025- 04- 09T15: 45: 42. 664+0530]  {wor kf l ow\_xml \_par s er . py: 94}  I NFO  -  Par s ed  End  as  End  Node.
3  [ 2025- 04- 09T15: 45: 42. 664+0530]  {oozi e\_conver t er . py: 189}  I NFO  -  Appl yi ng  pr e- conver t  t r ans f or mer s
3  [ 2025- 04- 09T15: 45: 42. 664+0530]  {oozi e\_conver t er . py: 125}  I NFO  -  Conver t i ng  nodes  t o  t as ks  and  i nner  r el at i ons
3  [ 2025- 04- 09T15: 45: 42. 693+0530]  {oozi e\_conver t er . py: 194}  I NFO  -  Appl yi ng  pos t - conver t  t r ans f or mer s
3  [ 2025- 04- 09T15: 45: 42. 693+0530]  {oozi e\_conver t er . py: 173}  I NFO  -  Addi ng  er r or  handl er s
3  [ 2025- 04- 09T15: 45: 42. 693+0530]  {oozi e\_conver t er . py: 155}  I NFO  -  Conver t i ng  r el at i ons  bet ween  t as ks  gr oups .
3  [ 2025- 04- 09T15: 45: 42. 693+0530]  {oozi e\_conver t er . py: 150}  I NFO  -  Conver t i ng  dependenci es .
3  [ 2025- 04- 09T15: 45: 42. 694+0530]  {r ender er s . py: 104}  I NFO  -  Savi ng  t o  f i l e:  di s ht i or i gi nal j ob2/ . py
3  Fi xi ng  / r oot / o2a/ di s ht i or i gi nal j ob2/ . py

After the conversion is completed you will get your DAG in the specified folder 

Bulk workflow conversion

If we wish to convert all jobs in a single go, we can use the  s et up\_o2a\_bul k. s h script to convert our workflows to DAGs, to use it, we basically just need to keep all our workflows in a single directory as shown below

<a name="_page1_x31.50_y948.75"></a>1 <PARENT- DI R>/

2 | -  wor kf l ow1![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.003.png)

3 | -  wor kf l ow. xml .    -  -  Oozi e  wor kf l ow  xml 

4 | -  conf i gur at i on. pr oper t i es

5 | -  j ob. pr oper t i es

6 | -  wor kf l ow2              

7 | -  wor kf l ow. xml     -  Oozi e  wor kf l ow  xml 

8 | -  conf i gur at i on. pr oper t i es

9 | -  j ob. pr oper t i es

10 | -  . . .              -  addi t i onal  f ol der s  r equi r ed  t o  be  copi ed  t o  HDFS

The  s et up\_o2a\_bul k. s h  will take care of setting up the workflow & itʼs config files in the required input dir structure, which will be as shown below

1  [ r oot @ai r f l owdemonode01  o2a] #  bas h  s et up\_o2a\_bul k. s h  - f  ~/ bul k\_j ob![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.004.png)
1  [ 2025- 04- 25  14: 22: 39]  [ I NFO]  St ar t i ng  conver s i on  pr oces s  f or  / r oot / bul k\_j ob
1  [ 2025- 04- 25  14: 22: 39]  [ I NFO]  Cr eat ed  di r ect or y  s t r uct ur e  i n  / r oot / bul k\_j ob\_CONVERTED
1  [ 2025- 04- 25  14: 22: 39]  [ WARN]  conf i gur at i on. pr oper t i es  not  f ound
1  [ 2025- 04- 25  14: 22: 39]  [ I NFO]  Pr oces s ed  s ubwor kf l ow  act i on:  hi ve2\_act i on
1  [ 2025- 04- 25  14: 22: 39]  [ WARN]  conf i gur at i on. pr oper t i es  not  f ound
1  [ 2025- 04- 25  14: 22: 39]  [ I NFO]  Pr oces s ed  s hel l  act i on:  s ehaj \_er r or s \_s ampl e
1  [ 2025- 04- 25  14: 22: 39]  [ I NFO]  Set up  compl et ed  f or  / r oot / bul k\_j ob.  You  can  now  r un  . / r un\_o2a\_bul k. s h  t o  per f or m t he  conver s i on.
1  [ 2025- 04- 25  14: 22: 39]  [ I NFO]  Log  f i l es  ar e  s t or ed  i n:  / r oot / bul k\_j ob\_CONVERTED/ l ogs

1 <APPLI CATI ON>/![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.005.png)

2 | -  j ob. pr oper t i es         -  j ob  pr oper t i es  t hat  ar e  us ed  t o  r un  t he  j ob

3 | -  hdf s                   -  f ol der  wi t h  appl i cat i on  -  s houl d  be  copi ed  t o  HDFS

4 |      | -  wor kf l ow. xml     -  Oozi e  wor kf l ow  xml  ( 1. 0  s chema)

5 |      | -  . . .              -  addi t i onal  f ol der s  r equi r ed  t o  be  copi ed  t o  HDFS

6 | -  conf i gur at i on. t empl at e. pr oper t i es  -  t empl at e  of  conf i gur at i on  val ues  us ed  dur i ng  conver s i on 7 | -  conf i gur at i on. pr oper t i es           -  gener at ed  pr oper t i es  f or  conf i gur at i on  val ues

after this structure is setup, we can start our conversion by using  r un\_o2a\_bul k. s h :-![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.006.png)

1  [ r oot @ai r f l owdemonode01  o2a] #  . / r un\_o2a\_bul k. s h![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.007.png)
1  [ 2025- 04- 25  14: 22: 45]  [ I NFO]  St ar t i ng  bul k  conver s i on  pr oces s
1  [ 2025- 04- 25  14: 22: 45]  [ I NFO]  Conver t i ng  s hel l  act i on:  s ehaj \_er r or s \_s ampl e
1  [ 2025- 04- 25  14: 22: 45]  [ I NFO]  I nput  di r ect or y:  / r oot / bul k\_j ob\_CONVERTED/ s hel l \_act i ons / s ehaj \_er r or s \_s ampl e
1  [ 2025- 04- 25  14: 22: 45]  [ I NFO]  Out put  di r ect or y:  / r oot / bul k\_j ob\_CONVERTED/ out put / s hel l \_s ehaj \_er r or s \_s ampl e
1  [ 2025- 04- 25T14: 23: 40. 819+0530]  {oozi e\_conver t er . py: 173}  I NFO  -  Addi ng  er r or  handl er s
1  [ 2025- 04- 25T14: 23: 40. 819+0530]  {oozi e\_conver t er . py: 155}  I NFO  -  Conver t i ng  r el at i ons  bet ween  t as ks  gr oups .
1  [ 2025- 04- 25T14: 23: 40. 819+0530]  {oozi e\_conver t er . py: 150}  I NFO  -  Conver t i ng  dependenci es .
1  [ 2025- 04- 25T14: 23: 40. 819+0530]  {r ender er s . py: 104}  I NFO  -  Savi ng  t o  f i l e: / r oot / bul k\_j ob\_CONVERTED/ out put / s hel l \_s ehaj \_er r or s \_s ampl e/ s ehaj \_er r or s \_s ampl e. py
1  Fi xi ng  / r oot / bul k\_j ob\_CONVERTED/ out put / s hel l \_s ehaj \_er r or s \_s ampl e/ s ehaj \_er r or s \_s ampl e. py
1  [ 2025- 04- 25  14: 23: 41]  [ I NFO]  Conver s i on  s ucces s f ul  f or  s ehaj \_er r or s \_s ampl e
1  [ 2025- 04- 25  14: 23: 44]  [ I NFO]  Bul k  conver s i on  compl et ed

After the conversion is completed you will get your DAG in the specified folder             ( bul k\_j ob\_CONVERTED in this case)![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.008.png)

Shell Example ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.009.png)

Prerequisites ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.010.png)

Make sure to first copy  exampl es / s hel l / conf i gur at i on. t empl at e. pr oper t i es , rename it as  conf i gur at i on. pr oper t i es and fill in ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.011.png)![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.012.png)with configuration data.

<a name="_page2_x31.50_y1031.25"></a><a name="_page2_x31.50_y942.75"></a><a name="_page2_x31.50_y903.75"></a>Running ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.013.png)

The Shell example can be run as:

o2a  - i  exampl es / s hel l  - o  out put / s hel l![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.014.png)

Alot of shell action jobs actually call bash scripts for spark/hive job execution , this bash script is often present in the ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.015.png)hadoop file system and is executed in a yarn container . This is a core difference between oozie and airflow that an oozie workflow is executed in a yarn container in a specific job queue configured. While in airflow , the DAG is executed on the airflow worker itself, so it has no direct access to the HDFS file system itself, which leads us to copy the files over to our local working dir and execute them  O2A documentation and limitations | HDFS script execution (RESOLVED) .

Output ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.016.png)

In this example the output will be created in the  . / out put / s hel l / folder.![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.017.png)

<a name="_page3_x31.50_y194.25"></a>The converted DAG uses the  Bas hOper at or in Airflow, which executes the desired shell action on the airflow worker.![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.018.png)

Hive/Hive2 Example ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.019.png)

Prerequisites ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.020.png)

Make sure to first copy  / exampl es / hi ve/ conf i gur at i on. t empl at e. pr oper t i es , rename it as  conf i gur at i on. pr oper t i es and fill in ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.021.png)![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.022.png)with configuration data.

<a name="_page3_x31.50_y327.75"></a>Running ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.023.png)

<a name="_page3_x31.50_y366.75"></a>The Hive example can be run as:

o2a  - i  exampl es / hi ve  - o  out put / hi ve![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.024.png)

Output ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.025.png)

In this example the output will be created in the  . / out put / hi ve/ folder.![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.026.png)

The converted DAG uses the  Hi veOper at or in Airflow & a default hive connection id = hive\_connection, you can see how to ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.027.png)configure this as shown in Known limitations.

<a name="_page3_x31.50_y455.25"></a>Known limitations ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.028.png)

There are few limitations in the implementation of the Oozie-To-Airflow converter. It's not possible to write a converter that handles all cases of complex workflows from Oozie because some of functionalities available are not possible to map easily to <a name="_page3_x31.50_y552.75"></a>existing Airflow Operators 

Many of those limitations are not blockers - the workflows will still be converted to Python DAGs and it should be possible to manually (or automatically) post-process the DAGs to add custom functionality. So even with those limitations in place you can still save a ton of work when converting many Oozie workflows.

![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.029.png) Exit status not available (shell actions) From the Oozie documentation:

The output (STDOUT) of the Shell job can be made available to the workflow job after the Shell job ends. This information ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.030.png)<a name="_page3_x31.50_y706.50"></a>could be used from within decision nodes.

Currently we use the  Bas hOper at or which can store only the last line of the job output in an XCOM. In this case the line is not ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.031.png)helpful as it relates to the Dataproc job submission status and not the Shell action's result.

Issue in Github: Finalize shell mapper

![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.032.png) Not all global configuration methods are supported

Oozie implements a number of ways how configuration parameters are passed to actions. Out of the existing configuration options the following ones are not supported (but can be easily added as needed):

1. The config-default.xml file
1. Parameters section of workflow.xml
1. Handle Global configuration properties
- No Shell launcher configuration (shell actions)

From the Oozie documentation:

Shell launcher configuration can be specified with a file, using the job-xml element, and inline, using the configuration ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.033.png)elements.

Currently there is no way specify the shell launcher configuration (it is ignored). Issue in Github: Shell Launcher Configuration

![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.034.png) Custom messages missing for Kill Node

The Kill Node might have custom log message specified. This is not implemented, but will be taken up in future enhancements Oozie docs

ODP-4307: Add support for custom kill node messages in O2A TO DO![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.035.png)

- Capturing output is not supported In several actions you can capture output from tasks. This is not yet implemented. Example Oozie docs
- Only the connection to the local Hive instance is supported.

Connection configuration options are not supported.

- Not all elements are supported

For Hive, the following elements are not supported:  j ob- t r acker ,  name- node . For Hive2, the following elements are not ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.036.png)![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.037.png)supported:  j ob- t r acker ,  name- node ,  j dbc- ur l ,  pas s wor d .![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.038.png)![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.039.png)![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.040.png)

The Github issue for both problems: Hive connection configuration and other elements, 

Instead, we need to create a custom Hive connection in Airflow as shown below

![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.041.jpeg)

You might need to update your hive script variables: So variables such as ${INPUT} passed through hiveconf might not ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.042.png)always resolve correctly, unless we add a hiveconf: prefix to them, especially in a Tez execution. 

For e.g. :- 

1  CREATE  EXTERNAL  TABLE  t es t  ( a  I NT)  STORED  AS  TEXTFI LE  LOCATI ON  ' ${I NPUT}' ;
1  I NSERT  OVERWRI TE  DI RECTORY  ' ${OUTPUT}'  SELECT  \*  FROM  t es t ;

3

4 Thes e  var i abl es  wi l l  get  conver t ed  t o 5

6  CREATE  EXTERNAL  TABLE  t es t  ( a  I NT)  STORED  AS  TEXTFI LE  LOCATI ON  ' ${hi veconf : I NPUT}' ;
6  I NSERT  OVERWRI TE  DI RECTORY  ' ${hi veconf : OUTPUT}'  SELECT  \*  FROM  t es t ;

Errors you might face

HDFS Filepath exception

1  [ 2025- 04- 09T12: 06: 32. 672+0530]  {oozi e\_conver t er . py: 125}  I NFO  -  Conver t i ng  nodes  t o  t as ks  and  i nner  r el at i ons
1  Tr aceback  ( mos t  r ecent  cal l  l as t ) :
1  Fi l e  "/ r oot / f i nal e/ o2a/ . / bi n/ o2a",  l i ne  38,  i n  <modul e>

4 o2a. o2a. mai n( )

5 Fi l e  "/ r oot / f i nal e/ o2a/ o2a/ o2a. py",  l i ne  137,  i n  mai n 6 conver t er . conver t ( )

7 Fi l e  "/ r oot / f i nal e/ o2a/ o2a/ conver t er / oozi e\_conver t er . py",  l i ne  106,  i n  conver t 8 s el f . conver t \_nodes ( ) 9 Fi l e  "/ r oot / f i nal e/ o2a/ o2a/ conver t er / oozi e\_conver t er . py",  l i ne  127,  i n  conver t \_nodes

10 t as ks ,  r el at i ons  =  oozi e\_node. mapper . t o\_t as ks \_and\_r el at i ons ( )

11 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

<a name="_page5_x31.50_y668.25"></a>12 Fi l e  "/ r oot / f i nal e/ o2a/ o2a/ mapper s / s hel l \_mapper . py",  l i ne  119,  i n  t o\_t as ks \_and\_r el at i ons 13 pr epar e\_t as k  =  s el f . pr epar e\_ext ens i on. get \_pr epar e\_t as k( )

14 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

<a name="_page5_x31.50_y706.50"></a>15 Fi l e  "/ r oot / f i nal e/ o2a/ o2a/ mapper s / ext ens i ons / pr epar e\_mapper \_ext ens i on. py",  l i ne  40,  i n  get \_pr epar e\_t as k 16 del et e\_pat hs ,  mkdi r \_pat hs  =  s el f . par s e\_pr epar e\_node( ) 17 ^^^^^^^^^^^^^^^^^^^^^^^^^

18 Fi l e  "/ r oot / f i nal e/ o2a/ o2a/ mapper s / ext ens i ons / pr epar e\_mapper \_ext ens i on. py",  l i ne  67,  i n  par s e\_pr epar e\_node ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.043.png)19 node\_pat h  =  nor mal i ze\_pat h( node. at t r i b[ "pat h"] ,  pr ops =s el f . mapper . pr ops ) 20 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 21 Fi l e  "/ r oot / f i nal e/ o2a/ o2a/ ut i l s / el \_ut i l s . py",  l i ne  147,  i n  nor mal i ze\_pat h 22 r ai s e  Par s eExcept i on( 23 o2a. conver t er . except i ons . Par s eExcept i on:  Unknown  pat h  f or mat .  The  URL  s houl d  be  pr ovi ded  i n  t he  f ol l owi ng

f or mat :  hdf s : / / l ocal hos t : 9200/ pat h.  Cur r ent  val ue:  {{  par ams . get ( ' USCCETLI nges t Di r ' )  }}/ {{

par ams . get ( ' USCCETLI nges t DoneI ndFi l e' )  }}  None  0  {{  par ams . get ( ' USCCETLI nges t Di r ' )  }}/ {{

par ams . get ( ' USCCETLI nges t DoneI ndFi l e' )  }}

Add the variables that resolve to an hdfs location "${tmpLocation}" to resolve\_name\_node method in  o2a/ ut i l s / el \_ut i l s . py

1  106  def  \_r es ol ve\_name\_node( t r ans l at i on:  s t r ,  pr ops :  Pr oper t ySet )  - >  Tupl e[ Opt i onal [ s t r ] ,  i nt ] :
1  107      """
1  108      Check  i f  pr ops  i ncl ude  nameNode,  nameNode1  or  nameNode2  val ue.
1  109      """
1  110      mer ged  =  pr ops . mer ged
1  111      f or  key  i n  [ "nameNode",  "nameNode1",  "nameNode2",  "dat aNode",  "t mpLocat i on""] :
1  112      #Add  t he  var i abl es  t hat  r es ol ve  t o  an  hdf s  l ocat i on  "${t mpLocat i on}"
1  113          s t ar t \_s t r  =  "{{"  +  '  par ams . get ( \ \ ' '  +  key  +  ' \ \ ' )  '  +  "}}"
1  114          s t ar t \_s t r \_dat a\_node  =  "${"  +  '  par ams . get ( \ \ ' '  +  "dat aNode"  +  ' \ \ ' )  '  +  "}"
1  115          name\_node  =  mer ged. get ( key)
1  116          i f  t r ans l at i on. s t ar t s wi t h( s t ar t \_s t r )  and  name\_node:
1  117              r et ur n  name\_node,  l en( s t ar t \_s t r )
1  118          i f  t r ans l at i on. s t ar t s wi t h( s t ar t \_s t r \_dat a\_node)  and  name\_node:
1  119              r et ur n  name\_node,  l en( s t ar t \_s t r \_dat a\_node)
1  120      r et ur n  None,  0

HDFS File Paths in hiveconfs

Using HDFS File Paths in HiveOperator  hi veconf s

When using the  Hi veOper at or in Apache Airflow, it's important to correctly format the HDFS file paths passed as Hive configuration variables ( hi veconf s ). Incorrect path references can lead to runtime errors during Hive query execution.

🚫 Problem:

Users often pass HDFS paths dynamically via variables like  J OB\_PROPS[ ' us er . name' ] or  J OB\_PROPS[ ' exampl es Root ' ] , which may not resolve correctly at runtime, especially if the paths assume a different user context.

<a name="_page6_x31.50_y535.50"></a>For example:

1 hi veconf s ={

2 "I NPUT":  f "/ us er / {J OB\_PROPS[ ' us er . name' ] }/ exampl es / i nput - dat a/ t abl e",

3 "OUTPUT":  f "/ us er / {J OB\_PROPS[ ' us er . name' ] }/ {J OB\_PROPS[ ' exampl es Root ' ] }/ out put - dat a/ hi ve2", 4 }

If  J OB\_PROPS[ ' us er . name' ] resolves to something other than  ai r f l ow, the query may fail with errors like:

1 I nput  pat h  does  not  exi s t :  hdf s : / / . . . / us er / ai r f l ow/ us er / oozi e/ exampl es / i nput - dat a/ t abl e

✅ Recommended Fix:

Explicitly construct your HDFS paths to align with the runtime context of the  ai r f l ow user, since Airflow's Hive tasks often execute as that user.

Use paths like:

1 hi veconf s ={

2 "I NPUT":  "/ us er / ai r f l ow/ exampl es / i nput - dat a/ t abl e",![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.044.png)

3 "OUTPUT":  "/ us er / ai r f l ow/ exampl es / out put - dat a/ hi ve2", 4 }

Ensure that the input/output directories exist in HDFS under the correct user path ( / us er / ai r f l ow/ . . . ). Hive DAG:  Cannot  modi f y  \*\*\*. ct x. t r y\_number  at  r unt i me

![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.045.jpeg)

<a name="_page7_x31.50_y144.00"></a>By default,  Hi veOper at or includes all context variables in the  hi veconf . To enable airflow to pass these variables, you can update the config shown below in your hive-site.xml 

1 hi ve. s ecur i t y. aut hor i zat i on. s ql s t d. conf whi t el i s t . append  =  ai r f l ow. ct x. \*| mapr ed. j ob. name| I NPUT| OUTPUT

Skeleton Transformation

The O2A conversion supports several action and control nodes. The control nodes include fork, join, start, end, and kill. Among the action nodes, fs, map-reduce, and pig are supported.

Most of these are already handled, but when the program encounters a node it does not know how to parse, it performs a kind of "skeleton transformation" — converting all unknown nodes into dummy nodes. This allows users to manually parse those nodes later if they wish, as the control flow remains intact.

<a name="_page7_x31.50_y449.25"></a>Decision Node

The decision node is not fully functional as there is not currently support for all EL functions. So in order for it to run in Airflow you may need to edit the Python output file and change the decision node expression.

Issue in GitHub: Implement decision node

Features that are not supported

Oozie workflow EL Functions

Workflow functions are not supported. Instead of EL functions, the user will have to use Airflow xcoms feature for passing <a name="_page7_x31.50_y608.25"></a>variables between different actions in a workflow.

this will be taken up as a future enhancement and more workflow functions will be added to O2A. ( ODP-4308: Add support for

oozie wf functions in O2A TO DO )

For eg, For this workflow

1 <wor kf l ow- app  name="Wor kFl owFor Shel l Act i onWi t hCapt ur eOut put "  xml ns ="ur i : oozi e: wor kf l ow: 1. 0"> 2 <s t ar t  t o="s hel l Act i on"/ > 3 <act i on  name="s hel l Act i on">

4 <s hel l  xml ns ="ur i : oozi e: s hel l - act i on: 1. 0">

<a name="_page7_x31.50_y762.00"></a><a name="_page7_x31.50_y801.00"></a>5 <j ob- t r acker >${j obTr acker }</ j ob- t r acker >

6 <name- node>${nameNode}</ name- node>![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.046.png)

7 <conf i gur at i on>

8 <pr oper t y>

9 <name>mapr ed. j ob. queue. name</ name>

10 <val ue>${queueName}</ val ue>

11 </ pr oper t y>

12 </ conf i gur at i on>

13 <exec>${l i neCount Shel l Scr i pt }</ exec>

14 <ar gument >${i nput Di r }</ ar gument >

15 <f i l e>${l i neCount ShScr i pt Pat h}#${l i neCount Shel l Scr i pt }</ f i l e>

16 <capt ur e- out put / >

17 </ s hel l >

18 <ok  t o="s endEmai l "/ >

19 <er r or  t o="ki l l Act i on"/ >

20 </ act i on>

21 <act i on  name="s endEmai l ">

22 <emai l  xml ns ="ur i : oozi e: emai l - act i on: 0. 2">

23 <t o>${emai l ToAddr es s }</ t o>

24 <s ubj ect >Out put  of  wor kf l ow  ${wf : i d( ) }</ s ubj ect >

25 <body>Res ul t s  f r om  l i ne  count :  ${wf : act i onDat a( ' s hel l Act i on' ) [ ' Number Of Li nes ' ] }</ body> 26 </ emai l >

27 <ok  t o="end"/ >

28 <er r or  t o="end"/ >

29 </ act i on>

30 <ki l l  name="ki l l Act i on">

31 <mes s age>"Ki l l ed  j ob  due  t o  er r or "</ mes s age>

32 </ ki l l >

33 <end  name="end"/ > 34 </ wor kf l ow- app>

We get the below DAG 

1  #  Def i ne  a  f unct i on  t o  l og  t he  s hel l  act i on  dat a
1  def  l og\_s hel l \_act i on\_dat a( \*\*cont ext ) :

3 t i  =  cont ext [ ' t i ' ]

4 s hel l \_out put  =  t i . xcom\_pul l ( t as k\_i ds =' s hel l Act i on' )

5 l ogger . i nf o( "Out put  of  s hel l Act i on:  %s ",  s hel l \_out put )

6 #  Pr oces s  t he  s hel l \_out put  as  needed

7 r et ur n  "Loggi ng  compl et ed"

8

9 wi t h  model s . DAG(

10 "s ampl e\_s hel l \_oozi e\_2",

11 s chedul e\_i nt er val =None,

12 s t ar t \_dat e=dat es . days \_ago( 0) ,

13 us er \_def i ned\_macr os =TEMPLATE\_ENV, 14 )  as  dag: 15 s hel l Act i on  =  bas h. Bas hOper at or (

16 t as k\_i d="s hel l Act i on",

17 t r i gger \_r ul e="one\_s ucces s ",

18 bas h\_command=( "hdf s  df s  - cat

hdf s : / / t es t cl us t er . accel dat a. ce/ us er / oozi e/ wor kf l owShel l Act i on/ l i neCount . s h | bas h - s

hdf s : / / t es t cl us t er . accel dat a. ce/ us er / oozi e/ t ext . t xt ") ,

19 do\_xcom\_pus h=Tr ue,

20 par ams =Pr oper t ySet (

21 conf i g=CONFI G,

22 j ob\_pr oper t i es =J OB\_PROPS,

23 act i on\_node\_pr oper t i es ={"mapr ed. j ob. queue. name":  "def aul t "},

24 ) . mer ged,

25 )

26![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.047.png)

27 #  Log  t he  act i on  dat a

28 l og\_act i on\_dat a  =  Pyt honOper at or (

29 t as k\_i d="l og\_act i on\_dat a",

30 pyt hon\_cal l abl e=l og\_s hel l \_act i on\_dat a,

31 pr ovi de\_cont ext =Tr ue,

32 dag=dag,

33 )

34

35 s endEmai l  =  emai l . Emai l Oper at or (

36 t as k\_i d="s endEmai l ",

37 t r i gger \_r ul e="one\_s ucces s ",

38 t o="{{emai l ToAddr es s }}",

39 cc=None,

40 bcc=None,

41 s ubj ect ="Out put  of  wor kf l ow  {{r un\_i d}}", 

42 ht ml \_cont ent ="Res ul t s  f r om  l i ne  count :  t i . xcom\_pul l ( t as k\_i ds =' s hel l Act i on' ) ", 43 par ams =Pr oper t ySet ( conf i g=CONFI G,  j ob\_pr oper t i es =J OB\_PROPS) . mer ged,

44 )

45

46 #  Set  t he  t as k  dependenci es

47 s hel l Act i on  >>  l og\_act i on\_dat a  >>  s endEmai l    

Coordinator job conversion

The current scope of the Oozie to Airflow migration tool focuses primarily on workflow conversion. Support for Oozie coordinator job parsing and conversion is not included at this stage. However, this functionality is being considered for a future enhancement.

ODP-4311: Add coordinator job conversion support in O2A TO DO Job-xml (RESOLVED)

<a name="_page9_x31.50_y419.25"></a>Your Job-xml nodes will be loaded into the airflow worker and all itʼs current variables will be loaded in the airflow session as shown below

1 Si mpl eShel l Act i on  =  bas h. Bas hOper at or (

2 t as k\_i d="Si mpl eShel l Act i on",

3 t r i gger \_r ul e="one\_s ucces s ",

4 bas h\_command="""

5 #  Execut e  t he  s hel l  command

6 s h  echo{{  par ams . get ( ' pol i cymgr \_ur l ' )  }}

7 """,

8 par ams =Pr oper t ySet (

9 conf i g=CONFI G,

10 j ob\_pr oper t i es =J OB\_PROPS,

11 act i on\_node\_pr oper t i es =f unct i ons . ext r act \_pr oper t i es \_f r om\_j ob\_xml \_nodes ( 12 "hdf s : / / ai r f l owdemonode01. accel dat a. ce/ t mp/ hi ve- s i t e2. xml "

13 ) ,

14 ) . mer ged,

15 )

While this action node migration is now resolved, we still need to make sure that job-xml node does not contain any ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.048.png)variable references to our job.properties variables, as job.properties is mapped out to JOB\_PROPS in our converted DAG and is not accessible in params section.

i.e. the job-xml location should not be a variable.

Config resolution (RESOLVED)

In our Oozie workflow properties, we sometimes add configs that are dependent on other configs for their value. This variable resolution does not happen in airflow configs .

1 cat  j ob. pr oper t i es ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.049.png)2

3  dat aSour ce=et l
3  dat aNode=hdf s : / / t es t cl us t er . accel dat a. ce
3  ####Domai n/ Admi n  Di r ect or i es ####
3  USETLDat aRoot Di r =${dat aNode}/ pr oj ect s / l s r / et l / dat a/ ${dat aSour ce}
3  USETLI nges t Di r =hdf s : / / ${USETLDat aRoot Di r }/ i nges t

Instead, the variables referenced return the first variable value that they get , i.e. 

${dat aNode}/ pr oj ect s / l s r / et l / dat a/ ${dat aSour ce} for  USETLDat aRoot Di r , instead of ![](Aspose.Words.36c4333d-1e49-4c20-a116-9e11ef1f2da9.050.png)

hdf s : / / t es t cl us t er . accel dat a. ce/ pr oj ect s / l s r / et l / dat a/ et l , which is what the value should be.
