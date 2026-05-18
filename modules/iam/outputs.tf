output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name
}

output "s3_access_policy_arn" {
  value = length(aws_iam_policy.s3_access) > 0 ? aws_iam_policy.s3_access[0].arn : null
}
