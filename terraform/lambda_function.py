import boto3

def lambda_handler(event, context):
    client = boto3.client('ssm')
    parameter_source_access_key = client.get_parameter(Name='/lambda_secure_string/access_key', WithDecryption=True)
    source_access_key = parameter_source_access_key['Parameter']['Value']
    
    parameter_source_secret_access_key = client.get_parameter(Name='/lambda_secure_string/secret_access_key', WithDecryption=True)
    source_secret_access_key = parameter_source_secret_access_key['Parameter']['Value']

    running_instances = []
    ec2client = boto3.client('ec2',region_name='eu-west-1',aws_access_key_id=source_access_key,aws_secret_access_key=source_secret_access_key)
    response = ec2client.describe_instances()
    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            if instance['State']['Name'] == 'running':
                x = (instance["InstanceId"])
                running_instances.append(x)
                total_running_instances = len(running_instances)
    
    cloudwatch = boto3.client('cloudwatch',region_name='eu-west-1')
    response = cloudwatch.put_metric_data(
    MetricData = [
        {
            'MetricName': 'Instance Count',
            'Dimensions': [
                {
                    'Name': 'Instances',
                    'Value': 'Running'
                },
            ],
            'Unit': 'None',
            'Value': total_running_instances
        },
    ],
    Namespace = 'EC2 Monitoring For Running Instances'
    )
    