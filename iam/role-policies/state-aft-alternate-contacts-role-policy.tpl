{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": [
                "arn:aws:lambda:${data_aws_region}:${data_aws_account_id}:function:aft-alternate-contacts-*:*"
            ]
        }
    ]
}
