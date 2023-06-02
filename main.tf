data "aws_caller_identity" "current" {}

#this example create a role and a module using iamsr module
#iamsr
#iamsr_module
module "iamsr_module" {
    #module source
    source = "git::https://github.com/itau-corp/itau-ey4-modulo-iamsr.git?ref=1.1.2"

    #this property create a policy
    #and has 3 attributes
    #name, document, path
    iam_policies = [
        {
            name        = "iamsr-policy-01"
            document    = "iamsr/policy/iamsr-policy-01.json"
            path        = "/"
        },
        {
            name        = "iamsr-policy-02"
            document    = "iamsr/policy/iamsr-policy-02.json"
            path        = "/"
        }
    ]

    #this property create a role
    #and has 3 attributes
    #name, trust_policy_document, attached_policies
    iam_roles = [
        {
            name                  = "iamsr-role"
            trust_policy_document = "iamsr/trust/iamsr-trust.json"
            attached_policies     = [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/iamsr/iamsr-policy-01",
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/iamsr/iamsr-policy-02"
            ]
        }
    ]


}