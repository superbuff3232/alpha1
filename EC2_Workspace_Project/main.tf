provider "aws" {
    region = "us-east-2"
    // data removed 
}

module "sg_module" {
	source = "./sg_module"
}

module "ec2_module_1" {
	sg_id = "${module.sg_module.sg_id_output}"
	source = "./ec2_module"
}

locals {
	env = "${terraform.workspace}"

amiid_env {
	 	default = "amiid_default"
	 	staging = "amiid_staging"
		production = "amiid_production"
	}
	amiid = "${lookup(local.amiid_env, local.env)}"
}

output "envspecificoutput_variable"{
	value = "${local.amiid}"
}


// When creating a new workspace the followoning command needs to run
// Terraform workspace new <name_of_workpace> E.G. terraform workspace new staging
// To see all the workspaces created use >>  terraform workspace list
// Switch between workspaces use >> terraform workspace select <name_of_workpace>