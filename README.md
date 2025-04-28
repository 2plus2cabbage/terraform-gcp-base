<img align="right" width="150" src="https://github.com/2plus2cabbage/2plus2cabbage/blob/main/images/2plus2cabbage.png">

<img src="https://github.com/2plus2cabbage/2plus2cabbage/blob/main/images/gcp-base.png" alt="gcp-base" width="300" align="left">
<br clear="left">

# GCP Windows Instance Terraform Deployment

Deploys a Windows Server 2022 VM in Google Cloud Platform (GCP) with RDP and internet access.

## Files
The project is split into multiple files to illustrate modularity and keep separate constructs distinct, making it easier to manage and understand.
- `main.tf`: Terraform provider block (`hashicorp/google`).
- `gcpprovider.tf`: GCP provider config with `project_id`, `region`, etc.
- `variables.tf`: Variables for project, region, etc.
- `terraform.tfvars.template`: Template for sensitive/custom values; rename to `terraform.tfvars` and add your credentials.
- `locals.tf`: Local variables for naming conventions.
- `gcp-networking.tf`: VPC, subnet, and networking CIDRs.
- `firewall.tf`: Firewall rules for RDP (TCP 3389) and outbound traffic.
- `windows.tf`: Windows VM, outputs public/private IPs.

## How It Works
- **Networking**: VPC and subnet provide connectivity. Public IP enables inbound/outbound traffic.
- **Security**: Allows RDP from your IP and all outbound traffic.
- **Instance**: Windows Server 2022 VM with public IP, firewall disabled via `metadata`.

## Prerequisites
- A GCP project with Compute Engine API enabled.
- A service account key, noting `project_id`, `region`, and path to the key file.
- Terraform installed on your machine.
- Examples are demonstrated using Visual Studio Code (VSCode).

## Deployment Steps
1. Update `terraform.tfvars` with GCP credentials and your public IP in `my_public_ip`.
2. Run `terraform init`, then (optionally) `terraform plan` to preview changes, then `terraform apply` (type `yes`).
3. Get the public IP from the `gcp_vm_public_ip` output on the screen, or run `terraform output gcp_vm_public_ip`, or check in the GCP Console under **Compute Engine > VM Instances**.
4. In the GCP Console, go to **Compute Engine > VM Instances > [click running instance]**, click **Set Windows Password**, enter a username (e.g., `Administrator` or a new user), click **Set**, and note the generated password.
5. Use Remote Desktop to log in with the username and the generated password.
6. To remove all resources, run `terraform destroy` (type `yes`).

## Potential costs and licensing
- The resources deployed using this Terraform configuration should generally incur minimal to no costs, provided they are terminated promptly after creation.
- It is important to fully understand your cloud provider's billing structure, trial periods, and any potential costs associated with the deployment of resources in public cloud environments.
- You are also responsible for any applicable software licensing or other charges that may arise from the deployment and usage of these resources.