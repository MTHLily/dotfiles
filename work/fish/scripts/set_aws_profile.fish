#!/usr/bin/fish 

if test -n $argv[1]
    set AWS_PROFILE $argv[1]
else
    set AWS_PROFILE slabst
end

set -Ux AWS_PROFILE $AWS_PROFILE
set -Ux AWS_ACCESS_KEY_ID (aws configure get aws_access_key_id --profile $AWS_PROFILE)
set -Ux AWS_SECRET_ACCESS_KEY (aws configure get aws_secret_access_key --profile $AWS_PROFILE)
