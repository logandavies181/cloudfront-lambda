locals {
  fnqn = "${var.subdomain_name}.${var.domain_name}"

  cf_origin = replace(
    replace(
      aws_lambda_function_url.fn_url.function_url, "https://", ""
    ), "/", "",
  )
}
