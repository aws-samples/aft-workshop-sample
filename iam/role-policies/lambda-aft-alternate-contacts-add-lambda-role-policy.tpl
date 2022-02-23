{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:${data_aws_region}:${data_aws_account_id}:parameter/aft/resources/ddb/aft-request-metadata-table-name",
            "Effect": "Allow",
            "Sid": "SSMOperations"
        },
        {
            "Action": [
                "dynamodb:GetItem",
                "dynamodb:Query"
            ],
            "Resource": [
                "arn:aws:dynamodb:${data_aws_region}:${data_aws_account_id}:table/${data_aft_request_metadata}",
                "arn:aws:dynamodb:${data_aws_region}:${data_aws_account_id}:table/${data_aft_request_metadata}/index/emailIndex"
            ],
            "Effect": "Allow",
            "Sid": "DynamoDBOperations"
        },
        {
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": [
                "${data_aft_request_metadata_kms_arn}"
            ],
            "Effect": "Allow",
            "Sid": "KMSOperations"
        },
        {
            "Action": [
                "account:PutAlternateContact"
            ],
            "Resource": [
                "arn:aws:account::${data_aws_ct_mgt_account_id}:account/${data_aws_ct_mgt_org_id}/*"
            ],
            "Effect": "Allow",
            "Sid": "AccountOperations"
        }
    ]
}