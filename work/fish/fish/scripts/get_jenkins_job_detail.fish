#!/usr/bin/fish

function die
  echo $argv[1]
  exit 1
end

if test -n "$argv[1]"
  set jenkins_job_url $argv[1]
else
  die "Jenkins job url required"
end

set job_url (echo "$jenkins_job_url" | sd '(.*jenkins2\.sharpb2bcloud\.com\/(?:job\/[a-zA-Z0-9_\-\.]+[\/]?)+)([0-9]+)(?:[\/].*)?' '$1')
set job_short (echo "$jenkins_job_url" \
              | sd '.*jenkins2\.sharpb2bcloud\.com\/((?:job\/[a-zA-Z0-9_\-\.]+[\/]?)+)([0-9]+)(?:[\/].*)?' '$1' \
              | sd 'job\/' '' | sd '\/$' '')
set build_num (echo "$jenkins_job_url" | sd '.*jenkins2\.sharpb2bcloud\.com\/((?:job\/[a-zA-Z0-9_\-\.]+[\/]?)+)([0-9]+)(?:[\/].*)?' '$2')
set console_url "$job_url""$build_num/consoleFull"
echo "$job_url $job_short $build_num"

set api_url "$job_url""$build_num/api/json"

set build_json (curl -u "$jenkins_user:$jenkins_token" "$api_url")
# set build_json (jq . test.json)

set parameters (echo "$build_json" | jq '.actions[] | select(._class == "hudson.model.ParametersAction") | .parameters')
echo "$parameters" | jq '.[]'
set parameters_grouped (echo $parameters | jq '{
  checked: ([.[] | select(._class == "hudson.model.BooleanParameterValue" and .value == true)]),
  unchecked: ([.[] | select(._class == "hudson.model.BooleanParameterValue" and .value == false)]),
  string: ([.[] | select(._class != "hudson.model.BooleanParameterValue")])
}')
echo "$parameters_grouped" | jq '
  (.string[] | "Hello world!")
'
echo "<ul>"
echo "<li>Job: <a href=\"$job_url\">$job_short</a></li>"
echo "<li>Parameters"

echo "<ul>"

set string_length (echo "$parameters_grouped" | jq '.string | length')
if [ "$string_length" -ne 0 ]
  echo "$parameters_grouped" | jq -r '.string[] | "<li>" + .name + ": " + .value + "</li>"'
end

set checked_length (echo "$parameters_grouped" | jq '.checked | length')
if [ "$checked_length" -ne 0 ]
  echo "<li>Checked<ul>"
  echo "$parameters_grouped" | jq -r '.checked[] | "<li>" + .name + "</li>"'
  echo "</ul></li>"
end

set unchecked_length (echo "$parameters_grouped" | jq '.unchecked | length')
if [ "$unchecked_length" -ne 0 ]
  echo "<li>Unchecked<ul>"
  echo "$parameters_grouped" | jq -r '.unchecked[] | "<li>" + .name + "</li>"'
  echo "</ul></li>"
end
echo "</ul>"

echo "</li>"

echo "<li>Job: <a href=\"$console_url\">$build_num</a></li>"
echo "<li>Remarks:</li>"

echo "</ul>"
