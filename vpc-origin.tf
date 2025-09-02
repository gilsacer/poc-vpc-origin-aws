resource "aws_cloudfront_vpc_origin" "alb" {
  vpc_origin_endpoint_config {
    name = "poc-vpc-origin"
    ## arn alb
    arn                    = aws_lb.alb_webserver.arn
    http_port              = 80
    https_port             = 80
    origin_protocol_policy = "match-viewer"

    origin_ssl_protocols {
      items    = ["TLSv1.2"]
      quantity = 1
    }
  }
} 