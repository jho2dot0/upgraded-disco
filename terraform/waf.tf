# commented out because of costs, but can be added back if we want to use WAF
/*resource "aws_wafv2_web_acl" "main" {
  name        = "main-waf-acl"
  description = "WAF Web ACL for CloudFront"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAF_Common_Protections"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAF_ACL"
    sampled_requests_enabled   = true
  }
}*/
