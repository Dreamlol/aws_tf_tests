provider "aws" {
  region = "eu-central-1"
  access_key = "AKIAJAEMX5RTIFSFQHKQ"
  secret_key = ""
}


## Implemantation 

resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name = "lambda_cron"
  description = "FooBar" 
  schedule_expression = "cron(0 ${var.hour} ? * MON-FRI *)"
#  schedule_expression = "cron(0 4 ? * MON-FRI *)"
  is_enabled = true
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  target_id = "FooBar_test"
  arn       = "arn:aws:lambda:eu-central-1:714739209329:function:test"
  rule      = "${aws_cloudwatch_event_rule.lambda_trigger.name}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "test"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.lambda_trigger.arn}"
}
