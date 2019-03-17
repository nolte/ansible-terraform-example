# Test Project for the Ansible Terraform Module

[![Build Status](https://travis-ci.org/nolte/ansible-terraform-example.svg?branch=develop)](https://travis-ci.org/nolte/ansible-terraform-example)

## Testcase

| **TestCase** | **Description**                                                                                                | **Status 2.7.8** | **Status devel** | **Status mydevel** |
|--------------|----------------------------------------------------------------------------------------------------------------|------------------|------------------|--------------------|
| TC00         | No Parameters, only present and absent                                                                         | (/)              | (/)              | (/)                |
| TC10         | Using Parameter ```plan_file``` (Relative Path) ([#43405](https://github.com/ansible/ansible/issues/43405)     | (X)              | (/)              | (/)                |
| TC11         | Using Parameter ```plan_file``` (Absolut Path)                                                                 | (/)              | (X)              | (/)                |
| TC20         | Using Parameter ```state_file``` (Relative Path)                                                               | (X)              | (X)              | (/)                |
| TC21         | Using Parameter ```state_file``` (Absolut Path)  [#43407](https://github.com/ansible/ansible/issues/43407)     | (X)              | (X)              | (/)                |
| TC30         | Using Terraform Module Varialbe, type ```String```                                                             | (/)              | (/)              | (/)                |
| TC31         | Using Terraform Module Varialbe, type ```String```, Ansible Boolean                                            | (/)              | (/)              | (/)                |
| TC32         | Using Terraform Module Varialbe, type ```List``` ([#51687](https://github.com/ansible/ansible/issues/51687))   | (X)              | (X)              | (/)                |
| TC33         | Using Terraform Module Varialbe, type ```Map``` ([#51687 ]( https://github.com/ansible/ansible/issues/51687))  | (X)              | (X)              | (/)                |
| TC40         | Using Terraform Module with prepared ```plan_file```                                                           | (X)              | (X)              | (/)                |

Add more examples [#49115](https://github.com/ansible/ansible/issues/49115)

### Manual Terraform Command

 ```
example

 terraform init

 export TF_LOG=DEBUG && \
 export STATE_BASE_DIR=$(pwd)/../../state_outputs/manual && \
 export STATE_FILE=$STATE_BASE_DIR/terraform.tfstate && \
 export TF_LOG_PATH=$STATE_BASE_DIR/manual_terraform.log && \
 export PLAN_FILE=$STATE_BASE_DIR/plan/terraform.tfplan && \
 export OUTPUT_FILE=$(pwd)/../../test_module_output/manual.txt && \
 terraform plan -state=$STATE_FILE  -var "target_name=$OUTPUT_FILE" -out $PLAN_FILE && \
 terraform apply -state-out=$STATE_FILE $PLAN_FILE && \
 terraform destroy -state=$STATE_FILE -var "target_name=$OUTPUT_FILE" -auto-approve

 ```

## Handle Maps and Lists

GitHub Issue: [#51687](https://github.com/ansible/ansible/issues/51687)

Original code problem Line [terraform.py#L329](https://github.com/ansible/ansible/blob/devel/lib/ansible/modules/cloud/misc/terraform.py#L329)

Map And List Example Command line Parameter notation, [assigning-maps](https://learn.hashicorp.com/terraform/getting-started/variables.html#assigning-maps)
```
-var 'map_variable={ content = "myExample", target_name = "/tmp/test.txt" }'
-var='list_variable=["test 1", "test 2"]'
```

### Map Example

```
cd terraform_modules/example_map_parameter_module

terraform init

export TF_LOG=DEBUG && \
export STATE_BASE_DIR=$(pwd)/../../state_outputs/manual && \
export STATE_FILE=$STATE_BASE_DIR/terraform.tfstate && \
export TF_LOG_PATH=$STATE_BASE_DIR/manual_terraform.log && \
export PLAN_FILE=$STATE_BASE_DIR/plan/terraform.tfplan && \
export OUTPUT_FILE=$(pwd)/../../test_module_output/manual.txt && \
terraform plan -state=$STATE_FILE  -var 'map_variable={ content = "myExample", target_name = "/tmp/test.txt" }' -out $PLAN_FILE && \
terraform apply -state-out=$STATE_FILE $PLAN_FILE && \
terraform destroy -state=$STATE_FILE -var 'map_variable={ content = "myExample", target_name = "/tmp/test.txt" }' -auto-approve
```

```
export TF_LOG=DEBUG && \
export TF_LOG_PATH=$(pwd)/state_outputs/ansible/ansible_terraform.log && \
export STATE_FILE=$(pwd)/state_outputs/ansible && \
ansible-playbook playbook-execute-terraform-state_file_and_map.yml --extra-vars "state_target=$STATE_FILE" -vvv
```


## List parameter

```
cd terraform_modules/example_module_list

terraform init

export TF_LOG=DEBUG && \
export STATE_BASE_DIR=$(pwd)/../../state_outputs/manual && \
export STATE_FILE=$STATE_BASE_DIR/terraform.tfstate && \
export TF_LOG_PATH=$STATE_BASE_DIR/manual_terraform.log && \
export PLAN_FILE=$STATE_BASE_DIR/plan/terraform.tfplan && \
export OUTPUT_FILE=$(pwd)/../../test_module_output/manual.txt && \
terraform plan -state=$STATE_FILE  -var='target_name="/tmp/test.txt"' -var='list_variable=["test1","test2"]' -out $PLAN_FILE && \
terraform apply -state-out=$STATE_FILE $PLAN_FILE && \
terraform destroy -state=$STATE_FILE -var='target_name="/tmp/test.txt"' -var='list_variable=["test1","test2"]' -auto-approve
```

```
export TF_LOG=DEBUG && \
export STATE_BASE_DIR=$(pwd)/../../state_outputs/manual && \
export STATE_FILE=$STATE_BASE_DIR/terraform.tfstate && \
export TF_LOG_PATH=$STATE_BASE_DIR/manual_terraform.log && \
export PLAN_FILE=$STATE_BASE_DIR/plan/terraform.tfplan && \
export OUTPUT_FILE=$(pwd)/../../test_module_output/manual.txt && \
terraform plan -state=$STATE_FILE  -var='target_name="/tmp/test.txt"' -var='list_variable=["test 1", "test 2"]' -out $PLAN_FILE && \
terraform apply -state-out=$STATE_FILE $PLAN_FILE && \
terraform destroy -state=$STATE_FILE -var='target_name="/tmp/test.txt"' -var='list_variable=["test 1", "test 2"]' -auto-approve
```

```
export TF_LOG=DEBUG && \
export TF_LOG_PATH=$(pwd)/state_outputs/ansible/ansible_terraform.log && \
export STATE_FILE=$(pwd)/state_outputs/ansible && \
ansible-playbook playbook-execute-terraform-state_file_and_list.yml --extra-vars "state_target=$STATE_FILE" -vvv
```
