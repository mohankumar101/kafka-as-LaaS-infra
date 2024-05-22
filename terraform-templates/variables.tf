
/* VAR-PROB1 - The variable subnets have a repetition of availability zone values, however for effective and easy creation of subnet creation, I repeated them */
/* There is no reason to complicate variable definitions as below, but this is to give an idea of how to handle different variables in their respective order */

variable "serverconfig" {
    description = "Streaming Infra EC2 instance configuration"
    type = map(object({
        infra_region            = string
        infra_avail_zone        = string
        infra_env               = string
        zk_ec2_inst_type        = string
        zk_ec2_ensemble_size    = number
        kafka_ec2_inst_type     = string
        kafka_ec2_cluster_size  = number
        ec2_key_name            = string
        public_subnets          = string
        private_subnets         = string
  }))

    default = {
        streaming_infra = {
            infra_region            = "us-east-2"
            infra_avail_zone        = "us-east-2a"
            infra_env               = "prod"
            zk_ec2_inst_type        = "t2.micro"
            zk_ec2_ensemble_size    = 3
            kafka_ec2_inst_type     = "t2.small"
            kafka_ec2_cluster_size  = 3
            ec2_key_name            = "avmk-east-2"
            public_subnets          = "10.0.1.0/24"
            private_subnets         = "10.0.2.0/24"
            }
        }
}


variable "kafka_ingressports" {
    type = list(number)
    default = [22,8081,8082,8083,8088,9092,9093,2181]
}

variable "kafka_egressports" {
    type = list(number)
    default = [22,8081,8082,8083,8088,9092,9093,2181]
}

variable "zk_ingressports" {
    type = list(number)
    default = [22,2181,2888,3888]
}
variable "zk_egressports" {
    type = list(number)
    default = [22,2181,2888,3888]
}

