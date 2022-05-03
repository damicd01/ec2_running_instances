data "archive_file" "python_lambda_every_thirty_minutes" {  
    type = "zip"  
    source_file = "lambda_function.py" 
    output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "lambda_every_thirty_minutes" {
    function_name = "lambda_every_thirty_minutes"
    filename      = "lambda_function.zip"
    source_code_hash = data.archive_file.python_lambda_every_thirty_minutes.output_base64sha256
    role          = aws_iam_role.lambda_iam_role.arn
    runtime       = "python3.9"
    handler       = "lambda_function.lambda_handler"
    timeout       = 60
}

resource "aws_cloudwatch_event_rule" "lambda_every_thirty_minutes" {
    name = "lambda_every_thirty_minutes"
    description = "Fires every thirty minutes"
    schedule_expression = "rate(30 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_every_thirty_minutes" {
    rule = aws_cloudwatch_event_rule.lambda_every_thirty_minutes.name
    target_id = "lambda_every_thirty_minutes"
    arn = aws_lambda_function.lambda_every_thirty_minutes.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_every_thirty_minutes" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_every_thirty_minutes.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.lambda_every_thirty_minutes.arn
}