# Get the predefined CloudFront cache policy for UseOriginCacheHeaders + Query Strings
# The AWS managed policy ARN for this cache policy is:
# UseOriginCacheHeaders-QueryStrings = bpff7f49-aace-4e4b-9a7d-191f2aebc5dd
data "aws_cloudfront_cache_policy" "use_origin_cache_control" {
  name = "UseOriginCacheControlHeaders-QueryStrings"
}

# Create the CloudFront distribution with your VPC origin and other requirements
resource "aws_cloudfront_distribution" "vpc_origin_distribution" {
  enabled             = true
  comment             = "CloudFront distribution with VPC Origin and WAF"
  price_class         = "PriceClass_100" # adjust pricing if needed
  wait_for_deployment = true

  aliases = ["teste-vpc.bspcloud.com"]

  origin {
    domain_name = aws_lb.alb_webserver.dns_name
    origin_id   = aws_cloudfront_vpc_origin.alb.id

    vpc_origin_config {
      origin_keepalive_timeout = 5
      origin_read_timeout      = 30
      vpc_origin_id            = aws_cloudfront_vpc_origin.alb.id
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]

    cached_methods = ["GET", "HEAD", "OPTIONS"]

    target_origin_id = aws_cloudfront_vpc_origin.alb.id

    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id = data.aws_cloudfront_cache_policy.use_origin_cache_control.id

    compress = true

    # Forward query strings as required by the cache policy
    # query_string_cache_keys not needed, since cache policy handles
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:${data.aws_region.current}:${data.aws_caller_identity.current.account_id}:certificate/917dcbba-a697-49a8-9b32-05208b6779d7"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["BR"] # Brazil only
    }
  }

  web_acl_id = aws_wafv2_web_acl.vpc_origin_cloudfront_waf.arn

  logging_config {
    bucket = "teste-cloudfront-logging.s3.amazonaws.com"
    prefix = "teste-vpc-origin/"
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-cloudfront-distribution"
    }
  )

}