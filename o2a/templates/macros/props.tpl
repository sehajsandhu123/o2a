{#
  Copyright 2019 Google LLC

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
#}
{% macro props(action_node_properties, action_node_path=None, xml_escaped=False) -%}
{% if (action_node_properties is defined) and (action_node_properties | length != 0) -%}
    PropertySet(
        config=CONFIG,
        job_properties=JOB_PROPS,
        action_node_properties=functions.extract_properties_from_job_xml_nodes({{ action_node_path | to_python }})
        ).{% if xml_escaped %}xml_escaped.{% endif %}merged
{% else -%}
    PropertySet(
        config=CONFIG,
        job_properties=JOB_PROPS).{% if xml_escaped %}xml_escaped.{% endif %}merged
{% endif %}
{%- endmacro %}
