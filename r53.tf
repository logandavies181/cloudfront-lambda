resource "aws_route53_record" "cloudfront_alias" {
  zone_id = var.hosted_zone_id
  name    = local.fnqn
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}
