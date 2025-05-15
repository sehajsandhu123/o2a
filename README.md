O2A documentation

> How to convert Workflows to DAGs System requirements
>
> Install O2A
>
> Structure of the application folder for workflows
>
> Bulk workflow conversion
>
> Shell Example Prerequisites
>
> Running
>
> Output
>
> Hive/Hive2 Example Prerequisites
>
> Running
>
> Output
>
> Known limitations
>
> Errors you might face
>
> HDFS Filepath exception
>
> HDFS File Paths in hiveconfs
>
> Hive DAG: Cannot modify \*\*\*.ctx.try_number at runtime
>
> Skeleton Transformation
>
> Decision Node
>
> Features that are not supported Oozie workflow EL Functions
>
> Coordinator job conversion

How to convert Workflows to DAGs

> System requirements
>
> Note that you need Python \>= 3.8 to run the converter.

Install O2A

First thing we need to do is build the required pip packages and install
it on all airflow workers and the node on which we are converting
workflows to DAGs

> 1 source /usr/odp/3.2.3.3-3/airflow/bin/activate
>
> 2 pip install o2a-acceldata
>
> 3 pip install o2a-lib-acceldata
>
> 4 pip install --upgrade wrapt

This is the full usage guide for o2a as shown below

> 1 (airflow) \[root@airflowdemonode01 o2a\]# ./bin/o2a -help
>
> 2
>
> 3 usage: o2a \[-h\] -i INPUT_DIRECTORY_PATH -o OUTPUT_DIRECTORY_PATH
> \[-n DAG_NAME\] \[-u USER\] \[-s START_DAYS_AGO\]
>
> \[-x SCHEMA_VERSION\] \[-skv SKIP_VALIDATION\]
>
> 4 \[-v SCHEDULE_INTERVAL\] \[-d\]
>
> 5
>
> 6 Convert Apache Oozie workflows to Apache Airflow workflows.
>
> 7 options:
>
> 8 -h, --help show this help message and exit
>
> 9 -i INPUT_DIRECTORY_PATH, --input-directory-path INPUT_DIRECTORY_PATH
>
> 10 Path to input directory
>
> 11 -o OUTPUT_DIRECTORY_PATH, --output-directory-path
> OUTPUT_DIRECTORY_PATH
>
> 12 Desired output directory
>
> 13 -n DAG_NAME, --dag-name DAG_NAME
>
> 14 Desired DAG name \[defaults to input directory name\]
>
> 15 -u USER, --user USER The user to be used in place of all
> \${user.name} \[defaults to user who ran the
>
> conversion\]
>
> 16 -s START_DAYS_AGO, --start-days-ago START_DAYS_AGO
>
> 17 Desired DAG start as number of days ago
>
> 18 -x SCHEMA_VERSION, --schema-version SCHEMA_VERSION
>
> 19 Desired Oozie all schema version.\[1.0,0.4\]
>
> 20 -skv SKIP_VALIDATION, --skip-validation SKIP_VALIDATION
>
> 21 skip validation
>
> 22 -v SCHEDULE_INTERVAL, --schedule-interval SCHEDULE_INTERVAL
>
> 23 Desired DAG schedule interval as number of days
>
> 24 -d, --dot Renders workflow files in DOT format

Structure of the application folder for workflows

The input application directory has to follow the structure defined as
follows:

> 1 \<APPLICATION\>/
>
> 2 \|- job.properties
>
> 3 \|- hdfs

\- job properties that are used to run the job

\- folder with application - should be copied to HDFS

> 4 \| \|- workflow.xml
>
> 5 \| \|- ...

\- Oozie workflow xml (1.0 schema)

\- additional folders required to be copied to HDFS

> 6 \|- configuration.template.properties - template of configuration
> values used during conversion
>
> 7 \|- configuration.properties - generated properties for
> configuration values

After the o2a installation is done, we can start converting our
workflows :-

> 1 ./bin/o2a -i ../oozie_sample/ -o airflow_sample/ -x 0.4 -skv true
>
> 2
>
> 3 \[2025-04-09T15:45:42.663+0530\] {workflow_xml_parser.py:242} INFO -
> Parsed EmailError as Action Node of type
>
> email.
>
> 4 \[2025-04-09T15:45:42.663+0530\] {workflow_xml_parser.py:81} INFO -
> Parsed fail as Kill Node.
>
> 5 \[2025-04-09T15:45:42.664+0530\] {workflow_xml_parser.py:81} INFO -
> Parsed Kill as Kill Node.
>
> 6 \[2025-04-09T15:45:42.664+0530\] {workflow_xml_parser.py:94} INFO -
> Parsed End as End Node.
>
> 7 \[2025-04-09T15:45:42.664+0530\] {oozie_converter.py:189} INFO -
> Applying pre-convert transformers
>
> 8 \[2025-04-09T15:45:42.664+0530\] {oozie_converter.py:125} INFO -
> Converting nodes to tasks and inner relations
>
> 9 \[2025-04-09T15:45:42.693+0530\] {oozie_converter.py:194} INFO -
> Applying post-convert transformers
>
> 10 \[2025-04-09T15:45:42.693+0530\] {oozie_converter.py:173} INFO -
> Adding error handlers
>
> 11 \[2025-04-09T15:45:42.693+0530\] {oozie_converter.py:155} INFO -
> Converting relations between tasks groups.
>
> 12 \[2025-04-09T15:45:42.693+0530\] {oozie_converter.py:150} INFO -
> Converting dependencies.
>
> 13 \[2025-04-09T15:45:42.694+0530\] {renderers.py:104} INFO - Saving
> to file: dishtioriginaljob2/.py
>
> 14 Fixing /root/o2a/dishtioriginaljob2/.py

After the conversion is completed you will get your DAG in the specified
folder

Bulk workflow conversion

If we wish to convert all jobs in a single go, we can use the
setup_o2a_bulk.sh script to convert our workflows to DAGs, to use it, we
basically just need to keep all our workflows in a single directory as
shown below

> 1 \<PARENT-DIR\>/
>
> 2 \|- workflow1
>
> 3 \|- workflow.xml. - - Oozie workflow xml
>
> 4 \|- configuration.properties
>
> 5 \|- job.properties
>
> 6 \|- workflow2
>
> 7 \|- workflow.xml - Oozie workflow xml
>
> 8 \|- configuration.properties
>
> 9 \|- job.properties
>
> 10 \|- ... - additional folders required to be copied to HDFS

The setup_o2a_bulk.sh will take care of setting up the workflow & itʼs
config files in the required input dir structure, which will be as shown
below

> 1 \[root@airflowdemonode01 o2a\]# bash setup_o2a_bulk.sh -f ~/bulk_job
>
> 2 \[2025-04-25 14:22:39\] \[INFO\] Starting conversion process for
> /root/bulk_job
>
> 3 \[2025-04-25 14:22:39\] \[INFO\] Created directory structure in
> /root/bulk_job_CONVERTED
>
> 4 \[2025-04-25 14:22:39\] \[WARN\] configuration.properties not found
>
> 5 \[2025-04-25 14:22:39\] \[INFO\] Processed subworkflow action:
> hive2_action
>
> 6 \[2025-04-25 14:22:39\] \[WARN\] configuration.properties not found
>
> 7 \[2025-04-25 14:22:39\] \[INFO\] Processed shell action:
> sehaj_errors_sample
>
> 8 \[2025-04-25 14:22:39\] \[INFO\] Setup completed for /root/bulk_job.
> You can now run ./run_o2a_bulk.sh to perform
>
> the conversion.
>
> 9 \[2025-04-25 14:22:39\] \[INFO\] Log files are stored in:
> /root/bulk_job_CONVERTED/logs
>
> 1 \<APPLICATION\>/
>
> 2 \|- job.properties
>
> 3 \|- hdfs

\- job properties that are used to run the job

\- folder with application - should be copied to HDFS

> 4 \| \|- workflow.xml
>
> 5 \| \|- ...

\- Oozie workflow xml (1.0 schema)

\- additional folders required to be copied to HDFS

> 6 \|- configuration.template.properties - template of configuration
> values used during conversion
>
> 7 \|- configuration.properties - generated properties for
> configuration values

after this structure is setup, we can start our conversion by using
run_o2a_bulk.sh :-

> 1 \[root@airflowdemonode01 o2a\]# ./run_o2a_bulk.sh
>
> 2 \[2025-04-25 14:22:45\] \[INFO\] Starting bulk conversion process
>
> 3 \[2025-04-25 14:22:45\] \[INFO\] Converting shell action:
> sehaj_errors_sample
>
> 4 \[2025-04-25 14:22:45\] \[INFO\] Input directory:
> /root/bulk_job_CONVERTED/shell_actions/sehaj_errors_sample
>
> 5 \[2025-04-25 14:22:45\] \[INFO\] Output directory:
> /root/bulk_job_CONVERTED/output/shell_sehaj_errors_sample
>
> 6 \[2025-04-25T14:23:40.819+0530\] {oozie_converter.py:173} INFO -
> Adding error handlers
>
> 7 \[2025-04-25T14:23:40.819+0530\] {oozie_converter.py:155} INFO -
> Converting relations between tasks groups.
>
> 8 \[2025-04-25T14:23:40.819+0530\] {oozie_converter.py:150} INFO -
> Converting dependencies.
>
> 9 \[2025-04-25T14:23:40.819+0530\] {renderers.py:104} INFO - Saving to
> file:
>
> /root/bulk_job_CONVERTED/output/shell_sehaj_errors_sample/sehaj_errors_sample.py
>
> 10 Fixing
> /root/bulk_job_CONVERTED/output/shell_sehaj_errors_sample/sehaj_errors_sample.py
>
> 11 \[2025-04-25 14:23:41\] \[INFO\] Conversion successful for
> sehaj_errors_sample
>
> 12 \[2025-04-25 14:23:44\] \[INFO\] Bulk conversion completed

After the conversion is completed you will get your DAG in the specified
folder ( bulk_job_CONVERTED in this case)

Shell Example

Prerequisites

Make sure to first copy examples/shell/configuration.template.properties
, rename it as configuration.properties and fill in with configuration
data.

Running

The Shell example can be run as:

> o2a -i examples/shell -o output/shell
>
> Alot of shell action jobs actually call bash scripts for spark/hive
> job execution , this bash script is often present in the hadoop file
> system and is executed in a yarn container . This is a core difference
> between oozie and airflow that an oozie workflow is executed in a yarn
> container in a specific job queue configured. While in airflow , the
> DAG is executed on the airflow worker itself, so it has no direct
> access to the HDFS file system itself, which leads us to copy the
> files over to our local working dir and execute them [O2A
> documentation and limitations \| HDFS script execution
> (RESOLVED)](https://accelcentral.atlassian.net/wiki/spaces/~62cb82c9bb346bdf82f9d5e6/pages/edit-v2/812613648#HDFS-script-execution-(RESOLVED))
> .

Output

In this example the output will be created in the ./output/shell/
folder.

The converted DAG uses the BashOperator in Airflow, which executes the
desired shell action on the airflow worker.

Hive/Hive2 Example

Prerequisites

Make sure to first copy /examples/hive/configuration.template.properties
, rename it as configuration.properties and fill in

with configuration data.

Running

The Hive example can be run as:

> o2a -i examples/hive -o output/hive

Output

In this example the output will be created in the ./output/hive/ folder.

The converted DAG uses the HiveOperator in Airflow & a default hive
connection id = hive_connection, you can see how to

configure this as shown in Known limitations.

Known limitations

There are few limitations in the implementation of the Oozie-To-Airflow
converter. It's not possible to write a converter that handles all cases
of complex workflows from Oozie because some of functionalities
available are not possible to map easily to existing Airflow Operators

Many of those limitations are not blockers - the workflows will still be
converted to Python DAGs and it should be possible to

manually (or automatically) post-process the DAGs to add custom
functionality. So even with those limitations in place you can still
save a ton of work when converting many Oozie workflows.

> Exit status not available (shell actions)

From the [Oozie
documentation](https://oozie.apache.org/docs/5.2.0/DG_ShellActionExtension.html):

> The output (STDOUT) of the Shell job can be made available to the
> workflow job after the Shell job ends. This information could be used
> from within decision nodes.

Currently we use the BashOperator which can store only the last line of
the job output in an XCOM. In this case the line is not helpful as it
relates to the Dataproc job submission status and not the Shell action's
result.

Issue in Github: [Finalize shell
mapper](https://github.com/GoogleCloudPlatform/oozie-to-airflow/issues/50)

> Not all global configuration methods are supported

Oozie implements a number of ways how configuration parameters are
passed to actions. Out of the existing configuration

options the following ones are not supported (but can be easily added as
needed):

> 1\. [The config-default.xml
> file](https://github.com/GoogleCloudPlatform/oozie-to-airflow/issues/137)
>
> 2\. [Parameters section of
> workflow.xml](https://github.com/GoogleCloudPlatform/oozie-to-airflow/issues/138)
>
> 3\. [Handle Global configuration
> properties](https://github.com/GoogleCloudPlatform/oozie-to-airflow/issues/134)
>
> No Shell launcher configuration (shell actions)

From the [Oozie
documentation](https://oozie.apache.org/docs/5.2.0/DG_ShellActionExtension.html):

> Shell launcher configuration can be specified with a file, using the
> job-xml element, and inline, using the configuration
>
> elements.

Currently there is no way specify the shell launcher configuration (it
is ignored).

Issue in Github: [Shell Launcher
Confi<u>g</u>uration](https://github.com/GoogleCloudPlatform/oozie-to-airflow/issues/340)

> Custom messages missing for Kill Node

The Kill Node might have custom log message specified. This is not
implemented, but will be taken up in future enhancements [Oozie
docs](https://oozie.apache.org/docs/5.2.0/WorkflowFunctionalSpec.html#a3.1.3_Kill_Control_Node)

> [ODP-4307: Add support for custom kill node messages in O2A TO
> DO](https://accelcentral.atlassian.net/browse/ODP-4307)
>
> Capturing output is not supported
>
> In several actions you can capture output from tasks. This is not yet
> implemented. [Example Oozie
> docs](https://oozie.apache.org/docs/5.2.0/WorkflowFunctionalSpec.html#a3.2.6_Java_Action)
>
> Only the connection to the local Hive instance is supported.

Connection configuration options are not supported.

> Not all elements are supported

For Hive, the following elements are not supported: job-tracker ,
name-node . For Hive2, the following elements are not supported:
job-tracker , name-node , jdbc-url , password .

The Github issue for both problems: [Hive connection configuration and
other
elements](https://github.com/GoogleCloudPlatform/oozie-to-airflow/issues/342),

Instead, we need to create a custom Hive connection in Airflow as shown
below

<img src="./dpofspgy.png"
style="width:5.37318in;height:3.29461in" />

> You might need to update your hive script variables: So variables such
> as \${INPUT} passed through hiveconf might not
>
> always resolve correctly, unless we add a hiveconf: prefix to them,
> especially in a Tez execution.

For e.g. :-

> 1 CREATE EXTERNAL TABLE test (a INT) STORED AS TEXTFILE LOCATION
> '\${INPUT}';
>
> 2 INSERT OVERWRITE DIRECTORY '\${OUTPUT}' SELECT \* FROM test;
>
> 3
>
> 4 These variables will get converted to
>
> 5
>
> 6 CREATE EXTERNAL TABLE test (a INT) STORED AS TEXTFILE LOCATION
> '\${hiveconf:INPUT}';
>
> 7 INSERT OVERWRITE DIRECTORY '\${hiveconf:OUTPUT}' SELECT \* FROM
> test;

Errors you might face

HDFS Filepath exception

> 1 \[2025-04-09T12:06:32.672+0530\] {oozie_converter.py:125} INFO -
> Converting nodes to tasks and inner relations
>
> 2 Traceback (most recent call last):
>
> 3 File "/root/finale/o2a/./bin/o2a", line 38, in \<module\>
>
> 4 o2a.o2a.main()
>
> 5 File "/root/finale/o2a/o2a/o2a.py", line 137, in main
>
> 6 converter.convert()
>
> 7 File "/root/finale/o2a/o2a/converter/oozie_converter.py", line 106,
> in convert
>
> 8 self.convert_nodes()
>
> 9 File "/root/finale/o2a/o2a/converter/oozie_converter.py", line 127,
> in convert_nodes
>
> 10 tasks, relations = oozie_node.mapper.to_tasks_and_relations()
>
> 11 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> 12 File "/root/finale/o2a/o2a/mappers/shell_mapper.py", line 119, in
> to_tasks_and_relations
>
> 13 prepare_task = self.prepare_extension.get_prepare_task()
>
> 14 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> 15 File
> "/root/finale/o2a/o2a/mappers/extensions/prepare_mapper_extension.py",
> line 40, in get_prepare_task
>
> 16 delete_paths, mkdir_paths = self.parse_prepare_node()
>
> 17 ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> 18 File
> "/root/finale/o2a/o2a/mappers/extensions/prepare_mapper_extension.py",
> line 67, in parse_prepare_node
>
> 19 node_path = normalize_path(node.attrib\["path"\],
> props=self.mapper.props)
>
> 20 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> 21 File "/root/finale/o2a/o2a/utils/el_utils.py", line 147, in
> normalize_path
>
> 22 raise ParseException(
>
> 23 o2a.converter.exceptions.ParseException: Unknown path format. The
> URL should be provided in the following
>
> format: hdfs://localhost:9200/path. Current value: {{
> params.get('USCCETLIngestDir') }}/{{
>
> params.get('USCCETLIngestDoneIndFile') }} None 0 {{
> params.get('USCCETLIngestDir') }}/{{
>
> params.get('USCCETLIngestDoneIndFile') }}

Add the variables that resolve to an hdfs location "\${tmpLocation}" to
resolve_name_node method in o2a/utils/el_utils.py

> 1 106 def \_resolve_name_node(translation: str, props: PropertySet)
> -\> Tuple\[Optional\[str\], int\]:
>
> 2 107 """
>
> 3 108 Check if props include nameNode, nameNode1 or nameNode2 value.
>
> 4 109 """
>
> 5 110 merged = props.merged
>
> 6 111 for key in \["nameNode", "nameNode1", "nameNode2", "dataNode",
> "tmpLocation""\]:
>
> 7 112 \#Add the variables that resolve to an hdfs location
> "\${tmpLocation}"
>
> 8 113 start_str = "{{" + ' params.get(\\'' + key + '\\') ' + "}}"
>
> 9 114 start_str_data_node = "\${" + ' params.get(\\'' + "dataNode" +
> '\\') ' + "}"
>
> 10 115 name_node = merged.get(key)
>
> 11 116 if translation.startswith(start_str) and name_node:
>
> 12 117 return name_node, len(start_str)
>
> 13 118 if translation.startswith(start_str_data_node) and name_node:
>
> 14 119 return name_node, len(start_str_data_node)
>
> 15 120 return None, 0

HDFS File Paths in hiveconfs

> Using HDFS File Paths in HiveOperator hiveconfs
>
> When using the HiveOperator in Apache Airflow, it's important to
> correctly format the HDFS file paths passed as Hive configuration
> variables ( hiveconfs ). Incorrect path references can lead to runtime
> errors during Hive query execution.
>
> 🚫 Problem:
>
> Users often pass HDFS paths dynamically via variables like
> JOB_PROPS\['user.name'\] or JOB_PROPS\['examplesRoot'\] , which may
> not resolve correctly at runtime, especially if the paths assume a
> different user context.
>
> For example:
>
> 1 hiveconfs={
>
> 2 "INPUT":
> f"/user/{JOB_PROPS\['user.name'\]}/examples/input-data/table",
>
> 3 "OUTPUT":
> f"/user/{JOB_PROPS\['user.name'\]}/{JOB_PROPS\['examplesRoot'\]}/output-data/hive2",
>
> 4 }
>
> If JOB_PROPS\['user.name'\] resolves to something other than airflow ,
> the query may fail with errors like:
>
> 1 Input path does not exist:
> hdfs://.../user/airflow/user/oozie/examples/input-data/table
>
> ✅ Recommended Fix:
>
> Explicitly construct your HDFS paths to align with the runtime context
> of the airflow user, since Airflow's Hive tasks often execute as that
> user.
>
> Use paths like:
>
> 1 hiveconfs={
>
> 2 "INPUT":
> "/user/airflow/examples/input-data/table",<img src="./sic0ntyj.png"
> style="width:5.36611in;height:1.414in" />
>
> 3 "OUTPUT": "/user/airflow/examples/output-data/hive2",
>
> 4 }
>
> Ensure that the input/output directories exist in HDFS under the
> correct user path ( /user/airflow/... ).

Hive DAG: Cannot modify \*\*\*.ctx.try_number at runtime

By default, HiveOperator includes all context variables in the hiveconf
. To enable airflow to pass these variables, you can

update the config shown below in your hive-site.xml

> 1 hive.security.authorization.sqlstd.confwhitelist.append =
> airflow.ctx.\*\|mapred.job.name\|INPUT\|OUTPUT

Skeleton Transformation

The O2A conversion supports several action and control nodes. The
control nodes include fork, join, start, end, and kill. Among

the action nodes, fs, map-reduce, and pig are supported.

Most of these are already handled, but when the program encounters a
node it does not know how to parse, it performs a kind of

"skeleton transformation" — converting all unknown nodes into dummy
nodes. This allows users to manually parse those nodes later if they
wish, as the control flow remains intact.

Decision Node

The decision node is not fully functional as there is not currently
support for all EL functions. So in order for it to run in Airflow you
may need to edit the Python output file and change the decision node
expression.

Issue in GitHub: [Implement decision
node](https://github.com/GoogleCloudPlatform/oozie-to-airflow/issues/42)

Features that are not supported

Oozie workflow EL Functions

Workflow functions are not supported. Instead of EL functions, the user
will have to use Airflow xcoms feature for passing

variables between different actions in a workflow.

this will be taken up as a future enhancement and more workflow
functions will be added to O2A. ( [ODP-4308: Add support
for](https://accelcentral.atlassian.net/browse/ODP-4308)

> [oozie wf functions in O2A TO
> DO](https://accelcentral.atlassian.net/browse/ODP-4308) )

For eg, For this workflow

> 1 \<workflow-app name="WorkFlowForShellActionWithCaptureOutput"
> xmlns="uri:oozie:workflow:1.0"\>
>
> 2 \<start to="shellAction"/\>
>
> 3 \<action name="shellAction"\>
>
> 4 \<shell xmlns="uri:oozie:shell-action:1.0"\>
>
> 5 \<job-tracker\>\${jobTracker}\</job-tracker\>
>
> 6 \<name-node\>\${nameNode}\</name-node\>
>
> 7 \<configuration\>
>
> 8 \<property\>
>
> 9 \<name\>mapred.job.queue.name\</name\>
>
> 10 \<value\>\${queueName}\</value\>
>
> 11 \</property\>
>
> 12 \</configuration\>
>
> 13 \<exec\>\${lineCountShellScript}\</exec\>
>
> 14 \<argument\>\${inputDir}\</argument\>
>
> 15 \<file\>\${lineCountShScriptPath}#\${lineCountShellScript}\</file\>
>
> 16 \<capture-output/\>
>
> 17 \</shell\>
>
> 18 \<ok to="sendEmail"/\>
>
> 19 \<error to="killAction"/\>
>
> 20 \</action\>
>
> 21 \<action name="sendEmail"\>
>
> 22 \<email xmlns="uri:oozie:email-action:0.2"\>
>
> 23 \<to\>\${emailToAddress}\</to\>
>
> 24 \<subject\>Output of workflow \${wf:id()}\</subject\>
>
> 25 \<body\>Results from line count:
> \${wf:actionData('shellAction')\['NumberOfLines'\]}\</body\>
>
> 26 \</email\>
>
> 27 \<ok to="end"/\>
>
> 28 \<error to="end"/\>
>
> 29 \</action\>
>
> 30 \<kill name="killAction"\>
>
> 31 \<message\>"Killed job due to error"\</message\>
>
> 32 \</kill\>
>
> 33 \<end name="end"/\>
>
> 34 \</workflow-app\>

We get the below DAG

> 1 \# Define a function to log the shell action data
>
> 2 def log_shell_action_data(\*\*context):
>
> 3 ti = context\['ti'\]
>
> 4 shell_output = ti.xcom_pull(task_ids='shellAction')
>
> 5 logger.info("Output of shellAction: %s", shell_output)
>
> 6 \# Process the shell_output as needed
>
> 7 return "Logging completed"
>
> 8
>
> 9 with models.DAG(
>
> 10 "sample_shell_oozie_2",
>
> 11 schedule_interval=None,
>
> 12 start_date=dates.days_ago(0),
>
> 13 user_defined_macros=TEMPLATE_ENV,
>
> 14 ) as dag:
>
> 15 shellAction = bash.BashOperator(
>
> 16 task_id="shellAction",
>
> 17 trigger_rule="one_success",
>
> 18 bash_command=("hdfs dfs -cat
>
> hdfs://testcluster.acceldata.ce/user/oozie/workflowShellAction/lineCount.sh
> \| bash -s
>
> hdfs://testcluster.acceldata.ce/user/oozie/text.txt"),
>
> 19 do_xcom_push=True,
>
> 20 params=PropertySet(
>
> 21 config=CONFIG,
>
> 22 job_properties=JOB_PROPS,
>
> 23 action_node_properties={"mapred.job.queue.name": "default"},
>
> 24 ).merged,
>
> 25 )
>
> 26
>
> 27 \# Log the action data
>
> 28 log_action_data = PythonOperator(
>
> 29 task_id="log_action_data",
>
> 30 python_callable=log_shell_action_data,
>
> 31 provide_context=True,
>
> 32 dag=dag,
>
> 33 )
>
> 34
>
> 35 sendEmail = email.EmailOperator(
>
> 36 task_id="sendEmail",
>
> 37 trigger_rule="one_success",
>
> 38 to="{{emailToAddress}}",
>
> 39 cc=None,
>
> 40 bcc=None,
>
> 41 subject="Output of workflow {{run_id}}",
>
> 42 html_content="Results from line count:
> ti.xcom_pull(task_ids='shellAction')",
>
> 43 params=PropertySet(config=CONFIG, job_properties=JOB_PROPS).merged,
>
> 44 )
>
> 45
>
> 46 \# Set the task dependencies
>
> 47 shellAction \>\> log_action_data \>\> sendEmail

Coordinator job conversion

The current scope of the Oozie to Airflow migration tool focuses
primarily on workflow conversion. Support for Oozie coordinator

job parsing and conversion is not included at this stage. However, this
functionality is being considered for a future enhancement.

> [ODP-4311: Add coordinator job conversion support in O2A TO
> DO](https://accelcentral.atlassian.net/browse/ODP-4311)

Job-xml (RESOLVED)

Your Job-xml nodes will be loaded into the airflow worker and all itʼs
current variables will be loaded in the airflow session as

shown below

> 1 SimpleShellAction = bash.BashOperator(
>
> 2 task_id="SimpleShellAction",
>
> 3 trigger_rule="one_success",
>
> 4 bash_command="""
>
> 5 \# Execute the shell command
>
> 6 sh echo{{ params.get('policymgr_url') }}
>
> 7 """,
>
> 8 params=PropertySet(
>
> 9 config=CONFIG,
>
> 10 job_properties=JOB_PROPS,
>
> 11
> action_node_properties=functions.extract_properties_from_job_xml_nodes(
>
> 12 "hdfs://airflowdemonode01.acceldata.ce/tmp/hive-site2.xml"
>
> 13 ),
>
> 14 ).merged,
>
> 15 )
>
> While this action node migration is now resolved, we still need to
> make sure that job-xml node does not contain any
>
> variable references to our job.properties variables, as job.properties
> is mapped out to JOB_PROPS in our converted DAG and is not accessible
> in params section.
>
> i.e. the job-xml location should not be a variable.

Config resolution (RESOLVED)

In our Oozie workflow properties, we sometimes add configs that are
dependent on other configs for their value. This variable

resolution does not happen in airflow configs .

> 1 cat job.properties
>
> 2
>
> 3 dataSource=etl
>
> 4 dataNode=hdfs://testcluster.acceldata.ce
>
> 5 \####Domain/Admin Directories####
>
> 6 USETLDataRootDir=\${dataNode}/projects/lsr/etl/data/\${dataSource}
>
> 7 USETLIngestDir=hdfs://\${USETLDataRootDir}/ingest

Instead, the variables referenced return the first variable value that
they get , i.e.

> \${dataNode}/projects/lsr/etl/data/\${dataSource} for USETLDataRootDir
> , instead of hdfs://testcluster.acceldata.ce/projects/lsr/etl/data/etl
> , which is what the value should be.
