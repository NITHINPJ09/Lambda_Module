output "layer_arn" {
    value = aws_lambda_layer_version.existing_lambda_layer.arn
}