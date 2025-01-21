# Terraform-datadog
Create 2 standalone instances using terraform <br />
Install datadog-agent on top of that <br />
Get it monitored in Datadog monitor and dashboard <br />

# Steps to perform:
1. clone the repo <br />
2. Update tfvar file with aws_access_key, aws_secret_key, datadog_api_key, datadog_app_key, key_name, private_key_path <br />
3. terraform init, terraform validate, terraform plan, terraform apply
4. Configure the monitor on Datadog platform and create the alert for exceeding the average load above 3.0 (CPU utilization >= 50%) 
