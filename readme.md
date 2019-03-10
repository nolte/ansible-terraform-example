# Test Project for the Ansible Terraform Module

## Testcase

  Handle Terraform Needet files outside the Module Directory.
  This is a TestProject for [Ansible Issue #43405](https://github.com/ansible/ansible/issues/43405)

### Manual Terraform Command

 ```
 cd terraform_modules/example_module

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

### Execute Ansible Playbook

```
pip install --upgrade git+https://github.com/nolte/ansible.git@fix/terraform-relative-stat-path-43405
```

```
export TF_LOG=DEBUG && \
export TF_LOG_PATH=$(pwd)/state_outputs/ansible/ansible_terraform.log && \
export STATE_FILE=$(pwd)/state_outputs/ansible/ && \
ansible-playbook playbook-execute-terraform-state_file.yml --extra-vars "state_target=$STATE_FILE" -vvv
```
