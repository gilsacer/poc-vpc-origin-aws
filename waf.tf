# Create or reference existing AWS WAFv2 Web ACL with core protections, SQL injections, and rate limiting
resource "aws_wafv2_web_acl" "vpc_origin_cloudfront_waf" {
  provider    = aws.us_east_1
  name        = "waf-${var.project_name}-cloudfront-core-sql-rate-limit"
  scope       = "CLOUDFRONT"
  description = "WAF WebACL with core protections, SQLi, rate limiting"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "cloudfrontWAF"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "commonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "sqlRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "RateLimit1500Per5Min"
    priority = 3

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 1500
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rateLimit1500"
      sampled_requests_enabled   = true
    }
  }
}